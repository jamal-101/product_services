import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../services/api/api_service.dart';
import '../../../../utils/constants/api_enpoint.dart';
import '../../../profile_section/presentation/controller/profile_controller.dart';
import '../model/product_city_model.dart';
import '../model/product_store_model.dart';
import '../model/service_store_model.dart';


enum StoreRating { one, two, three, four, five }

class ExploreStoreController extends GetxController {
  var isLoading = false.obs;
  var cityList = <ProductCityData>[].obs;

  var productStoreList = <StoreData>[].obs;
  var serviceStoreList = <ServiceStoreData>[].obs;

  var selectedCity = "".obs;
  var searchQuery = "".obs;
  var isOpenNow = false.obs;
  var selectedRatingEnum = Rxn<StoreRating>();

  var isProductStoreSelected = true.obs;
  var isListViewSelected = true.obs;
  var currentNavIndex = 0.obs;


  @override
  @override
  void onInit() {
    super.onInit();

    // searchQuery পরিবর্তন হলে ৩০০ মিলি-সেকেন্ড পর অটোমেটিক fetchStores() কল হবে
    debounce(
      searchQuery,
          (_) => fetchStores(),
      time: const Duration(milliseconds: 400),
    );

    fetchCities();
    fetchStores();
    initCityFromProfileOnly();
  }


  void initCityFromProfileOnly() {
    final profileController = Get.isRegistered<ProfileController>()
        ? Get.find<ProfileController>()
        : Get.put(ProfileController());

    var profileData = profileController.profileModel.value.data;
    if (profileData != null) {
      String userCity = profileData.state ?? profileData.address ?? profileData.location?.address ?? "";
    }

    ever(profileController.profileModel, (profileModel) {
      var data = profileModel.data;
      if (data != null && selectedCity.value.isEmpty) {
        String cityFromProfile = data.state ?? data.address ?? data.location?.address ?? "";
        if (cityFromProfile.isNotEmpty) {
          // selectedCity.value = cityFromProfile;
        }
      }
    });
  }

  void initCityFromProfileAndFetchStores() {
    final profileController = Get.isRegistered<ProfileController>()
        ? Get.find<ProfileController>()
        : Get.put(ProfileController());

    var profileData = profileController.profileModel.value.data;
    if (profileData != null) {
      String userCity = profileData.state ?? profileData.address ?? profileData.location?.address ?? "";
      if (userCity.isNotEmpty) {
        selectedCity.value = userCity;
      }
    }

    fetchStores();

    ever(profileController.profileModel, (profileModel) {
      var data = profileModel.data;
      if (data != null && selectedCity.value.isEmpty) {
        String cityFromProfile = data.state ?? data.address ?? data.location?.address ?? "";
        if (cityFromProfile.isNotEmpty) {
          selectedCity.value = cityFromProfile;
          fetchStores();
        }
      }
    });
  }

  Future<void> fetchCities() async {
    try {
      var response = await ApiService.get(ApiEndPoint.cityAdConfigurationsAdmin);

      if (response.statusCode == 200) {
        ProductCityModel model = ProductCityModel.fromJson(
          response.data as Map<String, dynamic>,
        );
        cityList.value = model.data ?? [];
        debugPrint("Cities fetched successfully: ${cityList.length}");
      }
    } catch (e) {
      debugPrint("Error fetching cities: $e");
    }
  }

