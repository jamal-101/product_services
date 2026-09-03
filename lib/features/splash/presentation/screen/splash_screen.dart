//
//
// import 'package:flutter/material.dart';
//
// import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
//
// import 'package:get/get.dart';
//
// import 'package:google_fonts/google_fonts.dart';
//
// import 'package:product_service/utils/constants/app_images.dart';
//
// import 'package:product_service/utils/constants/app_string.dart';
//
// import '../controller/splash_controller.dart';
//
//
//
// class SplashScreen extends StatelessWidget {
//
//   const SplashScreen({super.key});
//
//
//
//   @override
//
//   Widget build(BuildContext context) {
//
//     Get.put(SplashController());
//
//     return Scaffold(
//       appBar: AppBar(automaticallyImplyLeading: false),
//
//       body: Center(
//
//         child: Column(
//
//           mainAxisAlignment: MainAxisAlignment.center,
//
//           children: [
//
//             Image.asset(AppImages.splashImage,height: 380.h,width: 291.w),
//
//             SizedBox(height: 16.h),
//
//             Text(
//
//               AppString.product,
//
//               style: GoogleFonts.plusJakartaSans(
//
//                 fontSize: 30.sp,
//
//                 fontWeight: FontWeight.bold,
//
//                 color: Colors.red,
//
//               ),
//
//             ),
//
//           ],
//
//         ),
//
//       ),
//
//     );
//
//   }
//
// }


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
              child: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: SizedBox(
                  width: controller.videoController.value.size.width,
                  height: controller.videoController.value.size.height,
                  child: VideoPlayer(controller.videoController),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}