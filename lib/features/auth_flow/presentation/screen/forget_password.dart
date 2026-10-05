import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/utils/constants/app_images.dart';
import 'package:product_service/utils/constants/app_string.dart';
import '../../../../utils/constants/app_color.dart';
import '../../../../utils/constants/app_utils.dart';
import '../controller/auth_controller.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(text: AppString.forgot.tr, style: TextStyle(color: AppColor.textDark)),
                          TextSpan(text: "${AppString.password.tr}?", style: TextStyle(color: AppColor.accent)),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      AppString.noWorries.tr,
                      style: TextStyle(fontSize: 14.sp, color: AppColor.textLight, height: 1.4),
                    ),
                    SizedBox(height: 32.h),

                    Text(AppString.email.tr, style: GoogleFonts.plusJakartaSans(fontSize: 16.sp, fontWeight: FontWeight.w500, color: AppColor.textDark)),
                    SizedBox(height: 8.h),
                    TextFormField(
                      controller: controller.forgotEmailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => Utils.emailValidator(value),
                      decoration: InputDecoration(
                        hintText: "you@example.com",
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 12, right: 5, top: 12, bottom: 12),
                          child: Image.asset(AppImages.emailIcon, height: 5.h, width: 2.w),
                        ),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
                        fillColor: const Color(0xFFFFFFFF),
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
                        onPressed: controller.isForgotLoading.value
                            ? null
                            : () {
                          if (_formKey.currentState!.validate()) {
                            controller.forgotPassword();
                          }
                        },
                        child: controller.isForgotLoading.value
                            ? const CircularProgressIndicator(color: Colors.white)
                            : Text(
                          AppString.sendOtp.tr,
                          style: GoogleFonts.plusJakartaSans(fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}