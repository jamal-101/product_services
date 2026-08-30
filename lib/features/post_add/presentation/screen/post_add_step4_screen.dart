import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/features/post_add/controller/post_add_controller.dart';

class PostAdStep4Screen extends StatelessWidget {
  const PostAdStep4Screen({super.key});

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
                  "Step 4 of 4 • Summary & pay",
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.grey.shade600,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "Review & Pay",
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.green.shade700,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            // Step progress indicator bars (সবগুলো ৪টি বার পূর্ণ সবুজ)
            Row(
              children: [
                Expanded(child: Container(height: 4.h, decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(2.r)))),
                SizedBox(width: 6.w),
                Expanded(child: Container(height: 4.h, decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(2.r)))),
                SizedBox(width: 6.w),
                Expanded(child: Container(height: 4.h, decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(2.r)))),
                SizedBox(width: 6.w),
                Expanded(child: Container(height: 4.h, decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(2.r)))),
              ],
            ),
            SizedBox(height: 16.h),

            Expanded(
              child: ListView(
                children: [
                  // Title
                  Text(
                    "Review & Pay",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "Double-check everything before submitting.",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.sp,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // Uploaded Banner Preview Card
                  Container(
                    height: 110.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: Colors.grey.shade900,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: Obx(() {
                        if (controller.featuredImage.value != null) {
                          return Image.file(
                            controller.featuredImage.value!,
                            fit: BoxFit.cover,
                          );
                        } else {
                          // ডিফল্ট ব্যানার বা প্লেসহোল্ডার যদি ইমেজ না থাকে
                          return Center(
                            child: Text(
                              "Ad Banner Preview",
                              style: GoogleFonts.plusJakartaSans(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }
                      }),
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // Details Info Card
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
                      children: [
                        _buildInfoRow("Campaign", controller.campaignNameController.text),
                        Divider(height: 20.h, color: Colors.grey.shade100),
                        _buildInfoRow("City ID", controller.selectedCityId.value), // চাইলে সিটি নামও দেখাতে পারেন
                        Divider(height: 20.h, color: Colors.grey.shade100),
                        _buildInfoRow("Slot", controller.selectedSlot.value),
                        Divider(height: 20.h, color: Colors.grey.shade100),
                        _buildInfoRow("Duration", "${controller.selectedDuration.value.capitalizeFirst} • ${controller.selectedDuration.value == 'weekly' ? '7 days' : '30 days'}"),
                        Divider(height: 20.h, color: Colors.grey.shade100),
                        _buildInfoRow("Dates", controller.startDate.value.isEmpty ? "Aug 19, 2026 → Sep 18, 2026" : controller.startDate.value),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // Total Amount Box (Ad fee ও Tax বাদ দিয়ে শুধু Total দেখানো হয়েছে)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: Colors.green.shade200),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          "\$105.00", // আপনার টোটাল অ্যামাউন্ট ভ্যারিয়েবল এখানে বসাতে পারেন
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),

            // Submit & Pay Button
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: Obx(() => ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                onPressed: controller.isSubmitting.value
                    ? null
                    : () {
                  controller.submitAdvertisement();
                },
                child: controller.isSubmitting.value
                    ? SizedBox(
                  height: 20.h,
                  width: 20.h,
                  child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                )
                    : Text(
                  "Submit & Pay",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )),
            ),
            SizedBox(height: 15.h),
          ],
        ),
      ),
    );
  }

  // Helper Widget for Info Rows inside Card
  Widget _buildInfoRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13.sp,
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value.isEmpty ? "N/A" : value,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13.sp,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}