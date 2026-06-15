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
    final controller = Get.find<AuthController>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppImages.splash1, height: 50.h),
              SizedBox(height: 24.h),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
                  children: const [
                    TextSpan(text: "How will you ", style: TextStyle(color: AppColor.textDark)),
                    TextSpan(text: "use ", style: TextStyle(color: AppColor.accent)),
                    TextSpan(text: "the app?", style: TextStyle(color: AppColor.textDark)),
                  ],
                ),
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
                          icon: Icons.person_pin,
                          title: "Buyer",
                          desc: "Explore and purchase products & services easily.",
                          color: AppColor.primary,
                          isSelected: isSelected,
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
                          icon: Icons.store_mall_directory_outlined,
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
    required IconData icon,
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
          CircleAvatar(
            radius: 24.r,
            backgroundColor: color.withOpacity(0.1),
            child: Icon(icon, color: color, size: 24.w),
          ),
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