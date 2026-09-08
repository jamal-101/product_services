import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants/api_enpoint.dart';
import '../../../../../utils/constants/app_images.dart';
import '../controller/my_store_controller.dart';

class ProductsWidgetMe extends StatelessWidget {
  const ProductsWidgetMe({super.key});

  @override
  Widget build(BuildContext context) {
    final MyStoreController controller = Get.find<MyStoreController>();

    return Obx(() {
      final bool isProductStore = controller.isProductStore.value;

      final productsList = controller.myStoreModel.value?.data?.products ?? [];
      final servicesList = controller.myStoreModel.value?.data?.services ?? [];

      // ১. যদি ইউজার প্রোডাক্ট ট্যাবে থাকে এবং প্রোডাক্ট খালি থাকে
      if (isProductStore && productsList.isEmpty) {
        return Center(
          child: Text(
            "No products available",
            style: TextStyle(fontSize: 14.sp, color: Colors.grey),
          ),
        );
      }

      // ২. যদি ইউজার সার্ভিস ট্যাবে থাকে এবং সার্ভিস খালি থাকে
      if (!isProductStore && servicesList.isEmpty) {
        return Center(
          child: Text(
            "No services available",
            style: TextStyle(fontSize: 14.sp, color: Colors.grey),
          ),
        );
      }

      // কোন লিস্টটি দেখাবে তার কাউন্ট ঠিক করা
      final itemCount = isProductStore ? productsList.length : servicesList.length;

      // যদি কোনো কারণে কাউন্ট ০ হয় কিন্তু উপরে ধরা না খায়
      if (itemCount == 0) {
        return Center(
          child: Text(
            isProductStore ? "No products available" : "No services available",
            style: TextStyle(fontSize: 14.sp, color: Colors.grey),
          ),
        );
      }

      return GridView.builder(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 12.h, bottom: 100.h),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
        ),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          String title = "";
          num activePrice = 0;
          num originalPrice = 0;
          List<String>? images;

          if (isProductStore) {
            final product = productsList[index];
            title = product.title ?? "Product";
            activePrice = product.activePrice ?? 0;
            originalPrice = product.originalPrice ?? 0;
            images = product.images;
          } else {
            final service = servicesList[index];
            title = service.title ?? "Service";
            activePrice = service.activePrice ?? 0;
            originalPrice = service.originalPrice ?? 0;
            images = service.images;
          }

          String? imgPath;
          if (images != null && images.isNotEmpty) {
            imgPath = images[0];
          }

          String imageUrl = (imgPath != null && imgPath.isNotEmpty)
              ? (imgPath.startsWith('http') ? imgPath : '${ApiEndPoint.imageUrl}$imgPath')
              : "";

          String discountText = "";
          if (originalPrice > activePrice && originalPrice > 0) {
            int discountPercent = (((originalPrice - activePrice) / originalPrice) * 100).round();
            discountText = "-$discountPercent%";
          }

          return _buildItemCard(
            title: title,
            activePrice: activePrice,
            originalPrice: originalPrice,
            discount: discountText,
            isProduct: isProductStore,
            imageUrl: imageUrl,
          );
        },
      );
    });
  }

  Widget _buildItemCard({
    required String title,
    required num activePrice,
    required num originalPrice,
    required String discount,
    required bool isProduct,
    required String imageUrl,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
                  child: imageUrl.isNotEmpty
                      ? Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                      isProduct ? AppImages.productImage : AppImages.serviceImage,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  )
                      : Image.asset(
                    isProduct ? AppImages.productImage : AppImages.serviceImage,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                if (discount.isNotEmpty)
                  Positioned(
                    top: 8.h,
                    left: 8.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE67E22),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        discount,
                        style: TextStyle(color: Colors.white, fontSize: 10.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Text("\$$activePrice", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
                    SizedBox(width: 4.w),
                    if (originalPrice > 0)
                      Text("\$$originalPrice", style: TextStyle(fontSize: 11.sp, color: Colors.grey, decoration: TextDecoration.lineThrough)),
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