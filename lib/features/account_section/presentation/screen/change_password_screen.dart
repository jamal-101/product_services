import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/utils/constants/app_string.dart';
import '../../../../utils/constants/app_utils.dart';
import '../controller/change_password_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChangePasswordController());

    return Scaffold(
      appBar: AppBar(
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
          'changePassword'.tr,
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
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
                    Obx(() => _buildPasswordField(
                      label: 'currentPassword'.tr,
                      hint: 'enterCurrentPassword'.tr,
                      textEditingController: controller.currentPasswordController,
                      isHidden: controller.isCurrentPasswordHidden.value,
                      onToggle: controller.toggleCurrentPasswordVisibility,
                      validator: (value) => Utils.passwordValidator(value),
                    )),

                    Obx(() => _buildPasswordField(
                      label: 'newPassword'.tr,
                      hint: 'enterNewPassword'.tr,
                      textEditingController: controller.newPasswordController,
                      isHidden: controller.isNewPasswordHidden.value,
                      onToggle: controller.toggleNewPasswordVisibility,
                      validator: (value) => Utils.passwordValidator(value),
                    )),

                    Padding(
                      padding: EdgeInsets.only(bottom: 15.h),
                      child: Text(
                        'minCharacters'.tr,
                        style: GoogleFonts.montserrat(
                          fontSize: 12.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),

                    Obx(() => _buildPasswordField(
                      label: 'confirmNewPassword'.tr,
                      hint: 'confirmNewPasswordHint'.tr,
                      textEditingController: controller.confirmPasswordController,
                      isHidden: controller.isConfirmPasswordHidden.value,
                      onToggle: controller.toggleConfirmPasswordVisibility,
                      validator: (value) => Utils.confirmPasswordValidator(
                        value,
                        controller.newPasswordController.text,
                      ),
                    )),
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              SizedBox(
                width: double.infinity,
                height: 55.h,
                child: Obx(() => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF27AE60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                  ),
                  onPressed: controller.isLoading.value
                      ? null
                      : () {
                    controller.changePasswordApiCall();
                  },
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                    'saveChanges'.tr,
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required String label,
    required String hint,
    required TextEditingController textEditingController,
    required bool isHidden,
    required VoidCallback onToggle,
    required String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 13.sp,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: textEditingController,
          obscureText: isHidden,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.montserrat(fontSize: 14.sp, color: Colors.grey.shade400),
            suffixIcon: IconButton(
              icon: Icon(
                isHidden ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                color: Colors.grey,
              ),
              onPressed: onToggle,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            filled: true,
            fillColor: Colors.grey.shade50,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFF27AE60)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }
}