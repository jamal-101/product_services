import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/utils/constants/app_images.dart';
import 'package:product_service/utils/constants/app_string.dart';
import '../../../../config/route/app_route.dart';
import '../../../../utils/constants/app_color.dart';
import '../controller/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60.h),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: AppString.welcome,
                      style: GoogleFonts.plusJakartaSans(color: AppColor.textDark),
                    ),
                    TextSpan(
                      text: AppString.back,
                      style: GoogleFonts.plusJakartaSans(color: AppColor.accent),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                AppString.loginTo,
                style: GoogleFonts.plusJakartaSans(fontSize: 14.sp, color: AppColor.textLight),
              ),
              SizedBox(height: 32.h),

              Text(
                AppString.email,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColor.textDark,
                ),
              ),
              SizedBox(height: 8.h),
              TextFormField(
                controller: controller.loginEmailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  fillColor: Color(0xFFFFFFFF),
                  filled: true,
                  hintText: "you@example.com",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(
                      left: 14,
                      right: 8,
                      top: 14,
                      bottom: 14,
                    ),
                    child: Image.asset(
                      AppImages.emailIcon,
                      height: 5.h,
                      width: 5.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: const BorderSide(
                      color: Color(0xFFECECF0),
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: const BorderSide(
                      color: Color(0xFFECECF0),
                      width: 2.0,
                    ),
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
              SizedBox(height: 20.h),

              Text(
                AppString.password,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColor.textDark,
                ),
              ),
              SizedBox(height: 8.h),
              Obx(
                () => TextFormField(
                  controller: controller.loginPasswordController,
                  obscureText: !controller.isLoginPasswordVisible.value,
                  decoration: InputDecoration(
                    fillColor: Color(0xFFFFFFFF),
                    filled: true,
                    hintText: "••••••••",
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(
                        left: 14,
                        right: 8,
                        top: 10,
                        bottom: 14,
                      ),
                      child: Image.asset(
                        AppImages.lockIcon,
                        height: 5.h,
                        width: 5.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isLoginPasswordVisible.value
                            ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                        color: Color(0xFF9D9D9D),
                      ),
                      onPressed: () =>
                          controller.isLoginPasswordVisible.toggle(),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(
                        color: Color(0xFFECECF0),
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(
                        color: Color(0xFFECECF0),
                        width: 2.0,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 1.0,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Get.toNamed(AppRoutes.forgetPassword),
                  child: Text(
                    AppString.forgotPassword,
                    style: GoogleFonts.plusJakartaSans(
                      color: AppColor.primary,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  onPressed: () => Get.toNamed(AppRoutes.selectRoleScreen),
                  child: Text(
                    AppString.login,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Text(
                      AppString.or,
                      style: GoogleFonts.plusJakartaSans(
                        color: AppColor.textLight,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),
              SizedBox(height: 24.h),

              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Color(0xFFFFFFFF),
                    side: const BorderSide(color: Color(0xFFECECF0)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AppImages.googleIcon,height: 30.h,width: 30.w,),
                      SizedBox(width: 8.w),
                      Text(
                        AppString.continueWithGoogle,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14.sp,
                          color: Color(0xFF1A1D24),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              Center(
                child: RichText(
                  text: TextSpan(
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF7A818F),
                    ),
                    children: [
                       TextSpan(text: AppString.donH),
                      TextSpan(
                        text: AppString.register,
                        style:  GoogleFonts.plusJakartaSans(
                          color: AppColor.primary,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed(AppRoutes.createAccount);
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
