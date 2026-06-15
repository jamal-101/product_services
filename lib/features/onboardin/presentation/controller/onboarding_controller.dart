import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_service/config/route/app_route.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();

  // কারেন্ট পেজ ইনডেক্স ট্র্যাক করার জন্য রিঅ্যাক্টিভ ভেরিয়েবল (.obs)
  var currentIndex = 0.obs;

  void updateIndex(int index) {
    currentIndex.value = index;
  }

  void skipToLast(int lastIndex) {
    pageController.jumpToPage(lastIndex);
  }

  void nextStep(int totalPages) {
    if (currentIndex.value < totalPages - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Get.offAllNamed(AppRoutes.loginScreen);
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}