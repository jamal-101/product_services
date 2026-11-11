// import 'package:get/get.dart';
// import 'package:product_service/config/route/app_route.dart';
// import 'package:product_service/services/socket_service.dart';
// import 'package:product_service/utils/constants/api_enpoint.dart';
// import 'package:video_player/video_player.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/foundation.dart';
// import '../../../../services/storage/storage_service.dart';
//
// class SplashController extends GetxController {
//   late VideoPlayerController videoController;
//   final AudioPlayer audioPlayer = AudioPlayer();
//
//   RxBool isVideoReady = false.obs;
//   bool _isNavigated = false;
//
//   @override
//   void onInit() {
//     super.onInit();
//     _prepareSplashMedia();
//   }
//
//   void _prepareSplashMedia() async {
//     try {
//       videoController = VideoPlayerController.asset('assets/videos/intro.mp4');
//
//       await videoController.initialize();
//
//       isVideoReady.value = true;
//
//       videoController.play();
//
//       await audioPlayer.play(AssetSource('audio/audio_logo.mp3'));
//
//       int durationInSeconds = videoController.value.duration.inSeconds > 0
//           ? videoController.value.duration.inSeconds
//           : 4;
//
//       Future.delayed(Duration(seconds: durationInSeconds), () {
//         _navigateToNextScreen();
//       });
//     } catch (e) {
//       debugPrint("Splash Error: $e");
//       Future.delayed(const Duration(seconds: 4), () {
//         _navigateToNextScreen();
//       });
//     }
//   }
//
//   void _navigateToNextScreen() async {
//     if (_isNavigated) return;
//     _isNavigated = true;
//
//     if (!Get.isRegistered<SplashController>()) return;
//
//     if (audioPlayer.state == PlayerState.playing) {
//       await audioPlayer.stop();
//     }
//
//     await LocalStorage.getAllPrefData();
//     if (LocalStorage.token.isNotEmpty) {
//       if (!SocketService.instance.isInitialized) {
//         SocketService.instance.initAndConnect(
//           url: ApiEndPoint.imageUrl,
//           token: LocalStorage.token,
//         );
//       }
//       if (LocalStorage.hasSellerAccount) {
//         Get.offAllNamed(AppRoutes.sellerHomeScreen);
//       } else {
//         Get.offAllNamed(AppRoutes.homeScreen);
//       }
//     } else {
//       Get.offAllNamed(AppRoutes.onboardingScreen);
//     }
//   }
//
//   @override
//   void onClose() {
//     if (isVideoReady.value) {
//       videoController.dispose();
//     }
//     audioPlayer.dispose();
//     super.onClose();
//   }
// }


