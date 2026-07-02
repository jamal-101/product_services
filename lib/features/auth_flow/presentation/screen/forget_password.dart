import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/config/route/app_route.dart';
import 'package:product_service/utils/constants/app_images.dart';
import 'package:product_service/utils/constants/app_string.dart';
import '../../../../utils/constants/app_color.dart';
import '../controller/auth_controller.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(text: AppString.forgot, style: TextStyle(color: AppColor.textDark)),
                    TextSpan(text: "${AppString.password}?", style: TextStyle(color: AppColor.accent)),
                  ],
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                AppString.noWorries,
                style: TextStyle(fontSize: 14.sp, color: AppColor.textLight, height: 1.4),
              ),
              SizedBox(height: 32.h),

              Text(AppString.email, style: GoogleFonts.plusJakartaSans(fontSize: 16.sp, fontWeight: FontWeight.w500, color: AppColor.textDark)),
              SizedBox(height: 8.h),
              TextFormField(
                controller: controller.forgotEmailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "you@example.com",
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 12,right: 5,top: 12,bottom: 12),
                    child: Image.asset(AppImages.emailIcon,height: 5.h,width: 2.w,),
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
                  fillColor: Color(0xFFFFFFFF),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: const BorderSide(color: Color(0xFFECECF0), width: 1.5),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: const BorderSide(color: Color(0xFFECECF0), width: 2.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: const BorderSide(color: Colors.red, width: 1.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: const BorderSide(color: Colors.red, width: 2.0),
                  ),
                ),
              ),
              SizedBox(height: 32.h),

              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                  ),
                  onPressed: () {
                    controller.startOtpTimer();
                    Get.toNamed(AppRoutes.verifyOtp);
                  },
                  child: Text(AppString.sendOtp, style: GoogleFonts.plusJakartaSans(fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}