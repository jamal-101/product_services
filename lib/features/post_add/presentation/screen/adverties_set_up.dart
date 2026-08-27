import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/post_add_controller.dart';

class AdvertiseStepTwoView extends StatelessWidget {
  const AdvertiseStepTwoView({super.key});

  @override
  Widget build(BuildContext context) {
    final PostAddController controller = Get.find<PostAddController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => controller.selectPlan(1),
                child: Obx(() {
                  bool isSelected = controller.selectedPlanIndex.value == 1;
                  return Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFFF0FDF4)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF2E7D32)
                            : const Color(0xFFECECF0),
                        width: isSelected ? 1.5 : 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Weekly",
                              style: GoogleFonts.plusJakartaSans(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFF2E7D32)
                                    : Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                isSelected
                                    ? Icons.check
                                    : Icons.radio_button_unchecked,
                                color: isSelected ? Colors.white : Colors.grey,
                                size: isSelected ? 20.sp : 22.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "7 days",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12.sp,
                            color: Colors.grey[900],
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          "\$120",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF2E7D32),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    GestureDetector(
                      onTap: () => controller.selectPlan(2),
                      child: Obx(() {
                        bool isSelected =
                            controller.selectedPlanIndex.value == 2;
                        return Container(
                          padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 16.w),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFFF0FDF4)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF2E7D32)
                                  : const Color(0xFFECECF0),
                              width: isSelected ? 1.5 : 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Monthly",
                                    style: GoogleFonts.plusJakartaSans(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  Container(
                                    width: 24.w,
                                    height: 24.h,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? const Color(0xFF2E7D32)
                                          : Colors.transparent,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      isSelected
                                          ? Icons.check
                                          : Icons.radio_button_unchecked,
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.grey,
                                      size: isSelected ? 16.sp : 20.sp,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                "30 days",
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12.sp,
                                  color: Colors.grey[900],
                                ),
                              ),
                              SizedBox(height: 12.h),
                              Text(
                                "\$400",
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF2E7D32),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                    Positioned(
                      top: -14.h,
                      left: 18.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFFF26522),
                          borderRadius: BorderRadius.circular(999.r),
                        ),
                        child: Text(
                          "Best Value",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),
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
              Text(
                "Start Date",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12.h),
              GestureDetector(
                onTap: () => controller.chooseStartDate(context),
                child: AbsorbPointer(
                  child: Obx(
                    () => TextFormField(
                      controller: TextEditingController(
                        text: controller.startDate.value,
                      ),
                      decoration: InputDecoration(
                        hintText: "mm/dd/yyyy",
                        hintStyle: GoogleFonts.plusJakartaSans(
                          fontSize: 14.sp,
                          color: Colors.grey[400],
                        ),
                        fillColor: const Color(0xFFF5F5F7),
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: const Icon(
                          Icons.calendar_today_outlined,
                          size: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "End date calculates automatically.",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14.sp,
                  color: Color(0xFF6B7280),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Obx(() {
          if (controller.startDate.value.isEmpty) {
            return const SizedBox.shrink();
          }
          return Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF0FDF4),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: const Color(0xFFD1E7DD)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Duration",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13.sp,
                        color: Colors.grey[700],
                      ),
                    ),
                    Text(
                      controller.selectedPlanIndex.value == 1
                          ? "7 Days"
                          : "30 Days",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "End Date",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13.sp,
                        color: Colors.grey[700],
                      ),
                    ),
                    Text(
                      controller.endDate.value,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: const Divider(height: 1, color: Color(0xFFD1E7DD)),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Color(0xFF2E7D32),
                      size: 16,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      "Available",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2E7D32),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
