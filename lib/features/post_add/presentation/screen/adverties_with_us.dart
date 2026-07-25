import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/features/post_add/presentation/screen/adverties_set_up.dart';
import 'package:product_service/utils/constants/app_color.dart';
import '../../controller/post_add_controller.dart';
import '../widget/city_drop_down.dart';
import 'adverties_step_three_view.dart';

class AdvertiseWithUs extends StatelessWidget {
  const AdvertiseWithUs({super.key});

  @override
  Widget build(BuildContext context) {
    final PostAddController controller = Get.put(PostAddController());

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        surfaceTintColor: AppColor.appBackgroundColor,
        automaticallyImplyLeading: false,
        centerTitle: false,
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
              onPressed: () {
                if (controller.currentStep.value > 1) {
                  controller.currentStep.value -= 1;
                } else {
                  Navigator.pop(context);
                }
              },
            ),
          ),
        ),
        // স্টেপ অনুযায়ী অ্যাপবারের টাইটেল পরিবর্তন হবে
        title: Obx(() {
          String title = "Advertise With Us";
          if (controller.currentStep.value == 2) {
            title = "Plan & Schedule";
          } else if (controller.currentStep.value == 3) {
            title = "Upload Banner";
          }
          return Text(
            title,
            style: GoogleFonts.montserrat(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          );
        }),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(16.w),
          child: Obx(() {
            // ১. স্টেপ ১ এর UI
            if (controller.currentStep.value == 1) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Step 1 of 4 • City & Placement",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.sp,
                      color: Colors.grey[900],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  LinearProgressIndicator(
                    value: 0.25,
                    backgroundColor: const Color(0xFFECECF0),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF2E7D32),
                    ),
                    minHeight: 4.h,
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
                          "Campaign Name",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "Give your campaign a memorable name.",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12.sp,
                            color: Colors.grey[900],
                          ),
                        ),
                        SizedBox(height: 12.h),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: "e.g. Summer Sale 2025",
                            hintStyle: GoogleFonts.plusJakartaSans(
                              fontSize: 12.sp,
                              color: Colors.grey[900],
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
                          ),
                        ),
                      ],
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
                        Text(
                          "Choose City",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "Choose a city, banner type, then an available slot.",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12.sp,
                            color: Colors.grey[900],
                          ),
                        ),
                        SizedBox(height: 12.h),
                        CityDropDown(),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Banner Type",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.selectBannerType(1),
                          child: Obx(() {
                            bool isSelected =
                                controller.selectedBannerType.value == 1;
                            return Container(
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFFF0FDF4)
                                    : const Color(0xFFFFFFFF),
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
                                      const Icon(Icons.star, color: Colors.orange),
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
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.grey,
                                          size: isSelected ? 20.sp : 22.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 12.h),
                                  Text(
                                    "Premium",
                                    style: GoogleFonts.plusJakartaSans(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    "Top slider • Higher visibility",
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 11.sp,
                                      color: Colors.grey[900],
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    "4 slots",
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12.sp,
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold,
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
                        child: GestureDetector(
                          onTap: () => controller.selectBannerType(2),
                          child: Obx(() {
                            bool isSelected =
                                controller.selectedBannerType.value == 2;
                            return Container(
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFFF0FDF4)
                                    : const Color(0xFFFFFFFF),
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
                                      Container(
                                        height: 22.h,
                                        width: 22.h,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF6B7280),
                                          borderRadius:
                                          BorderRadius.circular(4.r),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Ad",
                                            style: GoogleFonts.poppins(
                                              fontSize: 12.sp,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
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
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.grey,
                                          size: isSelected ? 20.sp : 22.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 12.h),
                                  Text(
                                    "Standard",
                                    style: GoogleFonts.plusJakartaSans(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    "Mid-feed • Budget friendly",
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 11.sp,
                                      color: Colors.grey[900],
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    "20 slots",
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12.sp,
                                      color: const Color(0xFF2E7D32),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Obx(() {
                    if (controller.selectedBannerType.value == 0) {
                      return const SizedBox.shrink();
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Choose Slot",
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return Obx(() {
                              bool isSelected =
                                  controller.selectedSlotIndex.value == index;
                              return GestureDetector(
                                onTap: () => controller.selectSlot(index),
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 12.h),
                                  padding: EdgeInsets.all(16.w),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? const Color(0xFFF0FDF4)
                                        : const Color(0xFFFFFFFF),
                                    borderRadius: BorderRadius.circular(16.r),
                                    border: Border.all(
                                      color: isSelected
                                          ? const Color(0xFF2E7D32)
                                          : const Color(0xFFECECF0),
                                      width: isSelected ? 1.5 : 1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Featured Top Slider ${index + 1}",
                                              style: GoogleFonts.plusJakartaSans(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 4.h),
                                            Text(
                                              "Top of Discover • Slider position ${index + 1}",
                                              style: GoogleFonts.plusJakartaSans(
                                                fontSize: 12.sp,
                                                color: Colors.grey[900],
                                              ),
                                            ),
                                          ],
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
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.grey[400],
                                          size: isSelected ? 20.sp : 22.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                          },
                        ),
                      ],
                    );
                  }),
                ],
              );
            }
            else if (controller.currentStep.value == 2) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Step 2 of 4 • Duration & dates",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.sp,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                            height: 4.h, color: const Color(0xFF2E7D32)),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Container(
                            height: 4.h, color: const Color(0xFF2E7D32)),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Container(
                            height: 4.h, color: const Color(0xFFECECF0)),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Container(
                            height: 4.h, color: const Color(0xFFECECF0)),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: const Color(0xFFECECF0)),
                    ),
                    child: Text(
                      "Featured Top Slider 1 • Premium • Chattogram",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Select Plan",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  const AdvertiseStepTwoView(),
                ],
              );
            }
            else {
              return const AdvertiseStepThreeView();
            }
          }),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.w),
        color: Colors.white,
        child: Obx(() {
          bool isEnabled = true;
          if (controller.currentStep.value == 1) {
            isEnabled = controller.selectedSlotIndex.value >= 0;
          } else if (controller.currentStep.value == 2) {
            isEnabled = controller.selectedPlanIndex.value >= 0;
          } else {
            isEnabled = controller.uploadedBannerPath.value.isNotEmpty;
          }

          return ElevatedButton(
            onPressed: isEnabled
                ? () {
              if (controller.currentStep.value == 1) {
                controller.currentStep.value = 2;
              } else if (controller.currentStep.value == 2) {
                controller.currentStep.value = 3;
              } else {

              }
            }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF228B22),
              disabledBackgroundColor: Colors.grey.shade300,
              foregroundColor: Colors.white,
              disabledForegroundColor: Colors.grey.shade600,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  controller.currentStep.value == 1
                      ? "Continue"
                      : controller.currentStep.value == 2
                      ? "Continue"
                      : "Review & Pay",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(width: 8.w),
                const Icon(Icons.arrow_forward, size: 18),
              ],
            ),
          );
        }),
      ),
    );
  }
}