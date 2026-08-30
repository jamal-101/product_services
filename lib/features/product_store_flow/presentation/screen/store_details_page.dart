// // import 'package:flutter/material.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:get/get_core/src/get_main.dart';
// // import 'package:get/get_navigation/src/extension_navigation.dart';
// // import '../../../../utils/constants/app_images.dart';
// // import '../widget/about_widget.dart';
// // import '../widget/products_widget.dart';
// // import '../widget/reviews.dart';
// //
// // class ProductDetailsScreen extends StatelessWidget {
// //   const ProductDetailsScreen({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final bool isProductStore = Get.arguments ?? true;
// //     return Scaffold(
// //       body: DefaultTabController(
// //         length: 3,
// //         child: NestedScrollView(
// //           headerSliverBuilder: (context, innerBoxIsScrolled) => [
// //             SliverAppBar(
// //               expandedHeight: 280.h,
// //               pinned: true,
// //               backgroundColor: Colors.white,
// //               automaticallyImplyLeading: false,
// //               flexibleSpace: FlexibleSpaceBar(
// //                 background: _buildHeaderSection(isProductStore),
// //               ),
// //             ),
// //             SliverPersistentHeader(
// //               delegate: _SliverAppBarDelegate(
// //                 TabBar(
// //                   labelColor: Colors.black,
// //                   unselectedLabelColor: Colors.grey,
// //                   indicatorColor: const Color(0xFFE67E22),
// //                   labelStyle: TextStyle(
// //                     fontWeight: FontWeight.bold,
// //                     fontSize: 14.sp,
// //                   ),
// //                   tabs: [
// //                     Tab(text: isProductStore ? "Products" :"Services"),
// //                     Tab(text: "About"),
// //                     Tab(text: "Reviews"),
// //                   ],
// //                 ),
// //               ),
// //               pinned: true,
// //             ),
// //           ],
// //           body: const TabBarView(
// //             children: [ProductsWidget(), AboutWidget(), ReviewsWidget()],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildHeaderSection(bool isProductStore) {
// //     return Stack(
// //       children: [
// //         // কভার ইমেজ
// //         Positioned(
// //           top: 0,
// //           left: 0,
// //           right: 0,
// //           height: 180.h,
// //           child: Image.asset(
// //             isProductStore
// //                 ? AppImages.storeCoverImage
// //                 : AppImages.serviceDetailsImage,
// //             fit: BoxFit.cover,
// //           ),
// //         ),
// //
// //         // কাস্টম ব্যাক বাটন (ইমেজের ওপর)
// //         Positioned(
// //           top: 40.h,
// //           left: 16.w,
// //           child: GestureDetector(
// //             onTap: () => Get.back(),
// //             child: Container(
// //               height: 30.h,
// //               width: 30.w,
// //               padding: EdgeInsets.all(8.w),
// //               decoration: BoxDecoration(
// //                 borderRadius: BorderRadius.circular(12.r),
// //                 color: Colors.white,
// //               ),
// //               child: Center(
// //                 child: const Icon(
// //                   Icons.arrow_back,
// //                   color: Colors.black,
// //                   size: 18,
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ),
// //
// //         // কাস্টম বুকমার্ক বাটন (ইমেজের ওপর)
// //         Positioned(
// //           top: 40.h,
// //           right: 16.w,
// //           child: Container(
// //             padding: EdgeInsets.all(8.w),
// //             decoration: BoxDecoration(
// //               color: Color(0x000000).withValues(alpha: 0.2),
// //               shape: BoxShape.circle,
// //             ),
// //             child: const Icon(Icons.bookmark_border, color: Colors.white),
// //           ),
// //         ),
// //
// //         // স্টোর লোগো এবং নাম (ওভারল্যাপিং অংশ)
// //         Positioned(
// //           top: 140.h,
// //           left: 16.w,
// //           right: 16.w,
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Container(
// //                 padding: EdgeInsets.all(4.w),
// //                 decoration: BoxDecoration(
// //                   color: Colors.white,
// //                   borderRadius: BorderRadius.circular(12.r),
// //                 ),
// //                 child: Image.asset(isProductStore?AppImages.leLogo:AppImages.store_logo, width: 70.w, height: 70.w),
// //               ),
// //               SizedBox(height: 8.h),
// //               Text(
// //                 "LE REVE",
// //                 style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
// //               ),
// //               Text(
// //                 "Fashion • 4.9 (1,247 reviews) • Calle Gran Via 32, Madrid",
// //                 style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }
// //
// // class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
// //   _SliverAppBarDelegate(this._tabBar);
// //   final TabBar _tabBar;
// //   @override
// //   double get minExtent => _tabBar.preferredSize.height;
// //   @override
// //   double get maxExtent => _tabBar.preferredSize.height;
// //   @override
// //   Widget build(context, shrinkOffset, overlapsContent) =>
// //       Container(color: Colors.white, child: _tabBar);
// //   @override
// //   bool shouldRebuild(oldDelegate) => false;
// // }
// //
// //
// //
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import '../../../../utils/constants/app_images.dart';
// import '../widget/about_widget.dart';
// import '../widget/products_widget.dart';
// import '../widget/reviews.dart';
//
// class ProductDetailsScreen extends StatelessWidget {
//   const ProductDetailsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // আর্গুমেন্ট থেকে সেফলি বুলিয়ান বা স্ট্রিং রিসিভ করা (ক্রাশ এড়ানোর জন্য)
//     final dynamic argument = Get.arguments;
//     final bool isProductStore = argument is bool ? argument : true;
//
//     return Scaffold(
//       body: DefaultTabController(
//         length: 3,
//         child: NestedScrollView(
//           headerSliverBuilder: (context, innerBoxIsScrolled) => [
//             SliverAppBar(
//               expandedHeight: 280.h,
//               pinned: true,
//               backgroundColor: Colors.white,
//               automaticallyImplyLeading: false,
//               flexibleSpace: FlexibleSpaceBar(
//                 background: _buildHeaderSection(isProductStore),
//               ),
//             ),
//             SliverPersistentHeader(
//               delegate: _SliverAppBarDelegate(
//                 TabBar(
//                   labelColor: Colors.black,
//                   unselectedLabelColor: Colors.grey,
//                   indicatorColor: const Color(0xFFE67E22),
//                   labelStyle: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 14.sp,
//                   ),
//                   tabs: [
//                     Tab(text: isProductStore ? "Products" : "Services"),
//                     Tab(text: "About"),
//                     Tab(text: "Reviews"),
//                   ],
//                 ),
//               ),
//               pinned: true,
//             ),
//           ],
//           body: const TabBarView(
//             children: [ProductsWidget(), AboutWidget(), ReviewsWidget()],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeaderSection(bool isProductStore) {
//     return Stack(
//       children: [
//         // কভার ইমেজ
//         Positioned(
//           top: 0,
//           left: 0,
//           right: 0,
//           height: 180.h,
//           child: Image.asset(
//             isProductStore
//                 ? AppImages.storeCoverImage
//                 : AppImages.serviceDetailsImage,
//             fit: BoxFit.cover,
//           ),
//         ),
//
//         // কাস্টম ব্যাক বাটন (ইমেজের ওপর)
//         Positioned(
//           top: 40.h,
//           left: 16.w,
//           child: GestureDetector(
//             onTap: () => Get.back(),
//             child: Container(
//               height: 30.h,
//               width: 30.w,
//               padding: EdgeInsets.all(8.w),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12.r),
//                 color: Colors.white,
//               ),
//               child: Center(
//                 child: const Icon(
//                   Icons.arrow_back,
//                   color: Colors.black,
//                   size: 18,
//                 ),
//               ),
//             ),
//           ),
//         ),
//
//         // কাস্টম বুকমার্ক বাটন (ইমেজের ওপর)
//         Positioned(
//           top: 40.h,
//           right: 16.w,
//           child: Container(
//             padding: EdgeInsets.all(8.w),
//             decoration: BoxDecoration(
//               color: const Color(0xFF000000).withValues(alpha: 0.2),
//               shape: BoxShape.circle,
//             ),
//             child: const Icon(Icons.bookmark_border, color: Colors.white),
//           ),
//         ),
//
//         // স্টোর লোগো এবং নাম (ওভারল্যাপিং অংশ)
//         Positioned(
//           top: 140.h,
//           left: 16.w,
//           right: 16.w,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 padding: EdgeInsets.all(4.w),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12.r),
//                 ),
//                 child: Image.asset(
//                   isProductStore ? AppImages.leLogo : AppImages.store_logo,
//                   width: 70.w,
//                   height: 70.w,
//                 ),
//               ),
//               SizedBox(height: 8.h),
//               Text(
//                 "LE REVE",
//                 style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 "Fashion • 4.9 (1,247 reviews) • Calle Gran Via 32, Madrid",
//                 style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
//   _SliverAppBarDelegate(this._tabBar);
//   final TabBar _tabBar;
//   @override
//   double get minExtent => _tabBar.preferredSize.height;
//   @override
//   double get maxExtent => _tabBar.preferredSize.height;
//   @override
//   Widget build(context, shrinkOffset, overlapsContent) =>
//       Container(color: Colors.white, child: _tabBar);
//   @override
//   bool shouldRebuild(oldDelegate) => false;
// }


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/constants/api_enpoint.dart';
import '../../../../utils/constants/app_images.dart';
// আপনার ApiEndPoint ফাইলটি এখান থেকে ইমপোর্ট করে নিন
import '../controller/store_details_controller.dart';
import '../widget/about_widget.dart';
import '../widget/products_widget.dart';
import '../widget/reviews.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final StoreDetailsController controller = Get.put(StoreDetailsController());
    final dynamic argument = Get.arguments;

    String storeId = "";
    if (argument is String) {
      storeId = argument;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (storeId.isNotEmpty && controller.storeDetailsModel.value.data == null) {
        controller.fetchStoreDetails(storeId);
      }
    });

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFFE67E22)),
          );
        }

        final storeData = controller.storeDetailsModel.value.data?.store;
        final bool isProductStore = storeData?.storeType?.toLowerCase() == 'product';

        return DefaultTabController(
          length: 3,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                expandedHeight: 280.h,
                pinned: true,
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: _buildHeaderSection(storeData, isProductStore),
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: const Color(0xFFE67E22),
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                    tabs: [
                      Tab(text: isProductStore ? "Products" : "Services"),
                      const Tab(text: "About"),
                      const Tab(text: "Reviews"),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ],
            body: const TabBarView(
              children: [
                ProductsWidget(),
                AboutWidget(),
                ReviewsWidget(),
              ],
            ),
          ),
        );
      }),
    );
  }

  // Widget _buildHeaderSection(storeData, bool isProductStore) {
  //   // ApiEndPoint.imageUrl থেকে বেস ইউআরএল নিয়ে ফুল পাথ তৈরি করা হচ্ছে
  //   final String? coverUrl = storeData?.coverImage != null && storeData!.coverImage!.isNotEmpty
  //       ? (storeData.coverImage!.startsWith('http')
  //       ? storeData.coverImage!
  //       : "${ApiEndPoint.imageUrl}${storeData.coverImage!}")
  //       : null;
  //
  //   final String? logoUrl = storeData?.logo != null && storeData!.logo!.isNotEmpty
  //       ? (storeData.logo!.startsWith('http')
  //       ? storeData.logo!
  //       : "${ApiEndPoint.imageUrl}${storeData.logo!}")
  //       : null;
  //
  //   return Stack(
  //     children: [
  //       // কভার ইমেজ
  //       Positioned(
  //         top: 0,
  //         left: 0,
  //         right: 0,
  //         height: 180.h,
  //         child: coverUrl != null
  //             ? Image.network(
  //           coverUrl,
  //           fit: BoxFit.cover,
  //           errorBuilder: (context, error, stackTrace) => Image.asset(
  //             isProductStore ? AppImages.storeCoverImage : AppImages.serviceDetailsImage,
  //             fit: BoxFit.cover,
  //           ),
  //         )
  //             : Image.asset(
  //           isProductStore ? AppImages.storeCoverImage : AppImages.serviceDetailsImage,
  //           fit: BoxFit.cover,
  //         ),
  //       ),
  //
  //       // কাস্টম ব্যাক বাটন
  //       Positioned(
  //         top: 40.h,
  //         left: 16.w,
  //         child: GestureDetector(
  //           onTap: () => Get.back(),
  //           child: Container(
  //             height: 30.h,
  //             width: 30.w,
  //             padding: EdgeInsets.all(8.w),
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(12.r),
  //               color: Colors.white,
  //             ),
  //             child: const Center(
  //               child: Icon(Icons.arrow_back, color: Colors.black, size: 18),
  //             ),
  //           ),
  //         ),
  //       ),
  //
  //       // কাস্টম বুকমার্ক বাটন
  //       Positioned(
  //         top: 40.h,
  //         right: 16.w,
  //         child: Container(
  //           padding: EdgeInsets.all(8.w),
  //           decoration: BoxDecoration(
  //             color: const Color(0xFF000000).withValues(alpha: 0.2),
  //             shape: BoxShape.circle,
  //           ),
  //           child: const Icon(Icons.bookmark_border, color: Colors.white),
  //         ),
  //       ),
  //
  //       // স্টোর লোগো এবং নাম
  //       Positioned(
  //         top: 140.h,
  //         left: 16.w,
  //         right: 16.w,
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Container(
  //               padding: EdgeInsets.all(4.w),
  //               decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.circular(12.r),
  //               ),
  //               child: logoUrl != null
  //                   ? Image.network(
  //                 logoUrl,
  //                 width: 70.w,
  //                 height: 70.w,
  //                 fit: BoxFit.cover,
  //                 errorBuilder: (context, error, stackTrace) => Image.asset(
  //                   isProductStore ? AppImages.leLogo : AppImages.store_logo,
  //                   width: 70.w,
  //                   height: 70.w,
  //                 ),
  //               )
  //                   : Image.asset(
  //                 isProductStore ? AppImages.leLogo : AppImages.store_logo,
  //                 width: 70.w,
  //                 height: 70.w,
  //               ),
  //             ),
  //             SizedBox(height: 8.h),
  //             Text(
  //               storeData?.displayName ?? "LE REVE",
  //               style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
  //             ),
  //             Text(
  //               "${storeData?.storeType ?? 'Fashion'} • ${storeData?.averageRating ?? 4.9} (${storeData?.ratingCount ?? 1247} reviews)",
  //               style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }


  Widget _buildHeaderSection(storeData, bool isProductStore) {
    final String? coverUrl = storeData?.coverImage != null && storeData!.coverImage!.isNotEmpty
        ? (storeData.coverImage!.startsWith('http')
        ? storeData.coverImage!
        : "${ApiEndPoint.imageUrl}${storeData.coverImage!}")
        : null;
    final String? logoUrl = storeData?.logo != null && storeData!.logo!.isNotEmpty
        ? (storeData.logo!.startsWith('http')
        ? storeData.logo!
        : "${ApiEndPoint.imageUrl}${storeData.logo!}")
        : null;
    final double avgRating = (storeData?.averageRating ?? 0).toDouble();
    final int ratingCount = storeData?.ratingCount ?? 0;
    final String countryName = storeData?.cityId?.country ?? "";
    final String storeType = storeData?.storeType ?? 'Fashion';
    final String subtitleText = countryName.isNotEmpty
        ? "$storeType • $avgRating ($ratingCount reviews) • $countryName"
        : "$storeType • $avgRating ($ratingCount reviews)";
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 180.h,
          child: coverUrl != null
              ? Image.network(
            coverUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Image.asset(
              isProductStore ? AppImages.storeCoverImage : AppImages.serviceDetailsImage,
              fit: BoxFit.cover,
            ),
          )
              : Image.asset(
            isProductStore ? AppImages.storeCoverImage : AppImages.serviceDetailsImage,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 40.h,
          left: 16.w,
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              height: 30.h,
              width: 30.w,
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: Colors.white,
              ),
              child: const Center(
                child: Icon(Icons.arrow_back, color: Colors.black, size: 18),
              ),
            ),
          ),
        ),
        Positioned(
          top: 40.h,
          right: 16.w,
          child: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: const Color(0xFF000000).withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.bookmark_border, color: Colors.white),
          ),
        ),
        Positioned(
          top: 140.h,
          left: 16.w,
          right: 16.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: logoUrl != null
                    ? Image.network(
                  logoUrl,
                  width: 70.w,
                  height: 70.w,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                    isProductStore ? AppImages.leLogo : AppImages.store_logo,
                    width: 70.w,
                    height: 70.w,
                  ),
                )
                    : Image.asset(
                  isProductStore ? AppImages.leLogo : AppImages.store_logo,
                  width: 70.w,
                  height: 70.w,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                storeData?.displayName ?? "LE REVE",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 2.h),
              Text(
                subtitleText,
                style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    );
  }


}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);
  final TabBar _tabBar;
  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;
  @override
  Widget build(context, shrinkOffset, overlapsContent) =>
      Container(color: Colors.white, child: _tabBar);
  @override
  bool shouldRebuild(oldDelegate) => false;
}