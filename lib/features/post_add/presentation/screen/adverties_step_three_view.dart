import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/post_add_controller.dart';

class AdvertiseStepThreeView extends StatelessWidget {
  const AdvertiseStepThreeView({super.key});

  @override
  Widget build(BuildContext context) {
    final PostAddController controller = Get.find<PostAddController>();

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  offset: const Offset(0, 1),
                  blurRadius: 2,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.aspect_ratio, size: 16.sp, color: Colors.grey),
                    SizedBox(width: 6.w),
                    Text(
                      "1080 × 400",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.insert_drive_file_outlined,
                      size: 16.sp,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      "JPG/PNG",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.upload_file, size: 16.sp, color: Colors.grey),
                    SizedBox(width: 4.w),
                    Text(
                      "Max 2MB",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          GestureDetector(
            onTap: () {
              if (controller.uploadedBannerPath.value.isEmpty) {
                controller.pickBannerImage();
              }
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: const Color(0xFF2E7D32),
                  style: BorderStyle.solid,
                  width: 1,
                ),
              ),
              child: Obx(() {
                if (controller.uploadedBannerPath.value.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(12.r),
                        decoration: const BoxDecoration(
                          color: Color(0xFFE8F5E9),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.cloud_upload_outlined,
                          color: const Color(0xFF2E7D32),
                          size: 28.sp,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        "Tap to Upload",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "Browse from your device",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: const Color(0xFFECECF0)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.r),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE0F2FE),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(
                            Icons.image,
                            color: Colors.blue,
                            size: 20.sp,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.uploadedBannerPath.value,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                "41 KB",
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 10.sp,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.removeBannerImage();
                          },
                          child: Container(
                            padding: EdgeInsets.all(4.r),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.close,
                              color: Colors.grey.shade700,
                              size: 18.sp,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        const Icon(
                          Icons.check_circle,
                          color: Color(0xFF2E7D32),
                          size: 20,
                        ),
                      ],
                    ),
                  );
                }
              }),
            ),
          ),
          SizedBox(height: 24.h),
          Obx(() {
            if (controller.uploadedBannerPath.value.isEmpty) {
              return const SizedBox.shrink();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Live Preview",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12.h),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: Color(0xFFECECF0), width: 1.w),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        offset: const Offset(0, 1),
                        blurRadius: 2,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 14.sp,
                          left: 12.sp,
                          right: 12.sp,
                          bottom: 3.sp,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "IN-APP",
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 11.sp,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Featured Top Slider 1",
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12.sp,
                                color: const Color(0xFF2E7D32),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Container(
                        height: 152.h,
                        width: 380.w,
                        decoration: BoxDecoration(
                          color: Color(0xFFF3F4F6),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.zero,
                            topRight: Radius.zero,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.r),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child:
                                controller.uploadedBannerPath.value.isNotEmpty
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
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
