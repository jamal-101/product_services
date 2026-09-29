import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:product_service/utils/constants/app_color.dart';
import 'package:product_service/utils/constants/app_images.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../component/bottom_navBar/nav_bar..dart';
import '../../../../../utils/constants/api_enpoint.dart';
import '../controller/listing_controller.dart';
import '../model/service_model.dart' as s_model;
import '../model/product_model.dart' as p_model;
import 'add_product_screen.dart';

class MyListingScreen extends StatelessWidget {
  MyListingScreen({super.key});

  final MyListingController controller = Get.put(MyListingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColor.appBackgroundColor,
        automaticallyImplyLeading: false,
        centerTitle: false,
        elevation: 0,
        title: Text(
          "My Listing",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: InkWell(
              onTap: () async {
                bool? isChanged = await Get.to(
                      () => const AddProductScreen(),
                );
                if (isChanged == true) {
                  controller.fetchMyListings();
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF2A9B4A),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.add, color: Colors.white, size: 18),
                    SizedBox(width: 4.w),
                    Obx(() => Text(
                      controller.storeType == "service_store" ? "Add Service" : "Add Product",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(selectedIndex: 1),
      body: Obx(() {
        // if (controller.isLoading.value) {
        //   return const Center(
        //     child: CircularProgressIndicator(color: Color(0xFF27AE60)),
        //   );
        // }

        if (controller.isLoading.value) {
          return _buildListingShimmerLoader();
        }

        bool isService = controller.storeType == "service_store";
        int itemCount = isService ? controller.serviceList.length : controller.productList.length;

        if (itemCount == 0) {
          return Center(
            child: Text(
              isService ? "No Services Found" : "No Products Found",
              style: TextStyle(fontSize: 14.sp, color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.all(16.w),
          itemCount: itemCount,
          itemBuilder: (context, index) {
            String title = "No Title";
            double activePrice = 0;
            double originalPrice = 0;
            List<String>? images;
            String? itemId;

            if (isService) {
              s_model.Data item = controller.serviceList[index];
              title = item.title ?? "No Title";
              activePrice = (item.activePrice ?? 0).toDouble(); // int বা double যাই আসুক safely double-এ কনভার্ট হবে
              originalPrice = (item.originalPrice ?? 0).toDouble();
              images = item.images;
              itemId = item.sId;
            } else {
              p_model.Data item = controller.productList[index];
              title = item.title ?? "No Title";
              // activePrice = item.activePrice ?? 0;
              // originalPrice = item.originalPrice ?? 0;
              activePrice = (item.activePrice ?? 0).toDouble(); // int বা double যাই আসুক safely double-এ কনভার্ট হবে
              originalPrice = (item.originalPrice ?? 0).toDouble();
              images = item.images;
              itemId = item.sId;
            }

            String imageUrl = AppImages.buyerImage;
            if (images != null && images.isNotEmpty) {
              String rawPath = images.first;
              if (rawPath.startsWith('http')) {
                imageUrl = rawPath;
              } else {
                imageUrl = "${ApiEndPoint.imageUrl}$rawPath";
              }
            }

            return Container(
              margin: EdgeInsets.only(bottom: 12.h),
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.network(
                      imageUrl,
                      width: 60.w,
                      height: 60.w,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 60.w,
                        height: 60.w,
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.image_not_supported, color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Row(
                          children: [
                            Text(
                              "\$$activePrice",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            if (originalPrice > 0)
                              Text(
                                "\$$originalPrice",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton<String>(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                    onSelected: (value) async {
                      if (value == 'edit') {
                        var rawItem = isService
                            ? controller.serviceList[index]
                            : controller.productList[index];

                        bool? isChanged = await Get.to(
                              () => const AddProductScreen(),
                          arguments: rawItem,
                        );
                        if (isChanged == true) {
                          controller.fetchMyListings();
                        }
                      } else if (value == 'delete') {
                        if (itemId != null) {
                          controller.deleteItem(itemId);
                        }
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Text("Edit"),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Text("Delete", style: TextStyle(color: Colors.red)),
                      ),
                    ],
                    icon: const Icon(Icons.more_vert, color: Colors.grey),
                  )
                ],
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildListingShimmerLoader() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        padding: EdgeInsets.all(16.w),
        itemCount: 6,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 12.h),
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              children: [
                Container(
                  width: 60.w,
                  height: 60.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // টাইটেল শিমার
                      Container(
                        width: double.infinity,
                        height: 14.h,
                        color: Colors.white,
                      ),
                      SizedBox(height: 8.h),
                      // প্রাইস শিমার
                      Container(
                        width: 80.w,
                        height: 12.h,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                // থ্রি ডট আইকন শিমার
                Container(
                  width: 24.w,
                  height: 24.h,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

}