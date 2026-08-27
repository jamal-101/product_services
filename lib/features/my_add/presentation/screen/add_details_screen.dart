import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/utils/constants/app_images.dart';
import 'edite_add_screen.dart';

class AddDetailsScreen extends StatelessWidget {
  const AddDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(8.r),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Get.back(),
            ),
          ),
        ),
        title: Text(
          "Ad Details",
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        actions: [
          TextButton.icon(
            onPressed: () => Get.to(() => EditeAddScreen()),
            icon: const Icon(Icons.edit, color: Colors.orange, size: 18),
            label: Text(
              "Edit",
              style: GoogleFonts.plusJakartaSans(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
                fontSize: 15.sp,
              ),
            ),
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.asset(
                  AppImages.storeCoverImage,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: const Color(0xFFECECF0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade50,
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            "Pending",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange.shade800,
                            ),
                          ),
                        ),
                        Text(
                          "\$36.75",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF2E7D32),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "Gree",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF111827),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        "Premium",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12.sp,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    const Divider(color: Color(0xFFECECF0)),
                    SizedBox(height: 16.h),

                    // সিটি এবং প্ল্যান রো
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "City",
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12.sp,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Row(
                                children: [
                                  const Icon(Icons.location_on_outlined, size: 16, color: Color(0xFF2E7D32)),
                                  SizedBox(width: 4.w),
                                  Text(
                                    "Chattogram",
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF111827),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Plan",
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12.sp,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Row(
                                children: [
                                  const Icon(Icons.calendar_today_outlined, size: 16, color: Color(0xFF2E7D32)),
                                  SizedBox(width: 4.w),
                                  Text(
                                    "weekly",
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF111827),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),

                    // ডিউরেশন সেকশন
                    Text(
                      "Duration",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12.sp,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        const Icon(Icons.access_time_outlined, size: 16, color: Color(0xFF2E7D32)),
                        SizedBox(width: 6.w),
                        Text(
                          "Jul 20, 2026 – Jul 27, 2026",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF111827),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}