import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/constants/app_color.dart';
import '../controller/auth_controller.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

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
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
                  children: const [
                    TextSpan(text: "Reset ", style: TextStyle(color: AppColor.textDark)),
                    TextSpan(text: "Password", style: TextStyle(color: AppColor.accent)),
                  ],
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "Create a new strong password to keep your account safe.",
                style: TextStyle(fontSize: 14.sp, color: AppColor.textLight),
              ),
              SizedBox(height: 32.h),

              Text("New Password", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColor.textDark)),
              SizedBox(height: 8.h),
              Obx(() => TextFormField(
                controller: controller.newPasswordController,
                obscureText: !controller.isNewPasswordVisible.value,
                decoration: InputDecoration(
                  hintText: "Create a strong password",
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(controller.isNewPasswordVisible.value ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                    onPressed: () => controller.isNewPasswordVisible.toggle(),
                  ),
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
              )),
              SizedBox(height: 20.h),

              Text("Confirm New Password", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColor.textDark)),
              SizedBox(height: 8.h),
              Obx(() => TextFormField(
                controller: controller.confirmPasswordController,
                obscureText: !controller.isConfirmPasswordVisible.value,
                decoration: InputDecoration(
                  hintText: "Re-enter your password",
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(controller.isConfirmPasswordVisible.value ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                    onPressed: () => controller.isConfirmPasswordVisible.toggle(),
                  ),
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
              )),
              SizedBox(height: 40.h),

              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                  ),
                  onPressed: () {
                    // পাসওয়ার্ড রিসেট সফল হলে লগইন বা ড্যাশবোর্ডে রিডাইরেক্ট লজিক
                    Get.offAllNamed('/login');
                  },
                  child: Text("Reset Password", style: TextStyle(fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}