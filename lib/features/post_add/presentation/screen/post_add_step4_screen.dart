import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/features/post_add/controller/post_add_controller.dart';
import 'package:product_service/utils/constants/app_string.dart';

class PostAdStep4Screen extends StatelessWidget {
  const PostAdStep4Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final PostAddController controller = Get.find<PostAddController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          AppString.postNewAd.tr,
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
                  AppString.step4Of4.tr,
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.grey.shade600,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  AppString.reviewAndPay.tr,
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.green.shade700,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            // Progress Indicator
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                SizedBox(width: 6.w),
                Expanded(
                  child: Container(
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                SizedBox(width: 6.w),
                Expanded(
                  child: Container(
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                SizedBox(width: 6.w),
                Expanded(
                  child: Container(
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            Expanded(
              child: ListView(
                children: [
                  // Title
                  Text(
                    AppString.reviewAndPay.tr,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    AppString.doubleCheckDesc.tr,
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
                          return Center(
                            child: Text(
                              AppString.adBannerPreview.tr,
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
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildInfoRow(
                          AppString.campaign.tr,
                          controller.campaignNameController.text,
                        ),
                        Divider(height: 20.h, color: Colors.grey.shade100),
                        _buildInfoRow(
                          AppString.package.tr,
                          controller.packageName.value.isNotEmpty
                              ? "${controller.packageName.value} (\$${controller.packagePrice.value.toStringAsFixed(0)})"
                              : "N/A",
                        ),
                        Divider(height: 20.h, color: Colors.grey.shade100),
                        _buildInfoRow(
                          AppString.city.tr,
                          controller.selectedCityName.value.isNotEmpty
                              ? controller.selectedCityName.value
                              : controller.selectedCityId.value,
                        ),
                        Divider(height: 20.h, color: Colors.grey.shade100),
                        _buildInfoRow(
                          AppString.slot.tr,
                          controller.selectedSlot.value.isNotEmpty
                              ? controller.selectedSlot.value
                              : "${AppString.positionPrefix.tr} ${controller.selectedPosition.value}",
                        ),
                        Divider(height: 20.h, color: Colors.grey.shade100),
                        _buildInfoRow(
                          AppString.duration.tr,
                          (controller.selectedDuration.value == 'seven_days' || controller.selectedDuration.value == 'weekly')
                              ? AppString.weekly7Days.tr
                              : AppString.monthly30Days.tr,
                        ),
                        Divider(height: 20.h, color: Colors.grey.shade100),
                        _buildInfoRow(
                          AppString.dates.tr,
                          controller.startDate.value.isEmpty
                              ? "N/A"
                              : controller.startDate.value,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Obx(() {
                    final total = controller.slotPrice.value > 0
                        ? controller.slotPrice.value
                        : controller.packagePrice.value;
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 14.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: Colors.green.shade200),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppString.total.tr,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            "\$${total.toStringAsFixed(2)}",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade700,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  SizedBox(height: 10.h),
                ],
              ),
            ),

            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: Obx(() {
                final busy =
                    controller.isCreatingCheckout.value ||
                        controller.isVerifyingPayment.value ||
                        controller.isSubmitting.value;
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade700,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: busy
                      ? null
                      : () {
                    controller.startDatafastPayment();
                  },
                  child: busy
                      ? SizedBox(
                    height: 20.h,
                    width: 20.h,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                      : Text(
                    AppString.submitAndPay.tr,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 15.h),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13.sp,
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            value.isEmpty ? "N/A" : value,
            textAlign: TextAlign.end,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13.sp,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}