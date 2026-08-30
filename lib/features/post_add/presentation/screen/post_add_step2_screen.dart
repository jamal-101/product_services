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
            // Step indicator header
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
            // Step progress indicator bars
            Row(
              children: [
                Expanded(child: Container(height: 4.h, decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(2.r)))),
                SizedBox(width: 6.w),
                Expanded(child: Container(height: 4.h, decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(2.r)))),
                SizedBox(width: 6.w),
                Expanded(child: Container(height: 4.h, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2.r)))),
                SizedBox(width: 6.w),
                Expanded(child: Container(height: 4.h, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2.r)))),
              ],
            ),
            SizedBox(height: 20.h),

            // Main Card Container for Choose Slot
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

                    // Slot List Builder
                    Expanded(
                      child: Obx(() {
                        if (controller.isLoadingSlots.value) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        // ডেমো স্লট ডাটা
                        final List<Map<String, dynamic>> slots = [
                          {"id": "Slot 1", "name": "Slot 1", "priceWk": "\$150/wk", "priceMo": "\$500/mo", "isAvailable": true},
                          {"id": "Slot 2", "name": "Slot 2", "priceWk": "\$140/wk", "priceMo": "\$465/mo", "isAvailable": true},
                          {"id": "Slot 3", "name": "Slot 3", "priceWk": "\$130/wk", "priceMo": "\$430/mo", "isAvailable": false},
                          {"id": "Slot 4", "name": "Slot 4", "priceWk": "\$120/wk", "priceMo": "\$400/mo", "isAvailable": true},
                          {"id": "Slot 5", "name": "Slot 5", "priceWk": "\$110/wk", "priceMo": "\$365/mo", "isAvailable": true},
                          {"id": "Slot 6", "name": "Slot 6", "priceWk": "\$100/wk", "priceMo": "\$330/mo", "isAvailable": false},
                          {"id": "Slot 7", "name": "Slot 7", "priceWk": "\$90/wk", "priceMo": "\$300/mo", "isAvailable": true},
                        ];

                        return ListView.separated(
                          itemCount: slots.length,
                          separatorBuilder: (context, index) => SizedBox(height: 10.h),
                          itemBuilder: (context, index) {
                            final slot = slots[index];
                            final slotId = slot["id"] as String;
                            final slotName = slot["name"] as String;
                            final priceWk = slot["priceWk"] as String;
                            final priceMo = slot["priceMo"] as String;
                            final isAvailable = slot["isAvailable"] as bool;

                            // এখানে সরাসরি Obx দিয়ে প্রতিটি আইটেমকে রিয়াক্টিভ করা হয়েছে,
                            // যাতে সিলেকশন চেঞ্জ হলে ইনস্ট্যান্ট UI আপডেট হয়।
                            return Obx(() {
                              bool isSelected = controller.selectedSlot.value == slotId;

                              return GestureDetector(
                                onTap: isAvailable
                                    ? () {
                                  controller.selectedSlot.value = slotId;
                                }
                                    : null,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12.r),
                                    border: Border.all(
                                      color: isSelected ? Colors.green.shade600 : Colors.grey.shade200,
                                      width: isSelected ? 1.5 : 1,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      // স্লট নম্বর ব্যাজ
                                      Container(
                                        width: 36.w,
                                        height: 36.h,
                                        decoration: BoxDecoration(
                                          color: isSelected ? Colors.green.shade600 : Colors.grey.shade100,
                                          borderRadius: BorderRadius.circular(8.r),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${index + 1}",
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                            color: isSelected ? Colors.white : Colors.black87,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 12.w),
                                      // স্লট নাম ও অ্যাভেইলেবিলিটি স্ট্যাটাস
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              slotName,
                                              style: GoogleFonts.plusJakartaSans(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            SizedBox(height: 2.h),
                                            Row(
                                              children: [
                                                if (isAvailable) ...[
                                                  Icon(Icons.check, size: 12.sp, color: Colors.green.shade600),
                                                  SizedBox(width: 4.w),
                                                  Text(
                                                    "Available",
                                                    style: GoogleFonts.plusJakartaSans(
                                                      fontSize: 11.sp,
                                                      color: Colors.green.shade600,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ] else ...[
                                                  Text(
                                                    "Booked",
                                                    style: GoogleFonts.plusJakartaSans(
                                                      fontSize: 11.sp,
                                                      color: Colors.grey.shade400,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      // প্রাইসিং ইনফো
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            priceWk,
                                            style: GoogleFonts.plusJakartaSans(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          SizedBox(height: 2.h),
                                          Text(
                                            priceMo,
                                            style: GoogleFonts.plusJakartaSans(
                                              fontSize: 10.sp,
                                              color: Colors.grey.shade400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 12.w),
                                      // কাস্টম রেডিও বাটন ইন্ডিকেটর
                                      Container(
                                        width: 20.w,
                                        height: 20.h,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: isSelected ? Colors.green.shade600 : Colors.grey.shade400,
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
                                            color: Colors.green.shade600,
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

            // Continue বাটন
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
                  if (controller.selectedSlot.value.isEmpty) {
                    Get.snackbar(
                      "Warning",
                      "Please select a slot",
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                    return;
                  }
                  Get.to(() => const PostAdStep3Screen());
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