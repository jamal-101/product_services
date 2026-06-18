import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/config/route/app_route.dart';
import 'package:product_service/features/seller/my_list_flow/presentation/screen/my_list_screen.dart';
import '../../features/auth_flow/presentation/controller/auth_controller.dart';
import '../../features/seller/seller_home_flow/presentation/screen/seller_home_screen.dart';
import 'nav_controller.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;

  final BottomNavigationController controller = Get.put(BottomNavigationController());

  BottomNavBar({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.changeIndex(selectedIndex);
    });

    return Obx(() => Container(
      height: 80.h,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(0, Icons.home_outlined, "Home"),
          _buildNavItem(1, Icons.storefront_outlined, "Store"),
          _buildNavItem(2, Icons.chat_bubble_outline, "Messages"),
          _buildNavItem(3, Icons.person_outline, "Account"),
        ],
      ),
    ));
  }

  final AuthController authController = Get.put(AuthController());

  Widget _buildNavItem(int index, IconData icon, String label) {
    bool isSelected = controller.currentIndex.value == index;
    final Color activeColor = const Color(0xFF2A9B4A);
    bool isSeller = authController.selectedRole.value == 'seller';
    String displayLabel = (index == 1 && isSeller) ? "My Listing" : label;
    IconData displayIcon = (index == 1 && isSeller) ? Icons.inventory_2_outlined : icon;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (controller.currentIndex.value == index) return;
          controller.changeIndex(index);
          switch (index) {
            case 0:
              isSeller ? Get.offAll(() => const SellerHomeScreen()) : Get.offAllNamed(AppRoutes.homeScreen);
              break;
            case 1:
              isSeller ? Get.offAll(() => const MyListingScreen()) : Get.offAllNamed(AppRoutes.exploreStoriesScreen);
              break;
            case 2:
              Get.offAllNamed(AppRoutes.messageScreen);
              break;
            case 3:
              Get.offAllNamed(AppRoutes.accountScreen);
              break;
          }
        },
        child: Container(
          height: 80.h,
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          decoration: BoxDecoration(
            color: Colors.white,
            border: isSelected
                ? Border(top: BorderSide(color: activeColor, width: 3.h))
                : null,
            gradient: isSelected ? LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.0, 0.7],
              colors: [
                activeColor.withOpacity(0.15),
                Colors.transparent,
              ],
            )
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 7.h),
              Icon(
                isSelected ? displayIcon : (index == 1 && isSeller ? Icons.inventory_2_outlined : icon),
                color: isSelected ? activeColor : const Color(0xFF6B7280),
                size: 24.sp,
              ),
              SizedBox(height: 4.h),
              Text(
                displayLabel,
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
}


// Widget _buildNavItem(int index, IconData icon, String label) {
//   bool isSelected = controller.currentIndex.value == index;
//   final Color activeColor = const Color(0xFF27AE60);
//
//   bool isSeller = authController.selectedRole.value == 'seller';
//   String displayLabel = (index == 1 && isSeller) ? "My Listing" : label;
//   IconData displayIcon = (index == 1 && isSeller) ? Icons.inventory_2_outlined : icon;
//
//   return GestureDetector(
//     onTap: () {
//       if (controller.currentIndex.value == index) return;
//       controller.changeIndex(index);
//       switch (index) {
//         case 0:
//           isSeller ? Get.offAll(() => const SellerHomeScreen()) : Get.offAllNamed(AppRoutes.homeScreen);
//           break;
//         case 1:
//          isSeller? Get.offAll(()=>const MyListingScreen()) : Get.offAllNamed(AppRoutes.exploreStoriesScreen);
//           break;
//         case 2:
//           Get.offAllNamed(AppRoutes.messageScreen);
//           break;
//         case 3:
//           Get.offAllNamed(AppRoutes.accountScreen);
//           break;
//       }
//     },
//     child: Container(
//       padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
//       decoration: BoxDecoration(
//         color: isSelected ? activeColor.withOpacity(0.1) : Colors.transparent,
//         borderRadius: BorderRadius.circular(12.r),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(displayIcon, color: isSelected ? activeColor : Colors.grey, size: 24.sp),
//           SizedBox(height: 4.h),
//           Text(
//             displayLabel,
//             style: GoogleFonts.montserrat(
//               fontSize: 10.sp,
//               color: isSelected ? activeColor : Colors.grey,
//               fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }