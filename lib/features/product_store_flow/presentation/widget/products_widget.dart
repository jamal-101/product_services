import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:product_service/config/route/app_route.dart';
import 'package:product_service/utils/constants/app_images.dart';
import '../../../home_flow/presentatin/controller/home_controller.dart';
import 'contuctForm_widget.dart';


class ProductsWidget extends StatelessWidget {
  const ProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
          itemCount: 6,
          itemBuilder: (context, index) => _buildProductCard(),
        ),

        Positioned(
          bottom: 16.h,
          left: 16.w,
          right: 16.w,
          child: const ContactFooterWidget(),
        ),
      ],
    );
  }

  Widget _buildProductCard() {
    final controller = Get.find<HomeController>();
    return GestureDetector(
      onTap: () {
        // GetX এর মাধ্যমে নেভিগেট করার সঠিক উপায়:
        Get.toNamed(AppRoutes.productDetailsScreen,arguments: controller.isProductStoreSelected.value,);
      },
      child: Container(
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
                    child: Image.asset(
                      controller.isProductStoreSelected.value ? AppImages.productImage : AppImages.serviceImage,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  // ডিসকাউন্ট ট্যাগ
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
                  // হার্ট আইকন
                  Positioned(
                    top: 8.h,
                    right: 8.w,
                    child: Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.favorite_border, color: Colors.grey.shade700, size: 20.sp),
                        )),
                  ),
                ],
              ),
            ),
            // প্রোডাক্ট ডিটেইলস
            Padding(
              padding: EdgeInsets.all(8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Vintage Leather Jacket for men",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Text("\$89.99", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
                      SizedBox(width: 4.w),
                      Text("\$95.45", style: TextStyle(fontSize: 11.sp, color: Colors.grey, decoration: TextDecoration.lineThrough)),
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