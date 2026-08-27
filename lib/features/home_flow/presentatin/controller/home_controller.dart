import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/api/api_service.dart';
import '../../../../utils/constants/api_enpoint.dart';
import '../model/banner_model.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getBanners(); // স্ক্রিন লোড হওয়ার সাথেই ব্যানার ফেচ করবে
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
      print("Error fetching banners: $e");
    } finally {
      isBannerLoading.value = false;
    }
  }

  @override
  void onClose() {
    bannerPageController.dispose();
    super.onClose();
  }
}