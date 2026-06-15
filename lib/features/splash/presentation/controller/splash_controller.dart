import 'dart:async';
import 'package:get/get.dart';
import 'package:product_service/config/route/app_route.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _startDelay();
  }

  void _startDelay() {
    Timer(const Duration(seconds: 3), () {
      Get.offNamed(AppRoutes.onboardingScreen);
    });
  }
}