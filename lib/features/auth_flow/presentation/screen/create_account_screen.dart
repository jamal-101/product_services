import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/utils/constants/app_images.dart';
import 'package:product_service/utils/constants/app_string.dart';
import '../../../../config/route/app_route.dart';
import '../../../../utils/constants/app_color.dart';
import '../controller/auth_controller.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
              icon: const Icon(Icons.arrow_back, color: Colors.black, size: 20),
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
                  children:  [
                    TextSpan(
                      text: AppString.create,
                      style: GoogleFonts.plusJakartaSans(color: AppColor.textDark),
                    ),
                    TextSpan(
                      text: AppString.account,
                      style: GoogleFonts.plusJakartaSans(color: AppColor.accent),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                AppString.quickSingUp,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16.sp,
                  color: AppColor.textLight,
                ),
              ),
              SizedBox(height: 24.h),

              // Fields
              _buildCommonTextField(
                label: AppString.fullName,
                hint: "John Doe",
                imagePath: AppImages.personIcon,
                controller: controller.registerNameController,
              ),
              SizedBox(height: 16.h),
              _buildCommonTextField(
                label: AppString.phoneNumber,
                hint: "+1 555 000 0000",
               imagePath: AppImages.callIcon,
                controller: controller.registerPhoneController,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16.h),
              _buildCommonTextField(
                label: AppString.email,
                hint: "you@example.com",
                imagePath: AppImages.emailSymbol,
                controller: controller.registerEmailController,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.h),
              _buildPasswordField(
                label: AppString.password,
                imagePath: AppImages.passwordSymbol,
                controller: controller.registerPasswordController,
                isVisible: controller.isRegisterPasswordVisible,
              ),
              SizedBox(height: 16.h),
              _buildPasswordField(
                imagePath: AppImages.passwordSymbol,
                label: AppString.confirmPassword,
                controller: controller.registerConfirmPasswordController,
                isVisible: controller.isRegisterConfirmPasswordVisible,
              ),

              SizedBox(height: 32.h),

              // Button
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                  onPressed: () => Get.toNamed(AppRoutes.verifyPhone),
                  child: Text(
                    AppString.createAccount,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              // Login Link
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
                        TextSpan(text: AppString.alreadyHave),
                        TextSpan(
                          text: AppString.login,
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
  }
  Widget _buildCommonTextField({
    required String label,
    required String hint,
    required String imagePath,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
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
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 16.sp,right: 5.sp,top: 14.sp,bottom: 16),
              child: Image.asset(imagePath,height: 5.h,width: 5.w),
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
    required RxBool isVisible,
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
        Obx(
          () => TextFormField(
            controller: controller,
            obscureText: !isVisible.value,
            decoration: InputDecoration(
              hintText: "••••••••",
              prefixIcon:Padding(
                padding: EdgeInsets.only(left: 16.sp,right: 5.sp,top: 14.sp,bottom: 16),
                child: Image.asset(imagePath,height: 5.h,width: 5.w,),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  isVisible.value
                      ? Icons.visibility_outlined :  Icons.visibility_off_outlined
                      ,
                  color: AppColor.textLight,
                ),
                onPressed: () => isVisible.toggle(),
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
        ),
      ],
    );
  }
}
