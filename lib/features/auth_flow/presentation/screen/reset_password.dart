// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:product_service/config/route/app_route.dart';
// import 'package:product_service/utils/constants/app_images.dart';
// import 'package:product_service/utils/constants/app_string.dart';
// import '../../../../utils/constants/app_color.dart';
// import '../controller/auth_controller.dart';
//
// class ResetPasswordScreen extends StatelessWidget {
//   const ResetPasswordScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<AuthController>();
//     return Scaffold(
//       appBar: AppBar(automaticallyImplyLeading: false),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(horizontal: 24.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 20.h),
//               RichText(
//                 text: TextSpan(
//                   style: GoogleFonts.plusJakartaSans(
//                     fontSize: 28.sp,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   children: [
//                     TextSpan(
//                       text: AppString.reset,
//                       style: GoogleFonts.plusJakartaSans(color: AppColor.textDark),
//                     ),
//                     TextSpan(
//                       text: AppString.password,
//                       style: GoogleFonts.plusJakartaSans(color: AppColor.accent),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 8.h),
//               Text(
//                 AppString.createNew,
//                 style: GoogleFonts.plusJakartaSans(fontSize: 14.sp, color: AppColor.textLight),
//               ),
//               SizedBox(height: 32.h),
//
//               Text(
//                 AppString.newPassword,
//                 style: GoogleFonts.plusJakartaSans(
//                   fontSize: 14.sp,
//                   fontWeight: FontWeight.w500,
//                   color: AppColor.textDark,
//                 ),
//               ),
//               SizedBox(height: 8.h),
//               Obx(
//                 () => TextFormField(
//                   controller: controller.newPasswordController,
//                   obscureText: !controller.isNewPasswordVisible.value,
//                   decoration: InputDecoration(
//                     hintText: AppString.createStrong,
//                     prefixIcon: Padding(
//                       padding: EdgeInsets.only(left: 12.sp,right: 5.sp,top: 12.sp,bottom: 12.sp),
//                       child: Image.asset(AppImages.lockIcon,height: 5.h,width: 5,),
//                     ),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         controller.isNewPasswordVisible.value
//                             ? Icons.visibility_outlined : Icons.visibility_off_outlined,
//                       ),
//                       onPressed: () => controller.isNewPasswordVisible.toggle(),
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12.r),
//                     ),
//                     fillColor: Color(0xFFFFFFFF),
//                     filled: true,
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.r),
//                       borderSide: const BorderSide(
//                         color: Color(0xFFECECF0),
//                         width: 1.5,
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.r),
//                       borderSide: const BorderSide(
//                         color: Color(0xFFECECF0),
//                         width: 2.0,
//                       ),
//                     ),
//                     errorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.r),
//                       borderSide: const BorderSide(
//                         color: Colors.red,
//                         width: 1.0,
//                       ),
//                     ),
//                     focusedErrorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.r),
//                       borderSide: const BorderSide(
//                         color: Colors.red,
//                         width: 2.0,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20.h),
//
//               Text(
//                 AppString.confirmNew,
//                 style: GoogleFonts.plusJakartaSans(
//                   fontSize: 14.sp,
//                   fontWeight: FontWeight.w500,
//                   color: AppColor.textDark,
//                 ),
//               ),
//               SizedBox(height: 8.h),
//               Obx(
//                 () => TextFormField(
//                   controller: controller.confirmPasswordController,
//                   obscureText: !controller.isConfirmPasswordVisible.value,
//                   decoration: InputDecoration(
//                     hintText: AppString.reEnter,
//                     prefixIcon: Padding(
//                       padding: EdgeInsets.only(left: 12.sp,right: 5.sp,top: 12.sp,bottom: 12.sp),
//                       child: Image.asset(AppImages.lockIcon,height: 5.h,width: 5,),
//                     ),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         controller.isConfirmPasswordVisible.value
//                             ?  Icons.visibility_outlined : Icons.visibility_off_outlined
//                       ),
//                       onPressed: () =>
//                           controller.isConfirmPasswordVisible.toggle(),
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.r),
//                     ),
//                     fillColor: Color(0xFFFFFFFF),
//                     filled: true,
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.r),
//                       borderSide: const BorderSide(
//                         color: Color(0xFFECECF0),
//                         width: 1.5,
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.r),
//                       borderSide: const BorderSide(
//                         color: Color(0xFFECECF0),
//                         width: 2.0,
//                       ),
//                     ),
//                     errorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.r),
//                       borderSide: const BorderSide(
//                         color: Colors.red,
//                         width: 1.0,
//                       ),
//                     ),
//                     focusedErrorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.r),
//                       borderSide: const BorderSide(
//                         color: Colors.red,
//                         width: 2.0,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 40.h),
//
//               SizedBox(
//                 width: double.infinity,
//                 height: 50.h,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColor.primary,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10.r),
//                     ),
//                   ),
//                   onPressed: () {
//                     Get.offAllNamed(AppRoutes.loginScreen);
//                   },
//                   child: Text(
//                     AppString.resterPassword,
//                     style: GoogleFonts.plusJakartaSans(
//                       fontSize: 16.sp,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/utils/constants/app_images.dart';
import 'package:product_service/utils/constants/app_string.dart';
import '../../../../utils/constants/app_color.dart';
import '../controller/auth_controller.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  // ফর্ম ভ্যালিডেশনের জন্য GlobalKey
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
                        text: AppString.reset,
                        style: GoogleFonts.plusJakartaSans(color: AppColor.textDark),
                      ),
                      TextSpan(
                        text: AppString.password,
                        style: GoogleFonts.plusJakartaSans(color: AppColor.accent),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  AppString.createNew,
                  style: GoogleFonts.plusJakartaSans(fontSize: 14.sp, color: AppColor.textLight),
                ),
                SizedBox(height: 32.h),

                // নতুন পাসওয়ার্ড ফিল্ড
                Text(
                  AppString.newPassword,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColor.textDark,
                  ),
                ),
                SizedBox(height: 8.h),
                Obx(
                      () => TextFormField(
                    controller: controller.newPasswordController,
                    obscureText: !controller.isNewPasswordVisible.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter new password";
                      }
                      if (value.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: AppString.createStrong,
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 12.sp, right: 5.sp, top: 12.sp, bottom: 12.sp),
                        child: Image.asset(AppImages.lockIcon, height: 5.h, width: 5),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isNewPasswordVisible.value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        onPressed: () => controller.isNewPasswordVisible.toggle(),
                      ),
                      fillColor: const Color(0xFFFFFFFF),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
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
                SizedBox(height: 20.h),

                // কনফার্ম পাসওয়ার্ড ফিল্ড
                Text(
                  AppString.confirmNew,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColor.textDark,
                  ),
                ),
                SizedBox(height: 8.h),
                Obx(
                      () => TextFormField(
                    controller: controller.confirmPasswordController,
                    obscureText: !controller.isConfirmPasswordVisible.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please confirm your password";
                      }
                      if (value != controller.newPasswordController.text) {
                        return "Passwords do not match";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: AppString.reEnter,
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 12.sp, right: 5.sp, top: 12.sp, bottom: 12.sp),
                        child: Image.asset(AppImages.lockIcon, height: 5.h, width: 5),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isConfirmPasswordVisible.value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        onPressed: () => controller.isConfirmPasswordVisible.toggle(),
                      ),
                      fillColor: const Color(0xFFFFFFFF),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
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
                SizedBox(height: 40.h),

                // রিসেট পাসওয়ার্ড বাটন ও লোডিং ইন্ডিকেটর
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
                      onPressed: controller.isResetLoading.value
                          ? null
                          : () {
                        if (_formKey.currentState!.validate()) {
                          // ভ্যালিডেশন পাস করলে API কল হবে
                          controller.resetPassword();
                        }
                      },
                      child: controller.isResetLoading.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                        AppString.resterPassword,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}