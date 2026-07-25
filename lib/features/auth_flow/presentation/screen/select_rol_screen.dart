import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:product_service/utils/constants/app_images.dart';
import '../../../../utils/constants/app_color.dart';
import '../controller/auth_controller.dart';

class SelectRoleScreen extends StatelessWidget {
  const SelectRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.put(AuthController());

    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppImages.rollLOgoImage, height: 110.h),
              Padding(
                padding: EdgeInsets.only(left: 16,right: 16),
                child: Image.asset(AppImages.selectRollText),
              ),
              SizedBox(height: 8.h),
              Text(
                "You can switch later from your profile anytime.",
                style: TextStyle(fontSize: 13.sp, color: AppColor.textLight),
              ),
              SizedBox(height: 40.h),

              Row(
                children: [
                  Expanded(
                    child: Obx(() {
                      final isSelected = controller.selectedRole.value == 'buyer';
                      return GestureDetector(
                        onTap: () => controller.selectRole('buyer'),
                        child: _buildRoleCard(
                          isSelected: isSelected,
                          title: "Buyer",
                          desc: "Explore and purchase products & services easily.",
                          color: AppColor.primary,
                          assetPath: AppImages.buyerImage,
                        ),
                      );
                    }),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Obx(() {
                      final isSelected = controller.selectedRole.value == 'seller';
                      return GestureDetector(
                        onTap: () => controller.selectRole('seller'),
                        child: _buildRoleCard(
                          assetPath: AppImages.sellerImage,
                          title: "Seller",
                          desc: "Offer your goods & services and grow your brand.",
                          color: AppColor.accent,
                          isSelected: isSelected,
                        ),
                      );
                    }),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard({
    required String assetPath,
    required String title,
    required String desc,
    required Color color,
    required bool isSelected,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: isSelected ? color : Colors.transparent, width: 2.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        children: [
            Padding(
              padding: EdgeInsets.all(12.r), // ইমেজের চারদিকে কিছুটা স্পেস দেয়ার জন্য
              child: Image.asset(
                assetPath,
              ),
            ),
          // ),
          SizedBox(height: 12.h),
          Text(title, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: color)),
          SizedBox(height: 8.h),
          Text(
            desc,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.sp, color: AppColor.textLight, height: 1.4),
          ),
        ],
      ),
    );
  }
}