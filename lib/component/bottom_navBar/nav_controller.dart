// import 'package:get/get.dart';
//
// import '../../config/route/app_route.dart';
// import '../../features/auth_flow/presentation/controller/auth_controller.dart';
// import '../../features/seller/seller_home_flow/presentation/screen/seller_home_screen.dart';
//
// class BottomNavigationController extends GetxController {
//   var currentIndex = 0.obs;
//   void changeIndex(int index) {
//     currentIndex.value = index;
//   }
//
//
//   void handleBackPress() {
//     if (currentIndex.value != 0) {
//       changeIndex(0);
//
//       final authController = Get.find<AuthController>();
//       bool isSeller = authController.selectedRole.value == 'seller';
//
//       if (isSeller) {
//         Get.offAll(() => SellerHomeScreen());
//       } else {
//         Get.offAllNamed(AppRoutes.homeScreen);
//       }
//     }
//   }
// }


import 'package:get/get.dart';
import '../../config/route/app_route.dart';
import '../../features/auth_flow/presentation/controller/auth_controller.dart';
import '../../features/seller/seller_home_flow/presentation/screen/seller_home_screen.dart';

class BottomNavigationController extends GetxController {
  var currentIndex = 0.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
  }

  void handleBackPress() {
    if (currentIndex.value != 0) {
      currentIndex.value = 0;

      final authController = Get.find<AuthController>();
      bool isSeller = authController.selectedRole.value == 'seller';

      // Get.offAll() er bodole Get.off() use korle babar page flash ba double jump korbe na
      if (isSeller) {
        Get.off(
              () => const SellerHomeScreen(),
          transition: Transition.noTransition,
          preventDuplicates: true,
        );
      } else {
        Get.offNamed(
          AppRoutes.homeScreen,
          preventDuplicates: true,
        );
      }
    }
  }
}
