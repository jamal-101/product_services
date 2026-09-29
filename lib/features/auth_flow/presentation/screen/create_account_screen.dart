// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:product_service/features/account_section/presentation/screen/privacy_policy_screen.dart';
// import 'package:product_service/features/account_section/presentation/screen/terms_and_conditation_screen.dart';
// import 'package:product_service/utils/constants/app_images.dart';
// import 'package:product_service/utils/constants/app_string.dart';
// import '../../../../utils/constants/app_color.dart';
// import '../../../../utils/constants/app_utils.dart';
// import '../controller/auth_controller.dart';
//
// class CreateAccountScreen extends StatelessWidget {
//   const CreateAccountScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<AuthController>(
//       builder: (controller) {
//         return Scaffold(
//           appBar: AppBar(
//             surfaceTintColor: AppColor.appBackgroundColor,
//             elevation: 0,
//             leading: Padding(
//               padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12.r),
//                   border: Border.all(color: const Color(0xFFECECF0)),
//                 ),
//                 child: IconButton(
//                   icon: const Icon(
//                     Icons.arrow_back,
//                     color: Colors.black,
//                     size: 20,
//                   ),
//                   onPressed: () => Get.back(),
//                 ),
//               ),
//             ),
//           ),
//           body: SafeArea(
//             child: SingleChildScrollView(
//               padding: EdgeInsets.symmetric(horizontal: 24.w),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 10.h),
//                   RichText(
//                     text: TextSpan(
//                       style: GoogleFonts.montserrat(
//                         fontSize: 28.sp,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       children: [
//                         TextSpan(
//                           text: AppString.create.tr,
//                           style: GoogleFonts.plusJakartaSans(
//                             color: AppColor.textDark,
//                           ),
//                         ),
//                         TextSpan(
//                           text: AppString.account.tr,
//                           style: GoogleFonts.plusJakartaSans(
//                             color: AppColor.accent,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 4.h),
//                   Text(
//                     AppString.quickSingUp.tr,
//                     style: GoogleFonts.plusJakartaSans(
//                       fontSize: 16.sp,
//                       color: AppColor.textLight,
//                     ),
//                   ),
//                   SizedBox(height: 24.h),
//                   _buildCommonTextField(
//                     label: AppString.fullName.tr,
//                     hint: "John Doe",
//                     imagePath: AppImages.personIcon,
//                     controller: controller.registerNameController,
//                     // validator: Utils.fullNameValidator,
//                   ),
//                   SizedBox(height: 16.h),
//                   _buildCommonTextField(
//                     label: AppString.phoneNumber.tr,
//                     hint: "+1 555 000 0000",
//                     imagePath: AppImages.callIcon,
//                     controller: controller.registerPhoneController,
//                     keyboardType: TextInputType.phone,
//                     validator: Utils.phoneValidator,
//                   ),
//                   SizedBox(height: 16.h),
//                   _buildCommonTextField(
//                     label: AppString.email.tr,
//                     hint: "you@example.com",
//                     imagePath: AppImages.emailSymbol,
//                     controller: controller.registerEmailController,
//                     keyboardType: TextInputType.emailAddress,
//                     validator: Utils.emailValidator,
//                   ),
//                   SizedBox(height: 16.h),
//                   _buildPasswordField(
//                     label: AppString.password.tr,
//                     imagePath: AppImages.passwordSymbol,
//                     controller: controller.registerPasswordController,
//                     isVisible: controller.isRegisterPasswordVisible.value,
//                     onVisibilityChanged: () =>
//                         controller.toggleRegisterPasswordVisibility(),
//                     validator: Utils.passwordValidator,
//                   ),
//                   SizedBox(height: 16.h),
//                   _buildPasswordField(
//                     imagePath: AppImages.passwordSymbol,
//                     label: AppString.confirmPassword.tr,
//                     controller: controller.registerConfirmPasswordController,
//                     isVisible:
//                         controller.isRegisterConfirmPasswordVisible.value,
//                     onVisibilityChanged: () =>
//                         controller.toggleRegisterConfirmPasswordVisibility(),
//                     validator: (value) => Utils.confirmPasswordValidator(
//                       value,
//                       controller.registerPasswordController.text,
//                     ),
//                   ),
//                   SizedBox(height: 16.h),
//                   // ================= [ Document Type Dropdown ] =================
//                   SizedBox(height: 16.h),
//                   Text(
//                     "Select Document Type",
//                     style: GoogleFonts.montserrat(
//                       fontSize: 14.sp,
//                       fontWeight: FontWeight.w500,
//                       color: AppColor.textDark,
//                     ),
//                   ),
//                   SizedBox(height: 8.h),
//                   Obx(() => Container(
//                     padding: EdgeInsets.symmetric(horizontal: 16.w),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10.r),
//                       border: Border.all(
//                           color: const Color(0xFFECECF0), width: 1.5),
//                     ),
//                     child: DropdownButtonHideUnderline(
//                       child: DropdownButton<String>(
//                         value: controller.selectedDocumentType.value,
//                         isExpanded: true,
//                         items: controller.documentTypeController.map((String type) {
//                           return DropdownButtonMenuItem<String>(
//                             value: type,
//                             child: Text(
//                               type.toUpperCase(),
//                               style: GoogleFonts.plusJakartaSans(
//                                   fontSize: 14.sp),
//                             ),
//                           );
//                         }).toList(),
//                         onChanged: (String? newValue) {
//                           if (newValue != null) {
//                             controller.selectedDocumentType.value = newValue;
//                           }
//                         },
//                       ),
//                     ),
//                   )),
//
//                   // ================= [ Document Number TextField ] =================
//                   SizedBox(height: 16.h),
//                   _buildCommonTextField(
//                     label: "Document Number",
//                     hint: "Enter document number",
//                     imagePath: AppImages.personIcon,
//                     controller: controller.documentNumberController,
//                     keyboardType: TextInputType.text,
//                   ),
//
//                   // ================= [ Front & Back Image Pickers ] =================
//                   SizedBox(height: 16.h),
//                   Row(
//                     children: [
//                       // Front Side Box
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Front Side",
//                               style: GoogleFonts.montserrat(
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.w500,
//                                 color: AppColor.textDark,
//                               ),
//                             ),
//                             SizedBox(height: 8.h),
//                             GestureDetector(
//                               onTap: () => controller.pickDocumentImage(true),
//                               child: Obx(() => Container(
//                                 height: 110.h,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(12.r),
//                                   border: Border.all(
//                                     color: const Color(0xFFECECF0),
//                                     width: 1.5,
//                                   ),
//                                 ),
//                                 child: controller.documentFrontImage.value !=
//                                     null
//                                     ? ClipRRect(
//                                   borderRadius:
//                                   BorderRadius.circular(12.r),
//                                   child: Image.file(
//                                     controller
//                                         .documentFrontImage.value!,
//                                     fit: BoxFit.cover,
//                                     width: double.infinity,
//                                   ),
//                                 )
//                                     : Center(
//                                   child: Icon(
//                                     Icons.add_photo_alternate_outlined,
//                                     color: AppColor.primary,
//                                     size: 32.sp,
//                                   ),
//                                 ),
//                               )),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(width: 16.w),
//                       // Back Side Box
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Back Side",
//                               style: GoogleFonts.montserrat(
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.w500,
//                                 color: AppColor.textDark,
//                               ),
//                             ),
//                             SizedBox(height: 8.h),
//                             GestureDetector(
//                               onTap: () => controller.pickDocumentImage(false),
//                               child: Obx(() => Container(
//                                 height: 110.h,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(12.r),
//                                   border: Border.all(
//                                     color: const Color(0xFFECECF0),
//                                     width: 1.5,
//                                   ),
//                                 ),
//                                 child: controller.documentBackImage.value !=
//                                     null
//                                     ? ClipRRect(
//                                   borderRadius:
//                                   BorderRadius.circular(12.r),
//                                   child: Image.file(
//                                     controller
//                                         .documentBackImage.value!,
//                                     fit: BoxFit.cover,
//                                     width: double.infinity,
//                                   ),
//                                 )
//                                     : Center(
//                                   child: Icon(
//                                     Icons.add_photo_alternate_outlined,
//                                     color: AppColor.primary,
//                                     size: 32.sp,
//                                   ),
//                                 ),
//                               )),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       SizedBox(
//                         height: 24.w,
//                         width: 24.w,
//                         child: Obx(
//                           () => Checkbox(
//                             value: controller.isTermsAccepted.value,
//                             onChanged: controller.toggleTermsAccepted,
//                             activeColor: AppColor.primary,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(4.r),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 12.w),
//                       Expanded(
//                         child: Wrap(
//                           children: [
//                             Text(
//                               "I agree to the ",
//                               style: GoogleFonts.plusJakartaSans(
//                                 fontSize: 14.sp,
//                                 color: AppColor.textLight,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 Get.to(TermsConditaionScreen());
//                               },
//                               child: Text(
//                                 "Terms & Conditions",
//                                 style: GoogleFonts.plusJakartaSans(
//                                   fontSize: 14.sp,
//                                   color: AppColor.primary,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ),
//                             Text(
//                               " and ",
//                               style: GoogleFonts.plusJakartaSans(
//                                 fontSize: 14.sp,
//                                 color: AppColor.textLight,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 Get.to(PrivacyPolicyScreen());
//                               },
//                               child: Text(
//                                 "Privacy Policy",
//                                 style: GoogleFonts.plusJakartaSans(
//                                   fontSize: 14.sp,
//                                   color: AppColor.primary,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 32.h),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 50.h,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColor.primary,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(14.r),
//                         ),
//                       ),
//                       onPressed: controller.isLoading.value
//                           ? null
//                           : () {
//                               if (!controller.isTermsAccepted.value) {
//                                 Get.rawSnackbar(
//                                   messageText: Text(
//                                     "Please accept the Terms & Conditions to continue",
//                                     style: GoogleFonts.plusJakartaSans(
//                                       fontSize: 13.sp,
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                   backgroundColor: Colors.red.shade600,
//                                   snackPosition: SnackPosition.TOP,
//                                   margin: EdgeInsets.all(16.w),
//                                   borderRadius: 12.r,
//                                   duration: const Duration(seconds: 3),
//                                   icon: const Icon(
//                                     Icons.error_outline,
//                                     color: Colors.white,
//                                   ),
//                                 );
//                                 return;
//                               }
//                               controller.signUp();
//                             },
//                       child: controller.isLoading.value
//                           ? const CircularProgressIndicator(color: Colors.white)
//                           : Text(
//                               AppString.createAccount.tr,
//                               style: GoogleFonts.plusJakartaSans(
//                                 fontSize: 16.sp,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                     ),
//                   ),
//                   SizedBox(height: 24.h),
//                   Center(
//                     child: GestureDetector(
//                       onTap: () => Get.back(),
//                       child: RichText(
//                         text: TextSpan(
//                           style: GoogleFonts.plusJakartaSans(
//                             fontSize: 16.sp,
//                             color: AppColor.textLight,
//                           ),
//                           children: [
//                             TextSpan(text: AppString.alreadyHave.tr),
//                             TextSpan(
//                               text: AppString.login.tr,
//                               style: GoogleFonts.plusJakartaSans(
//                                 color: AppColor.primary,
//                                 fontSize: 16.sp,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 24.h),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildCommonTextField({
//     required String label,
//     required String hint,
//     required String imagePath,
//     required TextEditingController controller,
//     TextInputType keyboardType = TextInputType.text,
//     String? Function(String?)? validator,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: GoogleFonts.montserrat(
//             fontSize: 14.sp,
//             fontWeight: FontWeight.w500,
//             color: AppColor.textDark,
//           ),
//         ),
//         SizedBox(height: 8.h),
//         TextFormField(
//           controller: controller,
//           keyboardType: keyboardType,
//           validator: validator,
//           autovalidateMode: AutovalidateMode.onUserInteraction,
//           decoration: InputDecoration(
//             hintText: hint,
//             prefixIcon: Padding(
//               padding: EdgeInsets.only(
//                 left: 16.sp,
//                 right: 5.sp,
//                 top: 14.sp,
//                 bottom: 16,
//               ),
//               child: Image.asset(imagePath, height: 5.h, width: 5.w),
//             ),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10.r),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10.r),
//               borderSide: const BorderSide(
//                 color: Color(0xFFECECF0),
//                 width: 1.5,
//               ),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10.r),
//               borderSide: const BorderSide(
//                 color: Color(0xFFECECF0),
//                 width: 2.0,
//               ),
//             ),
//             errorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10.r),
//               borderSide: const BorderSide(color: Colors.red, width: 1.0),
//             ),
//             focusedErrorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10.r),
//               borderSide: const BorderSide(color: Colors.red, width: 2.0),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildPasswordField({
//     required String label,
//     required TextEditingController controller,
//     required String imagePath,
//     required bool isVisible,
//     required VoidCallback onVisibilityChanged,
//     String? Function(String?)? validator,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: GoogleFonts.montserrat(
//             fontSize: 14.sp,
//             fontWeight: FontWeight.w500,
//             color: AppColor.textDark,
//           ),
//         ),
//         SizedBox(height: 8.h),
//         TextFormField(
//           controller: controller,
//           obscureText: !isVisible,
//           validator: validator,
//           autovalidateMode: AutovalidateMode.onUserInteraction,
//           decoration: InputDecoration(
//             hintText: "••••••••",
//             prefixIcon: Padding(
//               padding: EdgeInsets.only(
//                 left: 16.sp,
//                 right: 5.sp,
//                 top: 14.sp,
//                 bottom: 16,
//               ),
//               child: Image.asset(imagePath, height: 5.h, width: 5.w),
//             ),
//             suffixIcon: IconButton(
//               icon: Icon(
//                 isVisible
//                     ? Icons.visibility_outlined
//                     : Icons.visibility_off_outlined,
//                 color: AppColor.textLight,
//               ),
//               onPressed: onVisibilityChanged,
//             ),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10.r),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10.r),
//               borderSide: const BorderSide(
//                 color: Color(0xFFECECF0),
//                 width: 1.5,
//               ),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10.r),
//               borderSide: const BorderSide(
//                 color: Color(0xFFECECF0),
//                 width: 2.0,
//               ),
//             ),
//             errorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10.r),
//               borderSide: const BorderSide(color: Colors.red, width: 1.0),
//             ),
//             focusedErrorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10.r),
//               borderSide: const BorderSide(color: Colors.red, width: 2.0),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/features/account_section/presentation/screen/privacy_policy_screen.dart';
import 'package:product_service/features/account_section/presentation/screen/terms_and_conditation_screen.dart';
import 'package:product_service/utils/constants/app_images.dart';
import 'package:product_service/utils/constants/app_string.dart';
import '../../../../utils/constants/app_color.dart';
import '../../../../utils/constants/app_utils.dart';
import '../controller/auth_controller.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            surfaceTintColor: AppColor.appBackgroundColor,
            elevation: 0,
            leading: Padding(
              padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: const Color(0xFFECECF0)),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 20,
                  ),
                  onPressed: () => Get.back(),
                ),
              ),
            ),
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
                      style: GoogleFonts.montserrat(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: AppString.create.tr,
                          style: GoogleFonts.plusJakartaSans(
                            color: AppColor.textDark,
                          ),
                        ),
                        TextSpan(
                          text: AppString.account.tr,
                          style: GoogleFonts.plusJakartaSans(
                            color: AppColor.accent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    AppString.quickSingUp.tr,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16.sp,
                      color: AppColor.textLight,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  _buildCommonTextField(
                    label: AppString.fullName.tr,
                    hint: "John Doe",
                    imagePath: AppImages.personIcon,
                    controller: controller.registerNameController,
                  ),
                  SizedBox(height: 16.h),
                  _buildCommonTextField(
                    label: AppString.phoneNumber.tr,
                    hint: "+1 555 000 0000",
                    imagePath: AppImages.callIcon,
                    controller: controller.registerPhoneController,
                    keyboardType: TextInputType.phone,
                    validator: Utils.phoneValidator,
                  ),
                  SizedBox(height: 16.h),
                  _buildCommonTextField(
                    label: AppString.email.tr,
                    hint: "you@example.com",
                    imagePath: AppImages.emailSymbol,
                    controller: controller.registerEmailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: Utils.emailValidator,
                  ),
                  SizedBox(height: 16.h),
                  _buildPasswordField(
                    label: AppString.password.tr,
                    imagePath: AppImages.passwordSymbol,
                    controller: controller.registerPasswordController,
                    isVisible: controller.isRegisterPasswordVisible.value,
                    onVisibilityChanged: () =>
                        controller.toggleRegisterPasswordVisibility(),
                    validator: Utils.passwordValidator,
                  ),
                  SizedBox(height: 16.h),
                  _buildPasswordField(
                    imagePath: AppImages.passwordSymbol,
                    label: AppString.confirmPassword.tr,
                    controller: controller.registerConfirmPasswordController,
                    isVisible:
                    controller.isRegisterConfirmPasswordVisible.value,
                    onVisibilityChanged: () =>
                        controller.toggleRegisterConfirmPasswordVisibility(),
                    validator: (value) => Utils.confirmPasswordValidator(
                      value,
                      controller.registerPasswordController.text,
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // ================= [ Document Type Dropdown ] =================
                  // ================= [ Document Type Dropdown ] =================
                  Text(
                    "Select Document Type",
                    style: GoogleFonts.montserrat(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColor.textDark,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Obx(() => Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: const Color(0xFFECECF0), width: 1.5),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        // ১. বর্তমান সিলেক্টেড মান (যদি খালি না থাকে)
                        value: controller.selectedDocumentType.value.isEmpty
                            ? null
                            : controller.selectedDocumentType.value,
                        isExpanded: true,
                        hint: Text(
                          "Select document type",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14.sp,
                            color: AppColor.textLight,
                          ),
                        ),
                        items: controller.documentTypes.map((String type) {
                          return DropdownMenuItem<String>( // ✅ সঠিক উইজেট নাম
                            value: type,
                            child: Text(
                              type.toUpperCase(),
                              style: GoogleFonts.plusJakartaSans(fontSize: 14.sp),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            controller.selectedDocumentType.value = newValue; // ✅ মান আপডেট করা
                          }
                        },
                      ),
                    ),
                  )),
                  SizedBox(height: 16.h),
                  _buildCommonTextField(
                    label: "Document Number",
                    hint: "Enter document number",
                    imagePath: AppImages.personIcon,
                    controller: controller.documentNumberController,
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(
                        child: Obx(() => _buildImagePickerBox(
                          title: "Front Side",
                          imageFile: controller.documentFrontImage.value,
                          onTap: () => controller.pickDocumentImage(true),
                        )),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Obx(() => _buildImagePickerBox(
                          title: "Back Side",
                          imageFile: controller.documentBackImage.value,
                          onTap: () => controller.pickDocumentImage(false),
                        )),
                      ),
                    ],
                  ),
                  SizedBox(height: 40.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 24.w,
                        width: 24.w,
                        child: Obx(
                              () => Checkbox(
                            value: controller.isTermsAccepted.value,
                            onChanged: controller.toggleTermsAccepted,
                            activeColor: AppColor.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Wrap(
                          children: [
                            Text(
                              "I agree to the ",
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14.sp,
                                color: AppColor.textLight,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(TermsConditaionScreen());
                              },
                              child: Text(
                                "Terms & Conditions",
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14.sp,
                                  color: AppColor.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text(
                              " and ",
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14.sp,
                                color: AppColor.textLight,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(PrivacyPolicyScreen());
                              },
                              child: Text(
                                "Privacy Policy",
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14.sp,
                                  color: AppColor.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32.h),
                  SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: Obx(() => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                      ),
                      onPressed: controller.isLoading.value
                          ? null
                          : () {
                        if (!controller.isTermsAccepted.value) {
                          Get.rawSnackbar(
                            messageText: Text(
                              "Please accept the Terms & Conditions to continue",
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 13.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            backgroundColor: Colors.red.shade600,
                            snackPosition: SnackPosition.TOP,
                            margin: EdgeInsets.all(16.w),
                            borderRadius: 12.r,
                            duration: const Duration(seconds: 3),
                            icon: const Icon(
                              Icons.error_outline,
                              color: Colors.white,
                            ),
                          );
                          return;
                        }
                        controller.signUp();
                      },
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator(
                          color: Colors.white)
                          : Text(
                        AppString.createAccount.tr,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
                  ),
                  SizedBox(height: 24.h),
                  Center(
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: RichText(
                        text: TextSpan(
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 16.sp,
                            color: AppColor.textLight,
                          ),
                          children: [
                            TextSpan(text: AppString.alreadyHave.tr),
                            TextSpan(
                              text: AppString.login.tr,
                              style: GoogleFonts.plusJakartaSans(
                                color: AppColor.primary,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
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
      },
    );
  }

  Widget _buildCommonTextField({
    required String label,
    required String hint,
    required String imagePath,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColor.textDark,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Padding(
              padding: EdgeInsets.only(
                left: 16.sp,
                right: 5.sp,
                top: 14.sp,
                bottom: 16,
              ),
              child: Image.asset(imagePath, height: 5.h, width: 5.w),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
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
              borderSide: const BorderSide(color: Colors.red, width: 1.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: Colors.red, width: 2.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required String imagePath,
    required bool isVisible,
    required VoidCallback onVisibilityChanged,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColor.textDark,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          obscureText: !isVisible,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            hintText: "••••••••",
            prefixIcon: Padding(
              padding: EdgeInsets.only(
                left: 16.sp,
                right: 5.sp,
                top: 14.sp,
                bottom: 16,
              ),
              child: Image.asset(imagePath, height: 5.h, width: 5.w),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                isVisible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: AppColor.textLight,
              ),
              onPressed: onVisibilityChanged,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
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
              borderSide: const BorderSide(color: Colors.red, width: 1.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: Colors.red, width: 2.0),
            ),
          ),
        ),
      ],
    );
  }


  Widget _buildImagePickerBox({
    required String title,
    required File? imageFile,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.montserrat(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColor.textDark,
          ),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 130.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF9F9FB),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: const Color(0xFFECECF0),
                width: 1.5,
              ),
            ),
            child: imageFile != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.file(
                imageFile,
                fit: BoxFit.cover,
              ),
            )
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.cloud_upload_outlined,
                  size: 32.sp,
                  color: AppColor.primary,
                ),
                SizedBox(height: 8.h),
                Text(
                  "Upload",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12.sp,
                    color: AppColor.textLight,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

}