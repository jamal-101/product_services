import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class PrivacyAndPolicy extends StatelessWidget {
  const PrivacyAndPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        elevation: 0,
        centerTitle: false,
        title: Text(
          "Privacy Policy",
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
      body: Padding(
        padding: const EdgeInsets.only(left: 12,right: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12.h),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  """Welcome to [App Name]. By accessing or using our platform, you agree to comply with these Terms & Conditions.
1. Acceptance of Terms
By creating an account or using the platform, you acknowledge that you have read, understood, and agreed to these Terms & Conditions.""",
                  style: TextStyle(color: Color(0xFF1A1D24)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
