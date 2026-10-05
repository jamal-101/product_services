import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/component/bottom_navBar/App_scaffold.dart';
import '../../../../../component/bottom_navBar/nav_bar..dart';
import '../../../../../utils/constants/api_enpoint.dart';
import '../../../../../utils/constants/app_images.dart';
import '../controller/my_store_controller.dart';
import '../widget/about_widget_me.dart';
import '../widget/product_widget_me.dart';
import '../widget/rivew_widget_me.dart';

class MyStoreScreen extends StatelessWidget {
  const MyStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MyStoreController controller = Get.put(MyStoreController());
    return AppScaffold(
      selectedIndex: 2,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator(color: Color(0xFFE67E22)));
        }

        final bool isProductStore = controller.isProductStore.value;

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
                  background: _buildHeaderSection(context, controller),
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
              physics: const ClampingScrollPhysics(),
              children: [
                const ProductsWidgetMe(),
                const AboutWidgetMe(),
                ReviewsWidgetMe(storeId: controller.myStoreModel.value?.data?.sId ?? ""),
              ],
            ),
          ),
        );
      }),
      // bottomNavigationBar: BottomNavBar(selectedIndex: 2),
    );
  }

  Widget _buildHeaderSection(BuildContext context, MyStoreController controller) {
    final storeData = controller.myStoreModel.value?.data;
    final bool isProductStore = controller.isProductStore.value;

    String name = storeData?.displayName ?? "Store Name";
    String category = storeData?.categoryId?.name ?? "Category";
    double rating = storeData?.averageRating ?? 0.0;
    int ratingCount = storeData?.ratingCount ?? 0;
    String location = storeData?.cityId?.city ?? "Location";
    String? coverImgPath = storeData?.coverImage;
    String? logoImgPath = storeData?.logo;

    String coverImageUrl = (coverImgPath != null && coverImgPath.isNotEmpty)
        ? (coverImgPath.startsWith('http') ? coverImgPath : '${ApiEndPoint.imageUrl}$coverImgPath')
        : "";
    String logoImageUrl = (logoImgPath != null && logoImgPath.isNotEmpty)
        ? (logoImgPath.startsWith('http') ? logoImgPath : '${ApiEndPoint.imageUrl}$logoImgPath')
        : "";
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 180.h,
          child: coverImageUrl.isNotEmpty
              ? Image.network(
            coverImageUrl,
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
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: logoImageUrl.isNotEmpty
                      ? Image.network(
                    logoImageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                      isProductStore ? AppImages.leLogo : AppImages.store_logo,
                      fit: BoxFit.cover,
                    ),
                  )
                      : Image.asset(
                    isProductStore ? AppImages.leLogo : AppImages.store_logo,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    category,
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
                    "$rating ($ratingCount reviews)",
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
                      location,
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