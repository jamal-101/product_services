// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:product_service/utils/constants/app_string.dart';
//
// import '../../../../config/route/app_route.dart';
//
// class IdentityVerificationScreen extends StatelessWidget {
//   const IdentityVerificationScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: false,
//         leading: Padding(
//           padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.grey.shade50,
//               borderRadius: BorderRadius.circular(12.r),
//               border: Border.all(color: Colors.grey.shade100),
//             ),
//             child: IconButton(
//               icon: const Icon(Icons.arrow_back, color: Colors.black, size: 20),
//               onPressed: () => Navigator.pop(context),
//             ),
//           ),
//         ),
//         title: Text(
//           AppString.identityVerification,
//           style: GoogleFonts.montserrat(
//             color: Colors.black,
//             fontSize: 18.sp,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               AppString.identityVerification,
//               style: GoogleFonts.montserrat(
//                 color: Colors.grey.shade700,
//                 fontSize: 13.sp,
//               ),
//             ),
//             SizedBox(height: 20.h),
//
//             // মেইন কার্ড
//             Container(
//               padding: EdgeInsets.all(20.w),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20.r),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withValues(alpha: 0.05),
//                     blurRadius: 10,
//                     offset: const Offset(0, 5),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     AppString.selectType,
//                     style: GoogleFonts.montserrat(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 14.sp,
//                     ),
//                   ),
//                   SizedBox(height: 10.h),
//                   _buildDropdown(),
//                   SizedBox(height: 20.h),
//                   Row(
//                     children: [
//                       Expanded(child: _buildUploadBox(AppString.fontSide)),
//                       SizedBox(width: 15.w),
//                       Expanded(child: _buildUploadBox(AppString.backSide)),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//
//             const Spacer(),
//             SizedBox(
//               width: double.infinity,
//               height: 55.h,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF27AE60),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15.r),
//                   ),
//                 ),
//                 onPressed: () {
//                   Get.toNamed(AppRoutes.accountScreen);
//                 },
//                 child: Text(
//                   AppString.submitVerification,
//                   style: GoogleFonts.montserrat(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16.sp,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20.h),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDropdown() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 15.w),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade50,
//         borderRadius: BorderRadius.circular(12.r),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<String>(
//           isExpanded: true,
//           hint: Text("National ID", style: GoogleFonts.montserrat()),
//           items: [
//             "National ID",
//             "Passport",
//             "Driving License",
//           ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
//           onChanged: (v) {},
//         ),
//       ),
//     );
//   }
//
//   Widget _buildUploadBox(String label) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: GoogleFonts.montserrat(
//             fontWeight: FontWeight.bold,
//             fontSize: 13.sp,
//           ),
//         ),
//         SizedBox(height: 8.h),
//         Container(
//           height: 100.h,
//           decoration: BoxDecoration(
//             color: Colors.grey.shade50,
//             borderRadius: BorderRadius.circular(12.r),
//             border: Border.all(
//               color: Colors.grey.shade300,
//               style: BorderStyle.solid,
//             ),
//           ),
//           child: Center(
//             child: Icon(
//               Icons.add_photo_alternate_outlined,
//               color: Colors.grey.shade400,
//               size: 30.sp,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
//

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/utils/constants/app_string.dart';
import '../controller/indentiti_verification_controller.dart';


class IdentityVerificationScreen extends StatelessWidget {
  const IdentityVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final IdentityVerificationController controller =
    Get.put(IdentityVerificationController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade100),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: Text(
          AppString.identityVerification,
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppString.identityVerification,
              style: GoogleFonts.montserrat(
                color: Colors.grey.shade700,
                fontSize: 13.sp,
              ),
            ),
            SizedBox(height: 20.h),

            // মেইন কার্ড
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppString.selectType,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  _buildDropdown(controller),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Expanded(
                        child: Obx(() => _buildUploadBox(
                          AppString.fontSide,
                          controller.frontImagePath.value,
                              () => controller.pickImage(true),
                        )),
                      ),
                      SizedBox(width: 15.w),
                      Expanded(
                        child: Obx(() => _buildUploadBox(
                          AppString.backSide,
                          controller.backImagePath.value,
                              () => controller.pickImage(false),
                        )),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Submit Button with Loading
            SizedBox(
              width: double.infinity,
              height: 55.h,
              child: Obx(
                    () => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF27AE60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                  ),
                  onPressed: controller.isLoading.value
                      ? null
                      : () => controller.submitVerification(),
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                    AppString.submitVerification,
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(IdentityVerificationController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: DropdownButtonHideUnderline(
        child: Obx(
              () => DropdownButton<String>(
            isExpanded: true,
            value: controller.selectedIdType.value,
            items: [
              "National ID",
              "Passport",
              "Driving License",
            ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: controller.updateIdType,
          ),
        ),
      ),
    );
  }

  Widget _buildUploadBox(String label, String imagePath, VoidCallback onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 13.sp,
          ),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 100.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: Colors.grey.shade300,
                style: BorderStyle.solid,
              ),
              image: imagePath.isNotEmpty
                  ? DecorationImage(
                image: FileImage(File(imagePath)),
                fit: BoxFit.cover,
              )
                  : null,
            ),
            child: imagePath.isEmpty
                ? Center(
              child: Icon(
                Icons.add_photo_alternate_outlined,
                color: Colors.grey.shade400,
                size: 30.sp,
              ),
            )
                : null,
          ),
        ),
      ],
    );
  }
}
