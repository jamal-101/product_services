import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  // Bottom Navigation Bar Index
  var currentNavIndex = 0.obs;

  // Home Banner PageView Index
  var currentBannerIndex = 0.obs;
  final PageController bannerPageController = PageController();

  // Featured Stores Tab Index (0 = Products Stores, 1 = Services Providers)
  var selectedStoreTab = 0.obs;

  // Search History List
  var recentSearches = <String>[
    "Samsung Galaxy S24 Ultra",
    "Coca-Cola Classic 2L",
  ].obs;

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

  // ⚡ টগল চেঞ্জ করার মেথড (এটি যোগ করুন)
  void toggleStoreType(bool isProduct) {
    isProductStoreSelected.value = isProduct;
  }

  // ভেরিয়েবল: লিস্ট ভিউ নাকি ম্যাপ ভিউ সেটি ট্র্যাক করবে
  var isListViewSelected = true.obs;

// মেথড: টগল করার জন্য
  void toggleView(bool isList) {
    isListViewSelected.value = isList;
  }

  @override
  void onClose() {
    bannerPageController.dispose();
    super.onClose();
  }
}