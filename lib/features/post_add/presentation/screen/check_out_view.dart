import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/post_add_controller.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    final PostAddController controller = Get.put(PostAddController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: const Color(0xFFECECF0), width: 1.w),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                offset: const Offset(0, 1),
                blurRadius: 2,
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                height: 120.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.r),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.r),
                  ),
                  child: controller.uploadedBannerPath.value.isNotEmpty
                      ? Image.file(
                    File(controller.uploadedBannerPath.value),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  )
                      : Center(
                    child: Text(
                      "Banner Image Preview",
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  children: [
                    _buildDetailRow("City", "Chattogram"),
                    SizedBox(height: 12.h),
                    _buildDetailRow("Placement", "Featured Top Slider 1"),
                    SizedBox(height: 12.h),
                    _buildDetailRow("Plan", "weekly • 7 days"),
                    SizedBox(height: 12.h),
                    _buildDetailRow("Dates", "Jul 22, 2026 → Jul 29, 2026"),
                    SizedBox(height: 12.h),
                    _buildDetailRow("Visibility", "Premium", isGreen: true),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: const Color(0xFFF0FDF4),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: const Color(0xFFDCFCE7), width: 1.w),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Ad fee",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    "\$120.00",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13.sp,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tax (5%)",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    "\$6.00",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13.sp,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: const Divider(color: Color(0xFFE2E8F0)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "\$126.00",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF166534),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h),
        Text(
          "Payment Method",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: const Color(0xFFECECF0), width: 1.w),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.credit_card, color: Colors.blue, size: 24.sp),
                  SizedBox(width: 12.w),
                  Text(
                    "Card",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Icon(Icons.radio_button_checked, color: Color(0xFF2E7D32)),
            ],
          ),
        ),
      ],
    );
  }
  Widget _buildDetailRow(String title, String value, {bool isGreen = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13.sp,
            color: Colors.grey.shade600,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13.sp,
            fontWeight: FontWeight.bold,
            color: isGreen ? const Color(0xFF166534) : Colors.black87,
          ),
        ),
      ],
    );
  }
}