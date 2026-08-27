import 'dart:async';
import 'package:get/get.dart';
import 'package:product_service/config/route/app_route.dart';
import '../../../../services/storage/storage_service.dart';

class SplashController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    _startDelay();
  }

  void _startDelay() {
    Timer(const Duration(seconds: 3), () async {
      await LocalStorage.getAllPrefData();
      if (LocalStorage.token.isNotEmpty) {
        if (LocalStorage.hasSellerAccount) {
          Get.offAllNamed(AppRoutes.selectRoleScreen);
        } else {
          Get.offAllNamed(AppRoutes.homeScreen);
        }

      } else {
        Get.offAllNamed(AppRoutes.onboardingScreen);
      }
    });
  }
}