import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/features/post_add/controller/post_add_controller.dart';
import 'package:product_service/features/post_add/presentation/screen/post_add_step4_screen.dart';


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

                  // Package from API: GET /subscription-packages?packageType=post_add
                  Text(
                    "Subscription package",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "Choose a post_add package to continue.",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.sp,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  SizedBox(height: 12.h),

                  Obx(() {
                    if (controller.isLoadingPackages.value) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.h),
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    }

                    final packages = controller.postAddPackages;
                    if (packages.isEmpty) {
                      return Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: Colors.orange.shade200),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "No packages available",
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            TextButton(
                              onPressed: controller.fetchPostAddPackages,
                              child: const Text("Retry"),
                            ),
                          ],
                        ),
                      );
                    }

                    return Column(
                      children: List.generate(packages.length, (index) {
                        final pkg = packages[index];
                        final id = (pkg['_id'] ?? '').toString();
                        final name = (pkg['name'] ?? 'Package').toString();
                        final price = pkg['price'];
                        final duration =
                            (pkg['duration'] ?? '').toString();
                        final features = pkg['features'];
                        final featureText = features is List && features.isNotEmpty
                            ? features.first.toString()
                            : controller.packageDurationLabel(duration);

                        return Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: Obx(() {
                            final isSelected =
                                controller.selectedPackageId.value == id;
                            return GestureDetector(
                              onTap: () => controller.selectPackage(pkg),
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(14.w),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.green.shade50
                                      : Colors.white,
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
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            name,
                                            style: GoogleFonts.plusJakartaSans(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          SizedBox(height: 4.h),
                                          Text(
                                            featureText,
                                            style: GoogleFonts.plusJakartaSans(
                                              fontSize: 11.sp,
                                              color: Colors.grey.shade600,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 4.h),
                                          Text(
                                            controller
                                                .packageDurationLabel(duration),
                                            style: GoogleFonts.plusJakartaSans(
                                              fontSize: 11.sp,
                                              color: Colors.grey.shade500,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "\$${price ?? 0}",
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green.shade700,
                                          ),
                                        ),
                                        SizedBox(height: 8.h),
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
                                  ],
                                ),
                              ),
                            );
                          }),
                        );
                      }),
                    );
                  }),

                  SizedBox(height: 16.h),

                  // Schedule Card
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
                        Text(
                          "Start date",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 6.h),
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
                              String formattedDate =
                                  "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                              controller.startDate.value = formattedDate;
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 12.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(
                                  () => Text(
                                    controller.startDate.value.isEmpty
                                        ? "mm/dd/yyyy"
                                        : controller.startDate.value,
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 13.sp,
                                      color: controller.startDate.value.isEmpty
                                          ? Colors.grey.shade400
                                          : Colors.black87,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.calendar_today_outlined,
                                  size: 18.sp,
                                  color: Colors.grey.shade500,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),

                  Obx(() {
                    final start = controller.startDate.value;
                    final durationLabel = controller.packageDurationLabel(
                      controller.selectedDuration.value == 'weekly'
                          ? 'one_week'
                          : 'one_month',
                    );
                    final text = start.isEmpty
                        ? "Select a start date to see schedule"
                        : "Starts $start • $durationLabel";
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: Colors.green.shade200),
                      ),
                      child: Text(
                        text,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.green.shade800,
                        ),
                      ),
                    );
                  }),
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
                  if (controller.selectedPackageId.value.isEmpty) {
                    Get.rawSnackbar(
                      messageText: Text(
                        "Please select a subscription package",
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