import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/store_setup_controller.dart';


class OperatingHoursScreen extends StatelessWidget {
  const OperatingHoursScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final StoreUpdateController controller = Get.put(StoreUpdateController());
    final List<String> days = ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
            'operatingHours'.tr,
          style: GoogleFonts.montserrat(color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(15.w),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(15.r),
                color: Colors.grey.shade50,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('operatingSchedule'.tr, style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 14.sp)),
                            Text('setOpeningHours'.tr, style: GoogleFonts.montserrat(color: Colors.grey, fontSize: 11.sp)),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                        decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(20.r)),
                        child: Row(
                          children: [
                            const Icon(Icons.access_time, size: 14, color: Colors.green),
                            SizedBox(width: 5.w),
                            Text('open247'.tr, style: GoogleFonts.montserrat(fontSize: 11.sp, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),

                  // Working Days Selection Tags
                  Text('workingDays'.tr, style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 12.sp)),
                  SizedBox(height: 10.h),
                  Wrap(
                    spacing: 8.w,
                    children: days.map((day) {
                      return Obx(() {
                        bool isSelected = controller.workingDays.contains(day);
                        return ChoiceChip(
                          label: Text(day[0].toUpperCase() + day.substring(1, 3)),
                          selected: isSelected,
                          selectedColor: const Color(0xFF27AE60),
                          labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black, fontWeight: FontWeight.bold),
                          onSelected: (_) => controller.toggleWorkingDay(day),
                        );
                      });
                    }).toList(),
                  ),
                  SizedBox(height: 20.h),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('openingTime'.tr, style: GoogleFonts.montserrat(fontSize: 12.sp, fontWeight: FontWeight.bold)),
                            SizedBox(height: 5.h),
                            TextField(
                              controller: controller.openingTimeController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide(color: Colors.grey.shade300)),
                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide(color: Colors.grey.shade300)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('closingTime'.tr, style: GoogleFonts.montserrat(fontSize: 12.sp, fontWeight: FontWeight.bold)),
                            SizedBox(height: 5.h),
                            TextField(
                              controller: controller.closingTimeController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide(color: Colors.grey.shade300)),
                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide(color: Colors.grey.shade300)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),

            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF27AE60),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
                onPressed: () => controller.updateStore(),
                child: Text('saveChanges'.tr, style: GoogleFonts.montserrat(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.sp)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}