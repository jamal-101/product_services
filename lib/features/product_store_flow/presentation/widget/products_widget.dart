// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_instance/src/extension_instance.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:product_service/config/route/app_route.dart';
// import 'package:product_service/utils/constants/app_images.dart';
// import '../../../home_flow/presentatin/controller/home_controller.dart';
// import 'contuctForm_widget.dart';
//
//
// class ProductsWidget extends StatelessWidget {
//   const ProductsWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         GridView.builder(
//           padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 12.h, bottom: 100.h),
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             childAspectRatio: 0.75,
//             crossAxisSpacing: 12.w,
//             mainAxisSpacing: 12.h,
//           ),
//           itemCount: 6,
//           itemBuilder: (context, index) => _buildProductCard(),
//         ),
//
//         Positioned(
//           bottom: 16.h,
//           left: 16.w,
//           right: 16.w,
//           child: const ContactFooterWidget(),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildProductCard() {
//     final controller = Get.find<HomeController>();
//     return GestureDetector(
//       onTap: () {
//         Get.toNamed(AppRoutes.productDetailsScreen,arguments: controller.isProductStoreSelected.value,);
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12.r),
//           border: Border.all(color: Colors.grey.shade200),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: Stack(
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
//                     child: Image.asset(
//                       controller.isProductStoreSelected.value ? AppImages.productImage : AppImages.serviceImage,
//                       fit: BoxFit.cover,
//                       width: double.infinity,
//                     ),
//                   ),
//                   // ডিসকাউন্ট ট্যাগ
//                   Positioned(
//                     top: 8.h,
//                     left: 8.w,
//                     child: Container(
//                       padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFE67E22),
//                         borderRadius: BorderRadius.circular(4.r),
//                       ),
//                       child: Text("-25%", style: TextStyle(color: Colors.white, fontSize: 10.sp, fontWeight: FontWeight.bold)),
//                     ),
//                   ),
//                   // হার্ট আইকন
//                   Positioned(
//                     top: 8.h,
//                     right: 8.w,
//                     child: Container(
//                         decoration: const BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.white
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Icon(Icons.favorite_border, color: Colors.grey.shade700, size: 20.sp),
//                         )),
//                   ),
//                 ],
//               ),
//             ),
//             // প্রোডাক্ট ডিটেইলস
//             Padding(
//               padding: EdgeInsets.all(8.w),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Vintage Leather Jacket for men",
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
//                   ),
//                   SizedBox(height: 4.h),
//                   Row(
//                     children: [
//                       Text("\$89.99", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
//                       SizedBox(width: 4.w),
//                       Text("\$95.45", style: TextStyle(fontSize: 11.sp, color: Colors.grey, decoration: TextDecoration.lineThrough)),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:product_service/utils/constants/app_images.dart';
import '../controller/store_details_controller.dart';
import 'contuctForm_widget.dart';

class ProductsWidget extends StatelessWidget {
  const ProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final StoreDetailsController controller = Get.find<StoreDetailsController>();

    return Obx(() {
      final storeData = controller.storeDetailsModel.value.data;
      final bool isProductStore = storeData?.store?.storeType?.toLowerCase() == 'product';

      // প্রোডাক্ট অথবা সার্ভিস লিস্ট চেক করা
      final int itemCount = isProductStore
          ? (storeData?.products?.length ?? 0)
          : (storeData?.services?.length ?? 0);

      if (itemCount == 0) {
        return Stack(
          children: [
            Center(
              child: Text(
                isProductStore ? "No products available" : "No services available",
                style: TextStyle(fontSize: 14.sp, color: Colors.grey),
              ),
            ),
            const Positioned(
              bottom: 16, left: 16, right: 16,
              child: ContactFooterWidget(),
            ),
          ],
        );
      }

      return Stack(
        children: [
          GridView.builder(
            padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 12.h, bottom: 100.h),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
            ),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              if (isProductStore) {
                final product = storeData!.products![index];
                return _buildItemCard(
                  title: product.title ?? "",
                  activePrice: product.activePrice ?? 0,
                  originalPrice: product.originalPrice ?? 0,
                  imageUrl: (product.images != null && product.images!.isNotEmpty) ? product.images!.first : "",
                  isProduct: true,
                );
              } else {
                final service = storeData!.services![index];
                return _buildItemCard(
                  title: service.title ?? "",
                  activePrice: service.activePrice ?? 0,
                  originalPrice: service.originalPrice ?? 0,
                  imageUrl: (service.images != null && service.images!.isNotEmpty) ? service.images!.first : "",
                  isProduct: false,
                );
              }
            },
          ),
          Positioned(
            bottom: 16.h,
            left: 16.w,
            right: 16.w,
            child: const ContactFooterWidget(),
          ),
        ],
      );
    });
  }

  Widget _buildItemCard({
    required String title,
    required num activePrice,
    required num originalPrice,
    required String imageUrl,
    required bool isProduct,
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
                Positioned(
                  top: 8.h,
                  left: 8.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE67E22),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text("-25%", style: TextStyle(color: Colors.white, fontSize: 10.sp, fontWeight: FontWeight.bold)),
                  ),
                ),
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: Container(
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.favorite_border, color: Colors.grey.shade700, size: 20.sp),
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