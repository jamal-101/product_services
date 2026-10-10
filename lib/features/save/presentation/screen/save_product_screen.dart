import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/features/save/model/favourite_product_model.dart';
import 'package:product_service/utils/constants/api_enpoint.dart';
import '../../../product_store_flow/presentation/screen/productServiceDetailsScreen.dart';
import '../../controller/save_product_controller.dart';

class SavedProductScreen extends StatelessWidget {
  const SavedProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SaveProductController controllers = Get.put(SaveProductController());

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
                        controllers: controllers,
                        title: "Products",
                        icon: Icons.shopping_bag_outlined,
                        index: 0,
                      ),
                    ),
                    Expanded(
                      child: _buildTabButton(
                        controllers: controllers,
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
            Expanded(
              child: Obx(() {
                if (controllers.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.orange),
                  );
                }

                bool isProductTab = controllers.selectedTab.value == 0;
                List<FavoriteData> currentList = isProductTab
                    ? controllers.favoriteProductList
                    : controllers.favoriteStoreList;

                if (currentList.isEmpty) {
                  return Center(
                    child: Text(
                      "No saved items found",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14.sp,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  );
                }

                return GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.w,
                    mainAxisSpacing: 16.h,
                    childAspectRatio: 0.72,
                  ),
                  itemCount: currentList.length,
                  itemBuilder: (context, index) {
                    final FavoriteData favoriteItem = currentList[index];
                    final target = favoriteItem.targetId;
                    String rawImage = '';
                    if (target?.images != null && target!.images!.isNotEmpty) {
                      rawImage = target.images!.first;
                    }
                    String imageUrl = '';
                    if (rawImage.isNotEmpty) {
                      if (rawImage.startsWith('http://') || rawImage.startsWith('https://')) {
                        imageUrl = rawImage;
                      } else {
                        imageUrl = "${ApiEndPoint.imageUrl}$rawImage";
                      }
                    }

                    String title = target?.title ?? "No Title";
                    num activePrice = target?.activePrice ?? 0;
                    num? originalPrice = target?.originalPrice;

                    String? discountText;
                    if (originalPrice != null && originalPrice > activePrice) {
                      int discountPercent = (((originalPrice - activePrice) / originalPrice) * 100).round();
                      discountText = "-$discountPercent%";
                    }

                    return _buildItemCard(
                      imagePath: imageUrl,
                      title: title,
                      price: "\$$activePrice",
                      oldPrice: originalPrice != null ? "\$$originalPrice" : null,
                      discountText: discountText,
                      isNetworkImage: true,
                      onTapCard: () {
                        if (target?.sId != null) {
                          Get.to(() => ProductServiceDetailsScreen(
                            itemId: target!.sId!,
                            isProduct: isProductTab,
                          ));
                        }
                      },
                      onTapFavorite: () {
                        String targetType = controllers.selectedTab.value == 0 ? "product" : "service";
                        if (target?.sId != null) {
                          controllers.toggleFavorite(target!.sId!, targetType);
                        }
                      },

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

  Widget _buildTabButton({
    required SaveProductController controllers,
    required String title,
    required IconData icon,
    required int index,
  }) {
    return Obx(() {
      bool isSelected = controllers.selectedTab.value == index;
      return GestureDetector(
        onTap: () => controllers.changeTab(index),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: isSelected
                ? [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
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
                  fontSize: 12.sp,
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


  Widget _buildItemCard({
    required String imagePath,
    required String title,
    required String price,
    String? oldPrice,
    String? discountText,
    bool isNetworkImage = false,
    required VoidCallback onTapFavorite,
    required VoidCallback onTapCard,
  }) {
    return GestureDetector(
      onTap: onTapCard,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: const Color(0xFFF3F4F6)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
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
                        image: isNetworkImage && imagePath.isNotEmpty
                            ? NetworkImage(imagePath) as ImageProvider
                            : const AssetImage('assets/images/placeholder.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8.h,
                    right: 8.w,
                    child: GestureDetector(
                      onTap: onTapFavorite,
                      child: Container(
                        padding: EdgeInsets.all(6.r),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.favorite, color: Colors.orange, size: 14),
                      ),
                    ),
                  ),

                  if (discountText != null)
                    Positioned(
                      top: 8.h,
                      left: 8.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          discountText,
                          style: GoogleFonts.plusJakartaSans(
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
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                          color: const Color(0xFF111827),
                        ),
                      ),
                      SizedBox(width: 6.w),

                      if (oldPrice != null) ...[
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
      ),
    );
  }
}