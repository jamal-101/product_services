// import 'dart:async';
// import 'package:get/get.dart';
// import 'package:product_service/config/route/app_route.dart';
//
// class SplashController extends GetxController {
//   @override
//   void onInit() {
//     super.onInit();
//     _startDelay();
//   }
//
//   void _startDelay() {
//     Timer(const Duration(seconds: 3), () {
//       Get.offNamed(AppRoutes.onboardingScreen);
//     });
//   }
// }


import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../../../config/route/app_route.dart';
import '../../../../utils/constants/app_images.dart';

class SplashController extends GetxController {
  late VideoPlayerController videoController;
  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  void onInit() {
    super.onInit();
    _initializeMedia();
  }

  void _initializeMedia() async {
    // অডিও প্লে করা
    await audioPlayer.play(AssetSource('images/audio_player.mp3'));

    // ভিডিও সেটআপ
    videoController = VideoPlayerController.asset(AppImages.splashVideoPlayer)
      ..initialize().then((_) {
        videoController.play();
        update(); // UI আপডেট করার জন্য
      });

    // ভিডিও শেষ হওয়া মাত্রই অনবোর্ডিং স্ক্রিনে যাবে
    videoController.addListener(() {
      if (videoController.value.position >= videoController.value.duration) {
        Get.offNamed(AppRoutes.onboardingScreen);
      }
    });
  }

  @override
  void onClose() {
    videoController.dispose();
    audioPlayer.dispose();
    super.onClose();
  }
}