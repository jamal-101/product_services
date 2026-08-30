import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../services/api/api_service.dart';
import '../../../../services/storage/storage_service.dart';
import '../../../../utils/constants/api_enpoint.dart';
import '../model/banner_model.dart';
import '../model/city_model.dart';
import '../model/features_model.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getBanners();
    fetchCities();
    fetchFeaturedStores();
  }
  var currentNavIndex = 0.obs;
  var currentBannerIndex = 0.obs;
  final PageController bannerPageController = PageController();
  var selectedStoreTab = 0.obs;
  var recentSearches = <String>[
    "Samsung Galaxy S24 Ultra",
    "Coca-Cola Classic 2L",
  ].obs;
  var selectedCity = "Madrid".obs;
  void updateCity(String newCity) {
    selectedCity.value = newCity;
  }
  void changeNavIndex(int index) {
    currentNavIndex.value = index;
  }
  void removeSearchItem(int index) {
    recentSearches.removeAt(index);
  }
  void clearAllSearch() {
    recentSearches.clear();
  }
  var isProductStoreSelected = true.obs;
  void toggleStoreType(bool isProduct) {
    isProductStoreSelected.value = isProduct;
  }
  var isListViewSelected = true.obs;
  void toggleView(bool isList) {
    isListViewSelected.value = isList;
  }


  var isBannerLoading = false.obs;
  var bannerList = <Data>[].obs;

  Future<void> getBanners() async {
    try {
      isBannerLoading.value = true;
      final response = await ApiService.get(ApiEndPoint.banner);

      if (response.isSuccess) {
        Banner_model bannerModel = Banner_model.fromJson(response.data as Map<String, dynamic>);
        if (bannerModel.data != null) {
          bannerList.value = bannerModel.data!;
        }
      }
    } catch (e) {
      debugPrint("Error fetching banners: $e");
    } finally {
      isBannerLoading.value = false;
    }
  }


  var featuredList = <FeaturedData>[].obs;
  var isFeaturedLoading = false.obs;

  var cityList = <CityData>[].obs;
  var isCityLoading = false.obs;
  var selectedCityName = "Choose city".obs;

  double? selectedLatitude;
  double? selectedLongitude;


  Future<void> fetchCities() async {
    try {
      isCityLoading.value = true;

      final response = await ApiService.get(
        ApiEndPoint.activeCities,
        header: {
          'Authorization': 'Bearer ${LocalStorage.token}',
          'Content-Type': 'application/json',
        },
      );

      if (response.isSuccess) {
        CityModel model = CityModel.fromJson(response.data as Map<String, dynamic>);
        if (model.data != null) {
          cityList.value = model.data!;
        }
      }
    } catch (e) {
      debugPrint("Error fetching cities: $e");
    } finally {
      isCityLoading.value = false;
    }
  }

  void onCitySelected(CityData cityData) {
    selectedCityName.value = cityData.city ?? "Choose city";
    selectedLatitude = cityData.latitude;
    selectedLongitude = cityData.longitude;
    fetchFeaturedStores();
  }

  Future<void> fetchFeaturedStores() async {
    try {
      isFeaturedLoading.value = true;

      String endpoint = "/advertisements/user-ads";

      if (selectedLatitude != null && selectedLongitude != null) {
        endpoint += "?longitude=$selectedLongitude&latitude=$selectedLatitude";
      }

      final response = await ApiService.get(endpoint);

      if (response.isSuccess) {
        featuresModel model = featuresModel.fromJson(response.data as Map<String, dynamic>);
        featuredList.value = model.data ?? [];
      }
    } catch (e) {
      debugPrint("Error fetching featured stores: $e");
    } finally {
      isFeaturedLoading.value = false;
    }
  }



  @override
  void onClose() {
    bannerPageController.dispose();
    super.onClose();
  }
}