import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/utils/constants/app_string.dart';
import '../../../../utils/constants/app_color.dart';
import '../controller/auth_controller.dart';

class ForgetPassVerifyOtpScreen extends StatelessWidget {
  ForgetPassVerifyOtpScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
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
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: AppString.verify.tr,
                        style: GoogleFonts.plusJakartaSans(
                          color: AppColor.textDark,
                        ),
                      ),
                      TextSpan(
                        text: AppString.otp.tr,
                        style: GoogleFonts.plusJakartaSans(
                          color: AppColor.accent,
                        ),
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
                      " ${controller.forgotEmailController.text.trim()}",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(6, (index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.w),
                      child: _buildOtpField(context, controller, index),
                    );
                  }),
                ),
                SizedBox(height: 32.h),
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: Obx(
                    () => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      onPressed: controller.isVerifyLoading.value
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                String otpCode = controller.otpControllers
                                    .map((c) => c.text.trim())
                                    .join();
                                controller.verifyForgetEmailOtp(otpCode);
                              }
                            },
                      child: controller.isVerifyLoading.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              "Verify OTP",
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 16.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),

                Center(
                  child: Obx(() {
                    if (controller.resendCountdown.value == 0) {
                      return GestureDetector(
                        onTap: controller.isForgotLoading.value
                            ? null
                            : () {
                                controller.resendForgotEmailOtp();
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
                    int minutes = controller.resendCountdown.value ~/ 60;
                    int seconds = controller.resendCountdown.value % 60;
                    String formattedTime =
                        "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";

                    return RichText(
                      text: TextSpan(
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 15.sp,
                          color: AppColor.textLight,
                        ),
                        children: [
                          TextSpan(text: AppString.donH.tr),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOtpField(
    BuildContext context,
    AuthController controller,
    int index,
  ) {
    return SizedBox(
      width: 44.w,
      height: 50.h,
      child: TextFormField(
        controller: controller.otpControllers[index],
        focusNode: controller.otpFocusNodes[index],
        textAlignVertical: TextAlignVertical.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
          counterText: "",
          fillColor: const Color(0xFFFFFFFF),
          filled: true,
          contentPadding: EdgeInsets.only(left: 12.sp),
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
        onChanged: (value) {
          if (value.length == 1) {
            if (index < 5) {
              controller.otpFocusNodes[index + 1].requestFocus();
            } else {
              controller.otpFocusNodes[index].unfocus();
            }
          }
          if (value.isEmpty && index > 0) {
            controller.otpFocusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }
}
