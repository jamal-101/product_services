import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
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

  @override
  void onClose() {
    bannerPageController.dispose();
    super.onClose();
  }
}