// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:product_service/config/route/app_route.dart';
// import 'package:product_service/features/seller/my_list_flow/presentation/screen/my_list_screen.dart';
// import 'package:product_service/utils/constants/app_images.dart';
// import 'package:product_service/utils/constants/app_string.dart';
// import '../../features/auth_flow/presentation/controller/auth_controller.dart';
// import '../../features/seller/seller_home_flow/presentation/screen/seller_home_screen.dart';
// import 'nav_controller.dart';
//
// class BottomNavBar extends StatelessWidget {
//   final int selectedIndex;
//   final BottomNavigationController controller = Get.put(
//     BottomNavigationController(),
//   );
//   final AuthController authController = Get.put(AuthController());
//
//   BottomNavBar({super.key, required this.selectedIndex});
//
//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback(
//       (_) => controller.changeIndex(selectedIndex),
//     );
//
//     return Obx(
//       () => Container(
//         // height: 80.h,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withValues(alpha: 0.05),
//               blurRadius: 10,
//               offset: const Offset(0, -5),
//             ),
//           ],
//         ),
//         child: SafeArea(
//           top: false,
//           child: Container(
//             height: 80.h,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 _buildNavItem(0, AppImages.homeIcon, AppString.home),
//                 _buildNavItem(
//                   1,
//                   authController.selectedRole.value == 'seller'
//                       ? AppImages.listIcon
//                       : AppImages.storeIcon,
//                   "Store",
//                 ),
//                 _buildNavItem(2, AppImages.messageIcon, AppString.message),
//                 _buildNavItem(3, AppImages.accountIcon, AppString.account),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildNavItem(int index, String imagePath, String label) {
//     bool isSelected = controller.currentIndex.value == index;
//     bool isSeller = authController.selectedRole.value == 'seller';
//     final Color activeColor = const Color(0xFF2A9B4A);
//
//     String displayLabel = (index == 1 && isSeller) ? AppString.myList : label;
//
//     return Expanded(
//       child: GestureDetector(
//         onTap: () {
//           if (controller.currentIndex.value == index) return;
//           controller.changeIndex(index);
//           _handleNavigation(index, isSeller);
//         },
//         child: Container(
//           height: 80.h,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             border: isSelected
//                 ? Border(
//                     top: BorderSide(color: activeColor, width: 3.h),
//                   )
//                 : null,
//             gradient: isSelected
//                 ? LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     stops: const [0.0, 0.7],
//                     colors: [activeColor.withValues(alpha: 0.15), Colors.transparent],
//                   )
//                 : null,
//           ),
//           child: Column(
//             children: [
//               SizedBox(height: 12.h),
//               ColorFiltered(
//                 colorFilter: ColorFilter.mode(
//                   isSelected ? activeColor : const Color(0xFF6B7280),
//                   BlendMode.srcIn,
//                 ),
//                 child: Image.asset(imagePath, width: 26.sp, height: 26.sp),
//               ),
//               SizedBox(height: 4.h),
//               Text(
//                 displayLabel,
//                 style: GoogleFonts.montserrat(
//                   fontSize: 10.sp,
//                   color: isSelected ? activeColor : const Color(0xFF6B7280),
//                   fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _handleNavigation(int index, bool isSeller) {
//     switch (index) {
//       case 0:
//         isSeller
//             ? Get.offAll(() => const SellerHomeScreen())
//             : Get.offAllNamed(AppRoutes.homeScreen);
//         break;
//       case 1:
//         isSeller
//             ? Get.offAll(() => MyListingScreen())
//             : Get.offAllNamed(AppRoutes.exploreStoriesScreen);
//         break;
//       case 2:
//         Get.offAllNamed(AppRoutes.messageScreen);
//         break;
//       case 3:
//         Get.offAllNamed(AppRoutes.accountScreen);
//         break;
//     }
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/config/route/app_route.dart';
import 'package:product_service/features/seller/my_list_flow/presentation/screen/my_list_screen.dart';
import 'package:product_service/utils/constants/app_images.dart';
import 'package:product_service/utils/constants/app_string.dart';
import '../../features/auth_flow/presentation/controller/auth_controller.dart';
import '../../features/seller/seller_home_flow/presentation/screen/seller_home_screen.dart';
import 'nav_controller.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final BottomNavigationController controller = Get.put(
    BottomNavigationController(),
  );
  final AuthController authController = Get.put(AuthController());

  BottomNavBar({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
          (_) => controller.changeIndex(selectedIndex),
    );

    return Obx(
          () => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Container(
            height: 80.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, AppImages.homeIcon, AppString.home),
                _buildNavItem(1, AppImages.listIcon, AppString.myList),
                if (authController.selectedRole.value == 'seller')
                  _buildMyStoreNavItem(2, AppImages.storeIcon, "My Store"),

                _buildNavItem(3, AppImages.messageIcon, AppString.message),
                _buildNavItem(4, AppImages.accountIcon, AppString.account),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String imagePath, String label) {
    bool isSelected = controller.currentIndex.value == index;
    final Color activeColor = const Color(0xFF2A9B4A);

    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (controller.currentIndex.value == index) return;
          controller.changeIndex(index);
          _handleNavigation(index, authController.selectedRole.value == 'seller');
        },
        child: Container(
          height: 80.h,
          decoration: BoxDecoration(
            color: Colors.white,
            border: isSelected
                ? Border(
              top: BorderSide(color: activeColor, width: 3.h),
            )
                : null,
            gradient: isSelected
                ? LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.0, 0.7],
              colors: [activeColor.withValues(alpha: 0.15), Colors.transparent],
            )
                : null,
          ),
          child: Column(
            children: [
              SizedBox(height: 12.h),
              ColorFiltered(
                colorFilter: ColorFilter.mode(
                  isSelected ? activeColor : const Color(0xFF6B7280),
                  BlendMode.srcIn,
                ),
                child: Image.asset(imagePath, width: 26.sp, height: 26.sp),
              ),
              SizedBox(height: 4.h),
              Text(
                label,
                style: GoogleFonts.montserrat(
                  fontSize: 10.sp,
                  color: isSelected ? activeColor : const Color(0xFF6B7280),
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMyStoreNavItem(int index, String imagePath, String label) {
    bool isSelected = controller.currentIndex.value == index;
    final Color storeColor = Colors.orange;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (controller.currentIndex.value == index) return;
          controller.changeIndex(index);
          _handleNavigation(index, true);
        },
        child: Container(
          height: 80.h,
          decoration: BoxDecoration(
            color: Colors.white,
            border: isSelected
                ? Border(
              top: BorderSide(color: storeColor, width: 3.h),
            )
                : null,
            gradient: isSelected
                ? LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.0, 0.7],
              colors: [storeColor.withValues(alpha: 0.15), Colors.transparent],
            )
                : null,
          ),
          child: Column(
            children: [
              SizedBox(height: 12.h),
              ColorFiltered(
                colorFilter: ColorFilter.mode(
                  isSelected ? storeColor : Colors.orange.shade300,
                  BlendMode.srcIn,
                ),
                child: Image.asset(imagePath, width: 26.sp, height: 26.sp),
              ),
              SizedBox(height: 4.h),
              Text(
                label,
                style: GoogleFonts.montserrat(
                  fontSize: 10.sp,
                  color: isSelected ? storeColor : Colors.orange.shade800,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleNavigation(int index, bool isSeller) {
    switch (index) {
      case 0:
        isSeller
            ? Get.offAll(() => SellerHomeScreen())
            : Get.offAllNamed(AppRoutes.homeScreen);
        break;
      case 1:
        isSeller
            ? Get.offAll(() => MyListingScreen())
            : Get.offAllNamed(AppRoutes.exploreStoriesScreen);
        break;
      case 2:
        Get.offAll(() => SellerHomeScreen());
        break;
      case 3:
        Get.offAllNamed(AppRoutes.messageScreen);
        break;
      case 4:
        Get.offAllNamed(AppRoutes.accountScreen);
        break;
    }
  }
}