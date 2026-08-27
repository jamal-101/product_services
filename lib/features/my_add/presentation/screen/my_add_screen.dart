import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/utils/constants/app_images.dart';
import '../../controller/my_add_controller.dart';
import 'add_details_screen.dart';

class MyAddScreen extends StatelessWidget {
  const MyAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MyAddController controller = Get.put(MyAddController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
              onPressed: () => Get.back(),
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
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                _buildTabButton(controller, "All", 0),
                SizedBox(width: 24.w),
                _buildTabButton(controller, "Pending", 1),
                SizedBox(width: 24.w),
                _buildTabButton(controller, "Live", 2),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(16.w),
          children: [

            _buildAdCard(
              status: "LIVE",
              statusColor: const Color(0xFF2E7D32),
              bgColor: const Color(0xFFE8F5E9),
              title: "Gree",
              date: "Jul 1 - Jul 31",
              price: "\$420",
              imagePath: AppImages.storeCoverImage,
              onTap: () => Get.to(() => AddDetailsScreen()),
            ),
            SizedBox(height: 16.h),
            _buildAdCard(
              status: "Pending",
              statusColor: Colors.orange.shade800,
              bgColor: Colors.orange.shade50,
              title: "Gree",
              date: "Jul 20 - Jul 27",
              price: "\$37",
              isBannerCustom: true,
              imagePath: AppImages.servicesImage,
              onTap: () => Get.to(() => AddDetailsScreen()),
            ),
            SizedBox(height: 16.h),
            _buildAdCard(
              status: "Pending",
              statusColor: Colors.orange.shade800,
              bgColor: Colors.orange.shade50,
              title: "Gree",
              date: "Aug 1 - Aug 8",
              price: "\$147",
              imagePath: AppImages.servicesImage,
              isKettle: true,
              onTap: () => Get.to(() => const AddDetailsScreen()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(MyAddController controller, String title, int index) {
    return Obx(() {
      bool isSelected = controller.selectedTab.value == index;
      return GestureDetector(
        onTap: () => controller.changeTab(index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14.sp,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? const Color(0xFF2E7D32) : Colors.grey.shade600,
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              height: 3.h,
              width: 35.w,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF2E7D32) : Colors.transparent,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildAdCard({
    bool isBannerCustom = false,
    bool isKettle = false,
    required String status,
    required Color statusColor,
    required Color bgColor,
    required String title,
    required String date,
    required String price,
    required String imagePath,
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
                  child: Image.asset(
                    imagePath,
                    height: 130.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 130.h,
                        width: double.infinity,
                        color: Colors.grey.shade200,
                        child: const Center(
                          child: Icon(Icons.image_not_supported, color: Colors.grey),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 12.h,
                  left: 12.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      status,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                    ),
                  ),
                ),
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
                  Text(
                    price,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2E7D32),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}