import 'dart:async';
import 'package:get/get.dart';
import 'package:product_service/config/route/app_route.dart';
import 'package:product_service/services/socket_service.dart';
import 'package:product_service/utils/constants/api_enpoint.dart';
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
        if (!SocketService.instance.isInitialized) {
          SocketService.instance.initAndConnect(
            url: ApiEndPoint.imageUrl,
            token: LocalStorage.token,
          );
        }
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