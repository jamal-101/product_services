import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../config/route/app_route.dart';
import '../../../../utils/constants/app_color.dart';
import '../controller/auth_controller.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

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
              SizedBox(height: 10.h),
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
                  children: const [
                    TextSpan(text: "Create ", style: TextStyle(color: AppColor.textDark)),
                    TextSpan(text: "account", style: TextStyle(color: AppColor.accent)),
                  ],
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                "Quick signup",
                style: TextStyle(fontSize: 14.sp, color: AppColor.textLight),
              ),
              SizedBox(height: 24.h),

              // Full Name Field
              Text("Full Name", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColor.textDark)),
              SizedBox(height: 8.h),
              TextFormField(
                controller: controller.registerNameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: "John Doe",
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
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
              SizedBox(height: 16.h),

              // Phone Number Field
              Text("Phone Number", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColor.textDark)),
              SizedBox(height: 8.h),
              TextFormField(
                controller: controller.registerPhoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "+1 555 000 0000",
                  prefixIcon: const Icon(Icons.phone_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
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
              SizedBox(height: 16.h),

              // Email Field
              Text("Email", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColor.textDark)),
              SizedBox(height: 8.h),
              TextFormField(
                controller: controller.registerEmailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "you@example.com",
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
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
              SizedBox(height: 16.h),

              // Password Field
              Text("Password", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColor.textDark)),
              SizedBox(height: 8.h),
              Obx(() => TextFormField(
                controller: controller.registerPasswordController,
                obscureText: !controller.isRegisterPasswordVisible.value,
                decoration: InputDecoration(
                  hintText: "••••••••",
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(controller.isRegisterPasswordVisible.value
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined),
                    onPressed: () => controller.isRegisterPasswordVisible.toggle(),
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
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
              SizedBox(height: 16.h),

              // Confirm Password Field
              Text("Confirm Password", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColor.textDark)),
              SizedBox(height: 8.h),
              Obx(() => TextFormField(
                controller: controller.registerConfirmPasswordController,
                obscureText: !controller.isRegisterConfirmPasswordVisible.value,
                decoration: InputDecoration(
                  hintText: "••••••••",
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(controller.isRegisterConfirmPasswordVisible.value
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined),
                    onPressed: () => controller.isRegisterConfirmPasswordVisible.toggle(),
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
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
              SizedBox(height: 32.h),

              // Create Account Button
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                  ),
                  onPressed: () => Get.toNamed(AppRoutes.verifyPhone),
                  child: Text("Create Account", style: TextStyle(fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(height: 24.h),

              // Already have an account Login Link
              Center(
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 14.sp, color: AppColor.textLight),
                      children: const [
                        TextSpan(text: "Already have an account? "),
                        TextSpan(
                          text: "Login",
                          style: TextStyle(color: AppColor.primary, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}