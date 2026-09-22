// import 'dart:async';
// import 'package:get/get.dart';
// import 'package:product_service/config/route/app_route.dart';
// import 'package:product_service/services/socket_service.dart';
// import 'package:product_service/utils/constants/api_enpoint.dart';
// import '../../../../services/storage/storage_service.dart';
//
// class SplashController extends GetxController {
//
//   @override
//   void onInit() {
//     super.onInit();
//     _startDelay();
//   }
//
//   void _startDelay() {
//     Timer(const Duration(seconds: 3), () async {
//       await LocalStorage.getAllPrefData();
//       if (LocalStorage.token.isNotEmpty) {
//         if (!SocketService.instance.isInitialized) {
//           SocketService.instance.initAndConnect(
//             url: ApiEndPoint.imageUrl,
//             token: LocalStorage.token,
//           );
//         }
//         if (LocalStorage.hasSellerAccount) {
//           Get.offAllNamed(AppRoutes.selectRoleScreen);
//         } else {
//           Get.offAllNamed(AppRoutes.homeScreen);
//         }
//
//       } else {
//         Get.offAllNamed(AppRoutes.onboardingScreen);
//       }
//     });
//   }
// }

import 'package:get/get.dart';
import 'package:product_service/config/route/app_route.dart';
import 'package:product_service/services/socket_service.dart';
import 'package:product_service/utils/constants/api_enpoint.dart';
import 'package:video_player/video_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import '../../../../services/storage/storage_service.dart';

class SplashController extends GetxController {
  late VideoPlayerController videoController;
  final AudioPlayer audioPlayer = AudioPlayer();

  RxBool isVideoReady = false.obs;
  bool _isNavigated = false;

  @override
  void onInit() {
    super.onInit();
    _prepareSplashMedia();
  }

  void _prepareSplashMedia() async {
    try {
      videoController = VideoPlayerController.asset('assets/videos/intro.mp4');

      await videoController.initialize();

      isVideoReady.value = true;

      videoController.play();

      await audioPlayer.play(AssetSource('audio/audio_logo.mp3'));

      int durationInSeconds = videoController.value.duration.inSeconds > 0
          ? videoController.value.duration.inSeconds
          : 4;

      Future.delayed(Duration(seconds: durationInSeconds), () {
        _navigateToNextScreen();
      });
    } catch (e) {
      debugPrint("Splash Error: $e");
      Future.delayed(const Duration(seconds: 4), () {
        _navigateToNextScreen();
      });
    }
  }

  void _navigateToNextScreen() async {
    if (_isNavigated) return;
    _isNavigated = true;

    if (!Get.isRegistered<SplashController>()) return;

    if (audioPlayer.state == PlayerState.playing) {
      await audioPlayer.stop();
    }

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
  }

  @override
  void onClose() {
    if (isVideoReady.value) {
      videoController.dispose();
    }
    audioPlayer.dispose();
    super.onClose();
  }
}
