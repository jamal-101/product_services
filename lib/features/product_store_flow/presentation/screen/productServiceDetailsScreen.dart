import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:product_service/features/product_store_flow/presentation/screen/store_details_page.dart';
import '../../../../utils/constants/api_enpoint.dart';
import '../controller/productServiceDetailsController.dart';
import '../controller/store_details_controller.dart';
import '../widget/prdcut_service_contactFrom.dart';

class ProductServiceDetailsScreen extends StatelessWidget {
  final String itemId;
  final bool isProduct;

  const ProductServiceDetailsScreen({
    super.key,
    required this.itemId,
    required this.isProduct,
  });



  @override
  Widget build(BuildContext context) {
    final ProductServiceDetailsController controller =
    Get.put(ProductServiceDetailsController());

    final StoreDetailsController storeController =
    Get.put(StoreDetailsController());

    controller.fetchDetails(itemId, isProduct);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          isProduct ? "Product Details" : "Service Details",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFFEE7A1F)),
          );
        }

        final productData = controller.productModel.value.data;
        final serviceData = controller.serviceModel.value.data;

        if (isProduct && productData == null) {
          return const Center(child: Text("No product details found"));
        }
        if (!isProduct && serviceData == null) {
          return const Center(child: Text("No service details found"));
        }
        final String title = isProduct
            ? (productData?.title ?? "No Title")
            : (serviceData?.title ?? "No Title");

        final num activePrice = isProduct
            ? (productData?.activePrice ?? 0)
            : (serviceData?.activePrice ?? 0);

        final num originalPrice = isProduct
            ? (productData?.originalPrice ?? 0)
            : (serviceData?.originalPrice ?? 0);

        final String description = isProduct
            ? (productData?.description ?? "")
            : (serviceData?.description ?? "");

        final List<String> images = isProduct
            ? (productData?.images ?? [])
            : (serviceData?.images ?? []);

        final String additionalInfo =
        isProduct ? (productData?.additionalInformation ?? "") : "";
        final List<String> whatsIncluded =
        !isProduct ? (serviceData?.whatsIncluded ?? []) : [];

        final dynamic store =
        isProduct ? productData?.storeId : serviceData?.storeId;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                height: 300.h,
                width: double.infinity,
                color: Colors.grey.shade200,
                child: images.isNotEmpty
                    ? Stack(
                  children: [
                    PageView.builder(
                      itemCount: images.length,
                      onPageChanged: (index) {
                        controller.currentImageIndex.value = index;
                      },
                      itemBuilder: (context, index) {
                        String rawImg = images[index];
                        String imageUrl = rawImg.startsWith('http')
                            ? rawImg
                            : "${ApiEndPoint.imageUrl}$rawImg";
                        return Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image, size: 50, color: Colors.grey),
                        );
                      },
                    ),
                    Positioned(
                      top: 16.h,
                      right: 16.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Obx(() => Text(
                          "${controller.currentImageIndex.value + 1}/${images.length}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ),
                    ),
                    Positioned(
                      bottom: 12.h,
                      left: 0,
                      right: 0,
                      child: Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          images.length,
                              (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: EdgeInsets.symmetric(horizontal: 3.w),
                            height: 6.h,
                            width: controller.currentImageIndex.value == index
                                ? 20.w
                                : 6.h,
                            decoration: BoxDecoration(
                              color: controller.currentImageIndex.value == index
                                  ? Colors.white
                                  : Colors.white.withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(3.r),
                            ),
                          ),
                        ),
                      )),
                    ),
                  ],
                )
                    : const Center(
                  child: Icon(Icons.image, size: 50, color: Colors.grey),
                ),
              ),

              SizedBox(height: 16.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Text(
                            "\$$activePrice",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          if (originalPrice > 0)
                            Text(
                              "\$$originalPrice",
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "Description",
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.grey.shade700,
                          height: 1.4,
                        ),
                      ),

                      if (isProduct && additionalInfo.isNotEmpty) ...[
                        SizedBox(height: 16.h),
                        Text(
                          "Additional Information",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          additionalInfo,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],

                      if (!isProduct && whatsIncluded.isNotEmpty) ...[
                        SizedBox(height: 16.h),
                        Text(
                          "What's Included",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        ...whatsIncluded.map(
                              (item) => Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.check_circle,
                                    color: Colors.green, size: 16.sp),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              if (store != null)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 24.r,
                          backgroundImage: store.logo != null &&
                              store.logo.toString().isNotEmpty
                              ? NetworkImage(
                              store.logo.toString().startsWith('http')
                                  ? store.logo
                                  : "${ApiEndPoint.imageUrl}${store.logo}")
                              : null,
                          child: (store.logo == null ||
                              store.logo.toString().isEmpty)
                              ? const Icon(Icons.store, color: Colors.grey)
                              : null,
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                store.displayName ?? "Store Name",
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                store.storeType ?? "",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (store != null && store.sId != null) {
                              Get.to(
                                    () => const ProductDetailsScreen(),
                                arguments: {
                                  'storeId': store.sId,
                                  'storeType': store.storeType ?? "",
                                },
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFEE7A1F),
                            minimumSize: Size(70.w, 32.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                          ),
                          child: Text(
                            "View Store",
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              SizedBox(height: 30.h),
            ],
          ),
        );
      }),
      bottomNavigationBar:ProductServiceContactFrom(),
    );
  }
}