  Future<void> fetchStores() async {
    try {
      isLoading.value = true;

      String storeType = isProductStoreSelected.value ? 'product_store' : 'service_store';

      Map<String, dynamic> queryParams = {
        'storeType': storeType,
      };

      if (searchQuery.value.isNotEmpty) {
        queryParams['searchTerm'] = searchQuery.value;
      }
      if (selectedCity.value.isNotEmpty && selectedCity.value != "All Cities") {
        queryParams['city'] = selectedCity.value;
      }
      if (isOpenNow.value) {
        queryParams['openNow'] = 'true';
      }
      if (selectedRatingEnum.value != null) {
        int ratingValue = selectedRatingEnum.value!.index + 1;
        queryParams['rating'] = ratingValue.toString();
      }

      final uri = Uri.parse(ApiEndPoint.stores).replace(
        queryParameters: queryParams.map((key, value) => MapEntry(key, value.toString())),
      );

      var response = await ApiService.get(uri.toString());

      if (response.statusCode == 200) {
        if (isProductStoreSelected.value) {
          ProductStoreModel model = ProductStoreModel.fromJson(response.data as Map<String, dynamic>);
          productStoreList.value = model.data ?? [];
        } else {
          ServiceStoreModel model = ServiceStoreModel.fromJson(response.data as Map<String, dynamic>);
          serviceStoreList.value = model.data ?? [];
        }
      }
    } catch (e) {
      debugPrint("Error fetching stores: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void toggleStoreType(bool isProduct) {
    isProductStoreSelected.value = isProduct;
    fetchStores();
  }

  void toggleView(bool isList) {
    isListViewSelected.value = isList;
  }



  void updateCity(String newCity) {
    if (newCity == "All Cities") {
      selectedCity.value = "";
    } else {
      selectedCity.value = newCity;
    }
    fetchStores();
  }

  // void updateSearchQuery(String query) {
  //   searchQuery.value = query;
  //   fetchStores();
  // }

  void updateSearchQuery(String query) {
    searchQuery.value = query.trim();
    fetchStores();
  }


  void toggleOpenNow() {
    isOpenNow.value = !isOpenNow.value;
    fetchStores();
  }

  void updateRating(String rating) {
    switch (rating) {
      case '1': selectedRatingEnum.value = StoreRating.one; break;
      case '2': selectedRatingEnum.value = StoreRating.two; break;
      case '3': selectedRatingEnum.value = StoreRating.three; break;
      case '4': selectedRatingEnum.value = StoreRating.four; break;
      case '5': selectedRatingEnum.value = StoreRating.five; break;
      default: selectedRatingEnum.value = null;
    }
    fetchStores();
  }

  void changeNavIndex(int index) {
    currentNavIndex.value = index;
  }



  // toggleStoreFavorite method updated for better reactivity
  Future<void> toggleStoreFavorite(String storeId, bool isProductStore, int index) async {
    final bool previousFavoriteState;

    if (isProductStore) {
      if (index < 0 || index >= productStoreList.length) return;
      previousFavoriteState = productStoreList[index].isFavorite ?? false;
      
      // Update locally
      var updatedItem = productStoreList[index];
      updatedItem.isFavorite = !previousFavoriteState;
      productStoreList[index] = updatedItem; 
      productStoreList.refresh();
    } else {
      if (index < 0 || index >= serviceStoreList.length) return;
      previousFavoriteState = serviceStoreList[index].isFavorite ?? false;
      
      // Update locally
      var updatedItem = serviceStoreList[index];
      updatedItem.isFavorite = !previousFavoriteState;
      serviceStoreList[index] = updatedItem;
      serviceStoreList.refresh();
    }

    try {
      final body = {
        "targetId": storeId,
        "targetType": isProductStore ? "product_store" : "service_store",
      };

      final response = await ApiService.post(
        ApiEndPoint.favoritesToggle,
        body: body,
      );

      if (response.isSuccess) {
        final responseData = response.data;
        if (responseData is Map<String, dynamic>) {
          final dynamic innerData = responseData['data'];
          bool? serverStatus;

          if (innerData is Map<String, dynamic>) {
            serverStatus = innerData['isFavorited'] ?? innerData['isFavorite'];
          } else {
            serverStatus = responseData['isFavorited'] ?? responseData['isFavorite'];
          }

          if (serverStatus != null) {
            if (isProductStore) {
              var updatedItem = productStoreList[index];
              updatedItem.isFavorite = serverStatus;
              productStoreList[index] = updatedItem;
              productStoreList.refresh();
            } else {
              var updatedItem = serviceStoreList[index];
              updatedItem.isFavorite = serverStatus;
              serviceStoreList[index] = updatedItem;
              serviceStoreList.refresh();
            }
          }
        }
      } else {
        // Rollback on Failure
        _rollbackFavoriteState(isProductStore, index, previousFavoriteState);
      }
    } catch (e) {
      // Rollback on Exception
      _rollbackFavoriteState(isProductStore, index, previousFavoriteState);
    }
  }


  void _rollbackFavoriteState(bool isProductStore, int index, bool previousState) {
    if (isProductStore) {
      if (index < productStoreList.length) {
        var updatedItem = productStoreList[index];
        updatedItem.isFavorite = previousState;
        productStoreList[index] = updatedItem;
        productStoreList.refresh();
      }
    } else {
      if (index < serviceStoreList.length) {
        var updatedItem = serviceStoreList[index];
        updatedItem.isFavorite = previousState;
        serviceStoreList[index] = updatedItem;
        serviceStoreList.refresh();
      }
    }
  }


  void handleBookmarkTap(String storeId, int index) {
    bool isProduct = isProductStoreSelected.value;
    toggleStoreFavorite(storeId, isProduct, index);
  }

}
