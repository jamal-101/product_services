import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:product_service/config/route/app_route.dart';
import '../../../../utils/constants/app_color.dart';
import '../controller/auth_controller.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
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
                  children: const [
                    TextSpan(text: "Forgot ", style: TextStyle(color: AppColor.textDark)),
                    TextSpan(text: "Password?", style: TextStyle(color: AppColor.accent)),
                  ],
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "No worries! Enter your email and we'll send you an OTP code to reset your password.",
                style: TextStyle(fontSize: 14.sp, color: AppColor.textLight, height: 1.4),
              ),
              SizedBox(height: 32.h),

              Text("Email", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColor.textDark)),
              SizedBox(height: 8.h),
              TextFormField(
                controller: controller.forgotEmailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "you@example.com",
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
                  fillColor: Color(0xFFFFFFFF),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: const BorderSide(color: Color(0xFFECECF0), width: 1.5),
                  ),

                  // ক্লিক করার পর (Focused) বর্ডার কালার
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    // আপনি চাইলে ফোকাসড অবস্থায় কালার সেম রাখতে পারেন অথবা প্রাইমারি কালার দিতে পারেন
                    borderSide: const BorderSide(color: Color(0xFFECECF0), width: 2.0),
                  ),

                  // এরর বর্ডার (যদি ভ্যালিডেশন ব্যবহার করেন)
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
                  child: Text("Send OTP", style: TextStyle(fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}