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

  var isBannerLoading = false.obs;
  var bannerList = <Data>[].obs;

  Future<void> getBanners() async {
    try {
      isBannerLoading.value = true;
      final response = await ApiService.get(ApiEndPoint.banner);

      if (response.isSuccess) {
        Banner_model bannerModel = Banner_model.fromJson(
          response.data as Map<String, dynamic>,
        );
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
        CityModel model = CityModel.fromJson(
          response.data as Map<String, dynamic>,
        );
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

      String endpoint = ApiEndPoint.userAds;
      List<String> queryParams = [];

      if (selectedCityName.value.isNotEmpty &&
          selectedCityName.value != "Choose city") {
        queryParams.add("city=${Uri.encodeComponent(selectedCityName.value)}");
      }

      if (selectedLatitude != null && selectedLongitude != null) {
        queryParams.add("longitude=$selectedLongitude");
        queryParams.add("latitude=$selectedLatitude");
      }

      if (queryParams.isNotEmpty) {
        endpoint += "?${queryParams.join('&')}";
      }

      final response = await ApiService.get(
        endpoint,
        header: {
          'Authorization': 'Bearer ${LocalStorage.token}',
          'Content-Type': 'application/json',
        },
      );

      if (response.isSuccess) {
        featuresModel model = featuresModel.fromJson(
          response.data as Map<String, dynamic>,
        );
        featuredList.value = model.data ?? [];
      } else {
        featuredList.clear();
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
