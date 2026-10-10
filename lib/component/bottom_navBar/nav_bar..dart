import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/config/route/app_route.dart';
import 'package:product_service/features/seller/my_list_flow/presentation/screen/my_list_screen.dart';
import 'package:product_service/features/seller/my_store_flow/presentation/screen/my_store_screen.dart';
import 'package:product_service/utils/constants/app_images.dart';
import 'package:product_service/utils/constants/app_string.dart';
import '../../features/auth_flow/presentation/controller/auth_controller.dart';
import '../../features/seller/seller_home_flow/presentation/screen/seller_home_screen.dart';
import 'nav_controller.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;

  BottomNavBar({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    final BottomNavigationController controller = Get.put(
      BottomNavigationController(),
    );

    final AuthController authController = Get.isRegistered<AuthController>()
        ? Get.find<AuthController>()
        : Get.put(AuthController(), permanent: true);

    if (controller.currentIndex.value != selectedIndex) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.changeIndex(selectedIndex);
      });
    }

    return Obx(() {
      final bool isSeller = authController.selectedRole.value == 'seller';

      return Container(
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
          child: SizedBox(
            height: 80.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  index: 0,
                  imagePath: AppImages.homeIcon,
                  label: AppString.home.tr,
                  controller: controller,
                  isSeller: isSeller,
                ),

                _buildNavItem(
                  index: 1,
                  imagePath: isSeller
                      ? AppImages.myListIcon
                      : AppImages.listIcon,
                  label: isSeller
                      ? AppString.myListing.tr
                      : AppString.stores.tr,
                  controller: controller,
                  isSeller: isSeller,
                ),
                if (isSeller)
                  _buildMyStoreNavItem(
                    index: 2,
                    imagePath: AppImages.storeIcon,
                    label: AppString.myStore.tr,
                    controller: controller,
                  ),
                _buildNavItem(
                  index: 3,
                  imagePath: AppImages.messageIcon,
                  label: AppString.messages.tr,
                  controller: controller,
                  isSeller: isSeller,
                ),
                _buildNavItem(
                  index: 4,
                  imagePath: AppImages.accountIcon,
                  label: AppString.account.tr,
                  controller: controller,
                  isSeller: isSeller,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildNavItem({
    required int index,
    required String imagePath,
    required String label,
    required BottomNavigationController controller,
    required bool isSeller,
  }) {
    bool isSelected = controller.currentIndex.value == index;
    const Color activeColor = Color(0xFF2A9B4A);

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (controller.currentIndex.value == index) return;
          controller.changeIndex(index);
          _handleNavigation(index, isSeller);
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
                    colors: [
                      activeColor.withValues(alpha: 0.15),
                      Colors.transparent,
                    ],
                  )
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                width: 24.sp,
                height: 24.sp,
                color: isSelected ? activeColor : const Color(0xFF6B7280),
              ),
              SizedBox(height: 4.h),
              Text(
                label,
                style: GoogleFonts.montserrat(
                  fontSize: 11.sp,
                  color: isSelected ? activeColor : const Color(0xFF1A1D24),
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMyStoreNavItem({
    required int index,
    required String imagePath,
    required String label,
    required BottomNavigationController controller,
  }) {
    bool isSelected = controller.currentIndex.value == index;
    const Color storeColor = Colors.orange;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
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
                    colors: [
                      storeColor.withValues(alpha: 0.15),
                      Colors.transparent,
                    ],
                  )
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                width: 24.sp,
                height: 24.sp,
                color: isSelected ? storeColor : Colors.orange.shade400,
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
            ? Get.offAll(() => const SellerHomeScreen())
            : Get.offAllNamed(AppRoutes.homeScreen);
        break;
      case 1:
        isSeller
            ? Get.offAll(() => MyListingScreen())
            : Get.offAllNamed(AppRoutes.exploreStoriesScreen);
        break;
      case 2:
        Get.offAll(() => const MyStoreScreen());
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
