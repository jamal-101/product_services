import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/constants/app_color.dart';
import '../controller/auth_controller.dart';

class VerifyPhoneScreen extends StatelessWidget {
  const VerifyPhoneScreen({super.key});

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
                    TextSpan(text: "Verify ", style: TextStyle(color: AppColor.textDark)),
                    TextSpan(text: "phone", style: TextStyle(color: AppColor.accent)),
                  ],
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "We sent a 6-digit code to +1 555 ••• 0000",
                style: TextStyle(fontSize: 14.sp, color: AppColor.textLight, height: 1.4),
              ),
              SizedBox(height: 40.h),

              // 6-Digit OTP Boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) => _buildOtpField(context, index)),
              ),
              SizedBox(height: 32.h),

              // Countdown Timer
              Center(
                child: Obx(() => RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 13.sp, color: AppColor.textLight),
                    children: [
                      const TextSpan(text: "Didn't receive? "),
                      TextSpan(
                        text: "Resend in 0:${controller.phoneCountdown.value.toString().padLeft(2, '0')}",
                        style: const TextStyle(color: AppColor.primary, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )),
              ),
              SizedBox(height: 40.h),

              // Verify & Continue Button
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                  ),
                  onPressed: () {
                    // সফল ভেরিফিকেশন হলে হোমপেজ বা সাকসেস ডায়ালগে নেভিগেট করার লজিক
                  },
                  child: Text("Verify & Continue", style: TextStyle(fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtpField(BuildContext context, int index) {
    return SizedBox(
      width: 44.w,
      height: 50.h,
      child: TextFormField(
        onChanged: (value) {
          if (value.length == 1 && index < 5) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty && index > 0) {
            FocusScope.of(context).previousFocus();
          }
        },
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          counterText: "",
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
    );
  }
}