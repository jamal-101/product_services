import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/features/save/controller/save_controller.dart';
import 'package:product_service/utils/constants/app_images.dart';


class SavedProductScreen extends StatelessWidget {
  const SavedProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SaveController controller = Get.put(SaveController());

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
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
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: Text(
          "Saved",
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 12.h),

            // টপ সুইচিং ট্যাব (Product & Services)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                padding: EdgeInsets.all(4.r),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildTabButton(
                        controller: controller,
                        title: "Product",
                        icon: Icons.shopping_bag_outlined,
                        index: 0,
                      ),
                    ),
                    Expanded(
                      child: _buildTabButton(
                        controller: controller,
                        title: "Services",
                        icon: Icons.design_services_outlined,
                        index: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),

            // গ্রিডভিউ সেকশন (ট্যাব অনুযায়ী ডাটা পরিবর্তন হবে)
            Expanded(
              child: Obx(() {
                bool isProductTab = controller.selectedTab.value == 0;

                return GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.w,
                    mainAxisSpacing: 16.h,
                    childAspectRatio: 0.72,
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return isProductTab
                        ? _buildProductCard(
                      imagePath: AppImages.productImage,
                      title: index == 0
                          ? "Vintage Leather Jacket for men- Winter Fashion"
                          : index == 1
                          ? "Beige Bamboo Blended Long Sleeve Formal Shirt"
                          : index == 2
                          ? "Olive Green Jersey Short Sleeve Polo"
                          : "Brown Slab Cotton Comfort Casual Shirt",
                      price: index == 1 ? "\$29.99" : "\$89.99",
                      oldPrice: index == 1 ? "\$35.45" : null,
                      hasDiscount: index == 1,
                    )
                        : _buildProductCard(
                      imagePath: AppImages.serviceImage,
                      title: index == 0
                          ? "Professional Room Cleaning service"
                          : index == 1
                          ? "Residential Plumbing Solutions"
                          : index == 2
                          ? "Air Conditioning Repair Maintenance & Cleaning"
                          : "Residential Painting Experts",
                      price: index == 3 ? "\$29.99" : "\$89.99",
                      oldPrice: index != 3 ? "\$95.45" : null,
                      hasDiscount: index != 3,
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // ট্যাব বাটন উইজেট
  Widget _buildTabButton({
    required SaveController controller,
    required String title,
    required IconData icon,
    required int index,
  }) {
    return Obx(() {
      bool isSelected = controller.selectedTab.value == index;
      return GestureDetector(
        onTap: () => controller.changeTab(index),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: isSelected
                ? [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              )
            ]
                : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16.sp,
                color: isSelected ? Colors.black : Colors.grey.shade600,
              ),
              SizedBox(width: 6.w),
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13.sp,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: isSelected ? Colors.black : Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  // প্রোডাক্ট বা সার্ভিস কার্ড উইজেট
  Widget _buildProductCard({
    required String imagePath,
    required String title,
    required String price,
    String? oldPrice,
    bool hasDiscount = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFF3F4F6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // হার্ট / ফেভারিট আইকন
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: Container(
                    padding: EdgeInsets.all(6.r),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.favorite, color: Colors.orange, size: 14),
                  ),
                ),
                // ডিসকাউন্ট ব্যাজ (যদি থাকে)
                if (hasDiscount)
                  Positioned(
                    top: 8.h,
                    left: 8.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        "-25%",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF111827),
                  ),
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Text(
                      price,
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.sp,
                        color: const Color(0xFF111827),
                      ),
                    ),
                    if (oldPrice != null) ...[
                      SizedBox(width: 6.w),
                      Text(
                        oldPrice,
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.grey.shade400,
                          decoration: TextDecoration.lineThrough,
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}