import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/config/route/app_route.dart';

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

  Widget _buildNavItem(int index, IconData icon, String label) {
    bool isSelected = controller.currentIndex.value == index;
    final Color activeColor = const Color(0xFF27AE60);

    return GestureDetector(
      onTap: () {
        if (controller.currentIndex.value == index) return;
        controller.changeIndex(index);
        switch (index) {
          case 0:
            Get.offAllNamed(AppRoutes.homeScreen);
            break;
          case 1:
            Get.offAllNamed(AppRoutes.exploreStoriesScreen);
            break;
          case 2:
            Get.offAllNamed('/messageScreen');
            break;
          case 3:
            Get.offAllNamed(AppRoutes.accountScreen);
            break;
        }
      },
      child: Container(
        // বাকি ডিজাইন আগের মতোই থাকবে...
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? activeColor.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isSelected ? activeColor : Colors.grey, size: 24.sp),
            SizedBox(height: 4.h),
            Text(
              label,
              style: GoogleFonts.montserrat(
                fontSize: 10.sp,
                color: isSelected ? activeColor : Colors.grey,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}