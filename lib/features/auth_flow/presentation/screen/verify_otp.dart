// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:product_service/config/route/app_route.dart';
// import '../../../../utils/constants/app_color.dart';
// import '../controller/auth_controller.dart';
//
// class VerifyOtpScreen extends StatelessWidget {
//   const VerifyOtpScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<AuthController>();
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: const BackButton(color: Colors.black),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 24.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 20.h),
//               RichText(
//                 text: TextSpan(
//                   style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
//                   children: const [
//                     TextSpan(text: "Verify ", style: TextStyle(color: AppColor.textDark)),
//                     TextSpan(text: "OTP", style: TextStyle(color: AppColor.accent)),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 8.h),
//               Text(
//                 "Enter the 6-digit code we've sent to your email\nyourname@example.com",
//                 style: TextStyle(fontSize: 14.sp, color: AppColor.textLight, height: 1.4),
//               ),
//               SizedBox(height: 40.h),
//
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: List.generate(6, (index) => _buildOtpField(context, index)),
//               ),
//               SizedBox(height: 32.h),
//
//               Center(
//                 child: Obx(() => RichText(
//                   text: TextSpan(
//                     style: TextStyle(fontSize: 14.sp, color: AppColor.textLight),
//                     children: [
//                       const TextSpan(text: "Resend OTP in "),
//                       TextSpan(
//                         text: "${controller.resendCountdown.value}s",
//                         style: const TextStyle(color: AppColor.accent, fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 )),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildOtpField(BuildContext context, int index) {
//     return SizedBox(
//       width: 44.w,
//       height: 50.h,
//       child: TextFormField(
//         onChanged: (value) {
//           if (value.length == 1) {
//             FocusScope.of(context).nextFocus();
//             if (index == 5) {
//               Get.toNamed(AppRoutes.resetPassword);
//             }
//           }
//           if (value.isEmpty) {
//             FocusScope.of(context).previousFocus();
//           }
//         },
//         textAlign: TextAlign.center,
//         keyboardType: TextInputType.number,
//         maxLength: 1,
//         style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
//         decoration: InputDecoration(
//           counterText: "",
//           enabledBorder: OutlineInputBorder(
//             borderSide: const BorderSide(color: Colors.grey),
//             borderRadius: BorderRadius.circular(10.r),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: const BorderSide(color: AppColor.primary, width: 2),
//             borderRadius: BorderRadius.circular(10.r),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:product_service/config/route/app_route.dart';
import '../../../../utils/constants/app_color.dart';
import '../controller/auth_controller.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {

  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  final List<TextEditingController> _textControllers = List.generate(6, (index) => TextEditingController());

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    for (var controller in _textControllers) {
      controller.dispose();
    }
    super.dispose();
  }

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
                    TextSpan(text: "OTP", style: TextStyle(color: AppColor.accent)),
                  ],
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "Enter the 6-digit code we've sent to your email\nyourname@example.com",
                style: TextStyle(fontSize: 14.sp, color: AppColor.textLight, height: 1.4),
              ),
              SizedBox(height: 40.h),

              // ওটিপি ফিল্ডস
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) => _buildOtpField(context, index)),
              ),
              SizedBox(height: 32.h),

              Center(
                child: Obx(() => RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 14.sp, color: AppColor.textLight),
                    children: [
                      const TextSpan(text: "Resend OTP in "),
                      TextSpan(
                        text: "${controller.resendCountdown.value}s",
                        style: const TextStyle(color: AppColor.accent, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )),
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
        controller: _textControllers[index],
        focusNode: _focusNodes[index],
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
        onChanged: (value) {
          if (value.length == 1) {
            if (index < 5) {
              _focusNodes[index + 1].requestFocus();
            } else {
              _focusNodes[index].unfocus();
              Get.toNamed(AppRoutes.resetPassword);
            }
          }
          if (value.isEmpty && index > 0) {
            _focusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }
}