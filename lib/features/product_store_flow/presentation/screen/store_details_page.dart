import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../utils/constants/api_enpoint.dart';
import '../../../../utils/constants/app_images.dart';
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
    String passedStoreType = "";

    if (argument is Map<String, dynamic>) {
      storeId = argument['storeId'] ?? "";
      passedStoreType = argument['storeType'] ?? "";
    } else if (argument is String) {
      storeId = argument;
    }




    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (storeId.isNotEmpty) {
        final currentLoadedStoreId = controller.storeDetailsModel.value.data?.store?.sId;
        if (currentLoadedStoreId != storeId) {
          controller.clearData();
          controller.fetchStoreDetails(storeId);
        }
      }
    });

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value &&
            controller.storeDetailsModel.value.data == null) {
          return _buildShimmerLoader();
        }

        final storeData = controller.storeDetailsModel.value.data?.store;
        final String rawStoreType = storeData?.storeType ?? passedStoreType;
        final bool isProductStore = rawStoreType.toLowerCase().contains('product');

        return DefaultTabController(
          length: 3,
          child: NestedScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                expandedHeight: 280.h,
                pinned: true,
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: _buildHeaderSection(
                    controller.storeDetailsModel.value.data,
                    isProductStore,
                    controller,
                    rawStoreType,
                  ),
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
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              isProductStore
                                  ? Icons.inventory_2_outlined
                                  : Icons.design_services_outlined,
                              size: 18.sp,
                            ),
                            SizedBox(width: 6.w),
                            Text(isProductStore ? "Products" : "Services"),
                          ],
                        ),
                      ),
                      const Tab(text: "About"),
                      const Tab(text: "Reviews"),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ],
            body: TabBarView(
              physics: ClampingScrollPhysics(),
              children: [
                ProductsWidget(),
                AboutWidget(),
                ReviewsWidget(storeId: storeId),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildShimmerLoader() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 180.h,
              width: double.infinity,
              color: Colors.white,
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 80.w,
                        height: 80.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(width: 150.w, height: 16.h, color: Colors.white),
                          SizedBox(height: 8.h),
                          Container(width: 100.w, height: 12.h, color: Colors.white),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Container(width: double.infinity, height: 14.h, color: Colors.white),
                  SizedBox(height: 10.h),
                  Container(width: 200.w, height: 14.h, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection(storeData, bool isProductStore,StoreDetailsController controller, String rawStoreType) {
    final store = storeData?.store;

    final String? coverUrl =
    store?.coverImage != null && store!.coverImage!.isNotEmpty
        ? (store.coverImage!.startsWith('http')
        ? store.coverImage!
        : "${ApiEndPoint.imageUrl}${store.coverImage!}")
        : null;

    final String? logoUrl = store?.logo != null && store!.logo!.isNotEmpty
        ? (store.logo!.startsWith('http')
        ? store.logo!
        : "${ApiEndPoint.imageUrl}${store.logo!}")
        : null;

    final double avgRating = (store?.averageRating ?? 0).toDouble();
    final int ratingCount = store?.ratingCount ?? 0;

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
              isProductStore
                  ? AppImages.storeCoverImage
                  : AppImages.serviceDetailsImage,
              fit: BoxFit.cover,
            ),
          )
              : Image.asset(
            isProductStore
                ? AppImages.storeCoverImage
                : AppImages.serviceDetailsImage,
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
          child: GestureDetector(
            onTap: () {
              final storeItem = storeData?.store;
              if (storeItem?.sId != null) {
                controller.toggleFavorite(storeItem!.sId!, rawStoreType);
              }
            },
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: const Color(0xFF000000).withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Obx(() => Icon(
                controller.isFavorite.value ? Icons.bookmark : Icons.bookmark_border,
                color: Colors.white,
              )),
            ),
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
                width: 80.w,
                height: 80.w,
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF000000).withValues(alpha: 0.12),
                      offset: const Offset(0, 4),
                      blurRadius: 16,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: logoUrl != null
                      ? Image.network(
                    logoUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Image.asset(
                          isProductStore
                              ? AppImages.leLogo
                              : AppImages.store_logo,
                          fit: BoxFit.cover,
                        ),
                  )
                      : Image.asset(
                    isProductStore
                        ? AppImages.leLogo
                        : AppImages.store_logo,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              SizedBox(height: 8.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    store?.displayName ?? "Store Name",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    store?.categoryId?.name ?? "Category",
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),

              Row(
                children: [
                  const Icon(Icons.star, color: Colors.orange, size: 18),
                  SizedBox(width: 4.w),

                  Text(
                    "$avgRating ($ratingCount reviews)",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14.sp,
                      color: const Color(0xFF7A818F),
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  Text(
                    "  •  ",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 10.sp,
                      color: const Color(0xFF7A818F),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Icon(
                    Icons.location_on_outlined,
                    color: Colors.grey,
                    size: 18,
                  ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: Text(
                      store?.cityId?.city != null &&
                          store?.cityId?.country != null
                          ? "${store!.cityId!.city}, ${store.cityId!.country}"
                          : "Location not available",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14.sp,
                        color: const Color(0xFF7A818F),
                        fontWeight: FontWeight.w400,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
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