// import 'package:get/get.dart';
// import 'package:product_service/config/route/app_route.dart';
// import 'package:product_service/services/socket_service.dart';
// import 'package:product_service/utils/constants/api_enpoint.dart';
// import 'package:video_player/video_player.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/foundation.dart';
// import '../../../../services/storage/storage_service.dart';
//
// class SplashController extends GetxController {
//   late VideoPlayerController videoController;
//   final AudioPlayer audioPlayer = AudioPlayer();
//
//   RxBool isVideoReady = false.obs;
//   bool _isNavigated = false;
//
//   @override
//   void onInit() {
//     super.onInit();
//     _prepareSplashMedia();
//   }
//
//   void _prepareSplashMedia() async {
//     try {
//       // Async storage data pechone pre-load shuru kora
//       LocalStorage.getAllPrefData();
//
//       videoController = VideoPlayerController.asset(
//         'assets/videos/intro.mp4',
//         videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
//       );
//
//       await videoController.initialize();
//       videoController.setVolume(0.0); // Intro video-r nijer sound mute thakbe
//       videoController.setLooping(false);
//
//       // UI-te video widget load houar jonno ready mark kora
//       isVideoReady.value = true;
//
//       // Frame stuttering arodhe 50ms-er ekta choto pause/delay
//       await Future.delayed(const Duration(milliseconds: 160));
//
//       // Video o audio ekshathe play kora
//       await Future.wait([
//         videoController.play(),
//         audioPlayer.play(AssetSource('audio/audio_logo.mp3')),
//       ]);
//
//       // Video player end detection listener
//       videoController.addListener(_videoListener);
//
//     } catch (e) {
//       debugPrint("Splash Error: $e");
//       Future.delayed(const Duration(seconds: 5), () {
//         _navigateToNextScreen();
//       });
//     }
//   }
//
//   void _videoListener() {
//     if (videoController.value.isInitialized &&
//         !videoController.value.isPlaying &&
//         videoController.value.position >= videoController.value.duration) {
//       videoController.removeListener(_videoListener);
//       _navigateToNextScreen();
//     }
//   }
//
//   void _navigateToNextScreen() async {
//     if (_isNavigated) return;
//     _isNavigated = true;
//
//     if (!Get.isRegistered<SplashController>()) return;
//
//     if (audioPlayer.state == PlayerState.playing) {
//       await audioPlayer.stop();
//     }
//
//     await LocalStorage.getAllPrefData();
//
//     if (LocalStorage.token.isNotEmpty) {
//       if (!SocketService.instance.isInitialized) {
//         SocketService.instance.initAndConnect(
//           url: ApiEndPoint.imageUrl,
//           token: LocalStorage.token,
//         );
//       }
//       if (LocalStorage.hasSellerAccount) {
//         Get.offAllNamed(AppRoutes.sellerHomeScreen);
//       } else {
//         Get.offAllNamed(AppRoutes.homeScreen);
//       }
//     } else {
//       Get.offAllNamed(AppRoutes.onboardingScreen);
//     }
//   }
//
//   @override
//   void onClose() {
//     videoController.removeListener(_videoListener);
//     videoController.dispose();
//     audioPlayer.dispose();
//     super.onClose();
//   }
// }


import 'package:get/get.dart';
import 'package:product_service/config/route/app_route.dart';
import 'package:product_service/services/socket_service.dart';
import 'package:product_service/utils/constants/api_enpoint.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/foundation.dart';
import '../../../../services/storage/storage_service.dart';

class SplashController extends GetxController {
  late VideoPlayerController videoController;

  RxBool isVideoReady = false.obs;
  bool _isNavigated = false;

  @override
  void onInit() {
    super.onInit();
    _prepareSplashMedia();
  }
  void _prepareSplashMedia() async {
    try {
      LocalStorage.getAllPrefData();
      videoController = VideoPlayerController.asset(
        'assets/videos/intro.mp4',
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );
      await videoController.initialize();
      await videoController.setVolume(3.0);
      await videoController.setLooping(false);
      isVideoReady.value = true;
      await Future.delayed(const Duration(milliseconds: 150));
      await videoController.play();

      videoController.addListener(_videoListener);

    } catch (e) {
      debugPrint("Splash Error: $e");
      Future.delayed(const Duration(seconds: 4), () {
        _navigateToNextScreen();
      });
    }
  }

  void _videoListener() {
    if (videoController.value.isInitialized &&
        !videoController.value.isPlaying &&
        videoController.value.position >= videoController.value.duration) {
      videoController.removeListener(_videoListener);
      _navigateToNextScreen();
    }
  }

  void _navigateToNextScreen() async {
    if (_isNavigated) return;
    _isNavigated = true;

    if (!Get.isRegistered<SplashController>()) return;

    await LocalStorage.getAllPrefData();

    if (LocalStorage.token.isNotEmpty) {
      if (!SocketService.instance.isInitialized) {
        SocketService.instance.initAndConnect(
          url: ApiEndPoint.imageUrl,
          token: LocalStorage.token,
        );
      }
      if (LocalStorage.hasSellerAccount) {
        Get.offAllNamed(AppRoutes.sellerHomeScreen);
      } else {
        Get.offAllNamed(AppRoutes.homeScreen);
      }
    } else {
      Get.offAllNamed(AppRoutes.onboardingScreen);
    }
  }

  @override
  void onClose() {
    videoController.removeListener(_videoListener);
    videoController.dispose();
    super.onClose();
  }
}