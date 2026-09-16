import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/features/post_add/controller/post_add_controller.dart';
import 'package:product_service/features/post_add/presentation/screen/post_add_step3_screen.dart';

class PostAdStep2Screen extends StatelessWidget {
  const PostAdStep2Screen({super.key});

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Step 2 of 4 • Placement",
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.grey.shade600,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "Choose Slot",
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.green.shade700,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
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
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                SizedBox(width: 6.w),
                Expanded(
                  child: Container(
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Choose slot",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "Higher positions cost more per week or month.",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12.sp,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Expanded(
                      child: Obx(() {
                        if (controller.isLoadingSlots.value) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        final slots = controller.availableSlots;
                        if (slots.isEmpty) {
                          return Center(
                            child: Text(
                              "No slots available for this city",
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 13.sp,
                                color: Colors.grey.shade600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          );
                        }

                        return ListView.separated(
                          itemCount: slots.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 10.h),
                          itemBuilder: (context, index) {
                            final slot = slots[index];
                            final packagePrice = controller.packagePrice.value;
                            final priceValue =
                                slot.monthlyPrice ?? slot.weeklyPrice;
                            final priceLabel = priceValue != null
                                ? "\$${priceValue.toStringAsFixed(0)}"
                                : (packagePrice > 0
                                    ? "\$${packagePrice.toStringAsFixed(0)}"
                                    : "");

                            return Obx(() {
                              final isSelected =
                                  controller.selectedPosition.value ==
                                      slot.position;

                              return GestureDetector(
                                onTap: slot.isAvailable
                                    ? () => controller.selectSlot(slot)
                                    : null,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.w,
                                    vertical: 12.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12.r),
                                    border: Border.all(
                                      color: isSelected
                                          ? Colors.green.shade600
                                          : Colors.grey.shade200,
                                      width: isSelected ? 1.5 : 1,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 36.w,
                                        height: 36.h,
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? Colors.green.shade600
                                              : Colors.grey.shade100,
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${slot.position}",
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                            color: isSelected
                                                ? Colors.white
                                                : Colors.black87,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 12.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              slot.displayName,
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            SizedBox(height: 2.h),
                                            Row(
                                              children: [
                                                if (slot.isAvailable) ...[
                                                  Icon(
                                                    Icons.check,
                                                    size: 12.sp,
                                                    color:
                                                        Colors.green.shade600,
                                                  ),
                                                  SizedBox(width: 4.w),
                                                  Text(
                                                    "Available",
                                                    style: GoogleFonts
                                                        .plusJakartaSans(
                                                      fontSize: 11.sp,
                                                      color: Colors
                                                          .green.shade600,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ] else ...[
                                                  Text(
                                                    "Booked",
                                                    style: GoogleFonts
                                                        .plusJakartaSans(
                                                      fontSize: 11.sp,
                                                      color: Colors
                                                          .grey.shade400,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (priceLabel.isNotEmpty)
                                        Text(
                                          priceLabel,
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      SizedBox(width: 12.w),
                                      Container(
                                        width: 20.w,
                                        height: 20.h,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: isSelected
                                                ? Colors.green.shade600
                                                : Colors.grey.shade400,
                                            width: 2,
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                        child: isSelected
                                            ? Container(
                                                width: 10.w,
                                                height: 10.h,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color:
                                                      Colors.green.shade600,
                                                ),
                                              )
                                            : null,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),
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
                  if (controller.selectedPosition.value <= 0) {
                    Get.snackbar(
                      "Warning",
                      "Please select a slot",
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                    return;
                  }
                  Get.to(() => const PostAdStep3Screen());
                  controller.fetchPostAddPackages();
                },
                child: Text(
                  "Continue →",
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
