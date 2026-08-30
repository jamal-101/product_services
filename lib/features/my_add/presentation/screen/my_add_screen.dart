import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/utils/constants/api_enpoint.dart';
import 'package:product_service/utils/constants/app_color.dart';
import 'package:product_service/utils/constants/app_images.dart';
import '../../../auth_flow/presentation/controller/auth_controller.dart';
import '../controller/my_add_controller.dart';
import 'add_details_screen.dart';


class MyAddScreen extends StatelessWidget {
  const MyAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MyAddController controller = Get.put(MyAddController());

    return Scaffold(

      appBar: AppBar(
        backgroundColor: AppColor.appBackgroundColor,
        surfaceTintColor: AppColor.appBackgroundColor,
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
              onPressed: () async {
                if (Get.isRegistered<AuthController>()) {
                  final AuthController authController = Get.find<AuthController>();
                  await authController.selectRole('seller');
                } else {
                  final AuthController authController = Get.put(AuthController());
                  await authController.selectRole('seller');
                }
              },
            ),
          ),
        ),
        title: Text(
          "My Ads",
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF2E7D32)),
            );
          }
          if (controller.myAds.isEmpty) {
            return Center(
              child: Text(
                "No advertisements found",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16.sp,
                  color: Colors.grey.shade600,
                ),
              ),
            );
          }
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.all(16.w),
            itemCount: controller.myAds.length,
            itemBuilder: (context, index) {
              final ad = controller.myAds[index];
              bool isLive = ad.status?.toLowerCase() == 'live' || ad.status?.toLowerCase() == 'active';
              Color statusColor = isLive ? const Color(0xFF2E7D32) : Colors.orange.shade800;
              Color bgColor = isLive ? const Color(0xFFE8F5E9) : Colors.orange.shade50;
              String start = ad.startDate?.split('T').first ?? "N/A";
              String end = ad.endDate?.split('T').first ?? "N/A";
              String formattedDate = "$start - $end";
              String imgUrl = ad.featuredImage != null
                  ? "${ApiEndPoint.imageUrl}${ad.featuredImage}"
                  : "";
              return Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: _buildAdCard(
                  status: ad.status ?? "Pending",
                  statusColor: statusColor,
                  bgColor: bgColor,
                  title: ad.campaignName ?? "Unknown Campaign",
                  date: formattedDate,
                  price: "N/A",
                  imageUrl: imgUrl,
                  onTap: () => Get.to(() => const AddDetailsScreen()),
                ),
              );
            },
          );
        }),
      ),
    );
  }

  Widget _buildAdCard({
    required String status,
    required Color statusColor,
    required Color bgColor,
    required String title,
    required String date,
    required String price,
    required String imageUrl,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: const Color(0xFFECECF0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                  child: imageUrl.isNotEmpty
                      ? Image.network(
                    imageUrl,
                    height: 130.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return _fallbackImage();
                    },
                  )
                      : _fallbackImage(),
                ),
                // Positioned(
                //   top: 12.h,
                //   left: 12.w,
                //   child: Container(
                //     padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                //     decoration: BoxDecoration(
                //       color: bgColor,
                //       borderRadius: BorderRadius.circular(6.r),
                //     ),
                //     child: Text(
                //       status.toUpperCase(), // "LIVE" বা "PENDING"
                //       style: GoogleFonts.plusJakartaSans(
                //         fontSize: 11.sp,
                //         fontWeight: FontWeight.bold,
                //         color: statusColor,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(14.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF111827),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        date,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  // Text(
                  //   price,
                  //   style: GoogleFonts.plusJakartaSans(
                  //     fontSize: 18.sp,
                  //     fontWeight: FontWeight.bold,
                  //     color: const Color(0xFF2E7D32),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _fallbackImage() {
    return Image.asset(
      AppImages.servicesImage,
      height: 130.h,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }
}