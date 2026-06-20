import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:product_service/features/profile_section/presentation/screen/save_flow/presentation/screen/explor_stories_screen.dart';

class SaveScreen extends StatelessWidget {
  const SaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        elevation: 0,
        centerTitle: false,
        title: Text(
          "Saved",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
          ),
        ),
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5EF),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black, size: 20.sp),
              onPressed: () => Get.back(),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF9F5),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFFFF3E0), width: 1.w),
              ),
              child: const Icon(
                Icons.storefront_outlined,
                size: 48,
                color: Color(0xFFF7931E),
              ),
            ),
            SizedBox(height: 24.h),

            Text(
              "No Saved Stores",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 12.h),

            // ডেসক্রিপশন
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.w),
              child: Text(
                "Bookmark your favorite stores to access them easily at any time.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF7A818F), // ফিগমার ধূসর কালার
                  height: 1.5,
                ),
              ),
            ),
            SizedBox(height: 32.h),

            // বাটন
            SizedBox(
              width: 160.w,
              height: 48.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2A9B4A),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                onPressed: () {
                  Get.to(ExploreScreen());
                },
                child: const Text(
                  "Explore Stores",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}