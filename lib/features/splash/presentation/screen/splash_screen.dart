import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SplashController controller = Get.put(SplashController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Obx(() {
          if (!controller.isVideoReady.value) {
            return const SizedBox.shrink();
          }
          return SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: controller.videoController.value.size.width,
                height: controller.videoController.value.size.height,
                child: VideoPlayer(controller.videoController),
              ),
            ),
          );
        }),
      ),
    );
  }
}

