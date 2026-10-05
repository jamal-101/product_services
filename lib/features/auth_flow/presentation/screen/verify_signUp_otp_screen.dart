import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/constants/app_color.dart';
import '../../../../utils/constants/app_utils.dart';
import '../../../../utils/constants/app_string.dart';
import '../controller/auth_controller.dart';

class VerifySignupOtpScreen extends StatelessWidget {
  const VerifySignupOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) {
        final String userEmail = controller.registerEmailController.text.trim();

        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            centerTitle: false,
            leading: Padding(
              padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: const Color(0xFFECECF0)),
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black, size: 20),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: AppString.verify.tr,
                          style: const TextStyle(color: AppColor.textDark),
                        ),
                        const TextSpan(text: " "),
                        TextSpan(
                          text: AppString.email.tr,
                          style: const TextStyle(color: AppColor.accent),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Wrap(
                    children: [
                      Text(
                        AppString.weSent.tr,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14.sp,
                          color: AppColor.textLight,
                          height: 1.4,
                        ),
                      ),
                      Text(
                        " $userEmail",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14.sp,
                          color: AppColor.textDark,
                          fontWeight: FontWeight.w600,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 40.h),

                  // OTP Input Fields
                  FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        6,
                            (index) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.w),
                          child: _buildOtpField(context, index, controller),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32.h),
                  Center(
                    child: Obx(() {
                      if (controller.phoneCountdown.value == 0) {
                        return GestureDetector(
                          onTap: controller.isLoading.value
                              ? null
                              : () {
                            controller.resendSignUpOtp();
                          },
                          child: Text(
                            "Resend Code",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 15.sp,
                              color: AppColor.primary,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        );
                      }

                      // ২. টাইমার চলাকালীন ৩ মিনিট (03:00) থেকে কাউন্টডাউন হবে
                      int minutes = controller.phoneCountdown.value ~/ 60;
                      int seconds = controller.phoneCountdown.value % 60;
                      String formattedTime =
                          "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";

                      return RichText(
                        text: TextSpan(
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 15.sp,
                            color: AppColor.textLight,
                          ),
                          children: [
                            TextSpan(text: AppString.donHave.tr),
                            TextSpan(
                              text: " ${AppString.resendIn.tr} $formattedTime",
                              style: GoogleFonts.plusJakartaSans(
                                color: AppColor.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),

                  SizedBox(height: 40.h),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    height: 52.h,
                    child: Obx(
                          () => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primary,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                        ),
                        onPressed: controller.isLoading.value
                            ? null
                            : () {
                          String otpCode = controller.otpControllers
                              .map((c) => c.text.trim())
                              .join();

                          String? error = Utils.otpValidator(otpCode);

                          if (error != null) {
                            Get.snackbar(
                              "Error",
                              error,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                              snackPosition: SnackPosition.BOTTOM,
                            );
                            return;
                          }
                          controller.verifyOtp();
                        },
                        child: controller.isLoading.value
                            ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                            : Text(
                          AppString.verifyAndContinue.tr,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 16.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildOtpField(
      BuildContext context, int index, AuthController controller) {
    return SizedBox(
      width: 60.w,
      height: 60.h,
      child: TextFormField(
        controller: controller.otpControllers[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        style: GoogleFonts.plusJakartaSans(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: AppColor.textDark,
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 5) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty && index > 0) {
            FocusScope.of(context).previousFocus();
          }
        },
        decoration: InputDecoration(
          counterText: "",
          contentPadding: EdgeInsets.zero,
          fillColor: const Color(0xFFFFFFFF),
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: Color(0xFFECECF0), width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: AppColor.primary, width: 2.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: Colors.red, width: 1.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
          ),
        ),
      ),
    );
  }
}