import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/features/post_add/controller/post_add_controller.dart';
import 'package:product_service/features/post_add/presentation/screen/post_add_step4_screen.dart';
// আপনার প্রজেক্ট অনুযায়ী Step 4 স্ক্রিনের সঠিক পাথ এখানে import করে নিন
// import 'post_ad_step4_screen.dart';

class PostAdStep3Screen extends StatelessWidget {
  const PostAdStep3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final PostAddController controller = Get.find<PostAddController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Post New Ad",
          style: GoogleFonts.plusJakartaSans(
            color: Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            // Step indicator header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Step 3 of 4 • Creative & Schedule",
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.grey.shade600,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "Ad Details",
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.green.shade700,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            // Step progress indicator bars (৩টি পূর্ণ, ১টি খালি)
            Row(
              children: [
                Expanded(child: Container(height: 4.h, decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(2.r)))),
                SizedBox(width: 6.w),
                Expanded(child: Container(height: 4.h, decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(2.r)))),
                SizedBox(width: 6.w),
                Expanded(child: Container(height: 4.h, decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(2.r)))),
                SizedBox(width: 6.w),
                Expanded(child: Container(height: 4.h, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2.r)))),
              ],
            ),
            SizedBox(height: 16.h),

            Expanded(
              child: ListView(
                children: [
                  // Ad Creative Title
                  Text(
                    "Ad Creative",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "Upload the banner that will run.",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.sp,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // Banner Upload Box
                  GestureDetector(
                    onTap: () => controller.pickFeaturedImage(),
                    child: Obx(() => Container(
                      height: 140.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.green.shade50.withOpacity(0.4),
                        border: Border.all(
                          color: Colors.green.shade400,
                          style: BorderStyle.solid,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: controller.featuredImage.value == null
                          ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10.w),
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.cloud_upload_outlined, color: Colors.green.shade700, size: 24.sp),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "Tap to Upload",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            "1080 × 400, JPG/PNG",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11.sp,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      )
                          : ClipRRect(
                        borderRadius: BorderRadius.circular(15.r),
                        child: Image.file(
                          controller.featuredImage.value!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )),
                  ),
                  SizedBox(height: 16.h),

                  // Duration Section Title
                  Text(
                    "Duration",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "Price depends on your slot and duration.",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.sp,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // Duration & Schedule Card Container
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: Colors.grey.shade200),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Weekly & Monthly Selection Cards
                        Row(
                          children: [
                            // Weekly Option
                            Expanded(
                              child: Obx(() {
                                bool isWeekly = controller.selectedDuration.value == "weekly";
                                return GestureDetector(
                                  onTap: () => controller.selectedDuration.value = "weekly",
                                  child: Container(
                                    padding: EdgeInsets.all(12.w),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12.r),
                                      border: Border.all(
                                        color: isWeekly ? Colors.green.shade600 : Colors.grey.shade200,
                                        width: isWeekly ? 1.5 : 1,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Weekly",
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        SizedBox(height: 2.h),
                                        Text(
                                          "7 days",
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 11.sp,
                                            color: Colors.grey.shade500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),
                            SizedBox(width: 12.w),
                            // Monthly Option with "Best Value" Badge
                            Expanded(
                              child: Obx(() {
                                bool isMonthly = controller.selectedDuration.value == "monthly";
                                return GestureDetector(
                                  onTap: () => controller.selectedDuration.value = "monthly",
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(12.w),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(12.r),
                                          border: Border.all(
                                            color: isMonthly ? Colors.green.shade600 : Colors.grey.shade200,
                                            width: isMonthly ? 1.5 : 1,
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Monthly",
                                              style: GoogleFonts.plusJakartaSans(
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            SizedBox(height: 2.h),
                                            Text(
                                              "30 days",
                                              style: GoogleFonts.plusJakartaSans(
                                                fontSize: 11.sp,
                                                color: Colors.grey.shade500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Best Value Badge
                                      Positioned(
                                        top: -8.h,
                                        right: 12.w,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                                          decoration: BoxDecoration(
                                            color: Colors.deepOrange,
                                            borderRadius: BorderRadius.circular(6.r),
                                          ),
                                          child: Text(
                                            "Best Value",
                                            style: GoogleFonts.plusJakartaSans(
                                              fontSize: 9.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),

                        // Start Date Field Label
                        Text(
                          "Start date",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 6.h),

                        // Date Input Field Box with Calendar Picker
                        GestureDetector(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2030),
                              builder: (context, child) {
                                return Theme(
                                  data: ThemeData.light().copyWith(
                                    colorScheme: ColorScheme.light(
                                      primary: Colors.green.shade700,
                                      onPrimary: Colors.white,
                                      surface: Colors.white,
                                      onSurface: Colors.black,
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );

                            if (pickedDate != null) {
                              String formattedDate = "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                              controller.startDate.value = formattedDate;
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(() => Text(
                                  controller.startDate.value.isEmpty ? "mm/dd/yyyy" : controller.startDate.value,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 13.sp,
                                    color: controller.startDate.value.isEmpty ? Colors.grey.shade400 : Colors.black87,
                                  ),
                                )),
                                Icon(Icons.calendar_today_outlined, size: 18.sp, color: Colors.grey.shade500),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // Runs Info Bottom Banner (Green Ribbon)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.green.shade200),
                    ),
                    child: Text(
                      "Runs Aug 19 → Sep 18, 2026",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.green.shade800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),

            // Review Order Button
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                onPressed: () {
                  if (controller.featuredImage.value == null) {
                    Get.rawSnackbar(
                      messageText: Text(
                        "Please upload an ad banner image",
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
                      duration: const Duration(seconds: 2),
                      icon: const Icon(Icons.error_outline, color: Colors.white),
                    );
                    return;
                  }
                  if (controller.startDate.value.isEmpty) {
                    Get.rawSnackbar(
                      messageText: Text(
                        "Please select a start date",
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
                      duration: const Duration(seconds: 2),
                      icon: const Icon(Icons.error_outline, color: Colors.white),
                    );
                    return;
                  }
                  Get.to(() => const PostAdStep4Screen());
                },
                child: Text(
                  "Review order →",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}