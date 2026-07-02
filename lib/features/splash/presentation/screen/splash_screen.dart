import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // কন্ট্রোলার ইনিশিয়ালাইজ
    final SplashController controller = Get.put(SplashController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: GetBuilder<SplashController>(
          builder: (controller) {
            // ভিডিও লোড না হওয়া পর্যন্ত খালি কন্টেইনার (সাদা ব্যাকগ্রাউন্ড)
            if (!controller.videoController.value.isInitialized) {
              return Container();
            }
            // ভিডিও প্লেয়ার
            return AspectRatio(
              aspectRatio: controller.videoController.value.aspectRatio,
              child: VideoPlayer(controller.videoController),
            );
          },
        ),
      ),
    );
  }
}