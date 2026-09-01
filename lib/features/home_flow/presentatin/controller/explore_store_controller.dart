import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../services/api/api_service.dart';
import '../../../../utils/constants/api_enpoint.dart';
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
  void onInit() {
    super.onInit();
    fetchCities();
    fetchStores();
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
    selectedCity.value = newCity;
    fetchStores();
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
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
}