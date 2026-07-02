import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/config/route/app_route.dart';
import 'package:product_service/features/seller/my_list_flow/presentation/widget/common_button.dart';
import 'package:product_service/utils/constants/app_string.dart';

class EditBrandingScreen extends StatelessWidget {
  const EditBrandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          AppString.editeBinding,
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel(AppString.displayShopName),
            _buildTextField("e.g. Le Reve Organics", 1),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "0/60",
                style: GoogleFonts.montserrat(
                  fontSize: 10.sp,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 20.h),

            _buildLabel(AppString.description),
            _buildTextField(
              "Describe what you sell and what makes your shop unique.",
              4,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "0/300",
                style: GoogleFonts.montserrat(
                  fontSize: 10.sp,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 20.h),

            _buildLabel(AppString.category),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: Text(
                    "Select Category",
                    style: GoogleFonts.montserrat(fontSize: 14.sp),
                  ),
                  items: [],
                  onChanged: (value) {},
                ),
              ),
            ),
            SizedBox(height: 20.h),
            _buildLabel(AppString.binding),
            Container(
              padding: EdgeInsets.all(15.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Branding",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      _buildImagePicker("Logo", "Square, 500x500 px"),
                      SizedBox(width: 15.w),
                      _buildImagePicker("Cover", "16:9 ratio"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20.w),
        child: CommonGradientButton(
          text: AppString.saveChanges,
          onPressed: () {
            Get.toNamed(AppRoutes.homeScreen);
          },
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        text,
        style: GoogleFonts.montserrat(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, int maxLines) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.montserrat(
          fontSize: 14.sp,
          color: Colors.grey.shade400,
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
    );
  }

  Widget _buildImagePicker(String title, String subtitle) {
    return Expanded(
      child: Container(
        height: 120.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: Colors.grey.shade300,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image_outlined,
              color: const Color(0xFF2A9B57),
              size: 30.sp,
            ),
            Text(
              title,
              style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
            ),
            Text(
              subtitle,
              style: GoogleFonts.montserrat(fontSize: 9.sp, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
