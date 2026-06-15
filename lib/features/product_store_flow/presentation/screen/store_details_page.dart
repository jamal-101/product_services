
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../../../../utils/constants/app_images.dart';
import '../widget/about_widget.dart';
import '../widget/products_widget.dart';
import '../widget/reviews.dart';

class StoreDetailsPage extends StatelessWidget {
  const StoreDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              expandedHeight: 280.h,
              pinned: true,
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              flexibleSpace: FlexibleSpaceBar(
                background: _buildHeaderSection(),
              ),
            ),
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: const Color(0xFFE67E22),
                  labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                  tabs: const [Tab(text: "Products"), Tab(text: "About"), Tab(text: "Reviews")],
                ),
              ),
              pinned: true,
            ),
          ],
          body: const TabBarView(
            children: [ProductsWidget(), AboutWidget(), ReviewsWidget()],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Stack(
      children: [
        // কভার ইমেজ
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 180.h,
          child: Image.asset(AppImages.storeCoverImage, fit: BoxFit.cover),
        ),

        // কাস্টম ব্যাক বাটন (ইমেজের ওপর)
        Positioned(
          top: 40.h, left: 16.w,
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              height: 30.h,
              width: 30.w,
              padding: EdgeInsets.all(8.w),
              decoration:  BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                  color: Colors.white,
    ),
              child: Center(child: const Icon(Icons.arrow_back, color: Colors.black,size: 18,)),
            ),
          ),
        ),

        // কাস্টম বুকমার্ক বাটন (ইমেজের ওপর)
        Positioned(
          top: 40.h, right: 16.w,
          child: Container(
            padding: EdgeInsets.all(8.w),
            decoration:  BoxDecoration(
                color: Color(0x000000).withValues(alpha: 0.2), shape: BoxShape.circle),
            child: const Icon(Icons.bookmark_border, color: Colors.white),
          ),
        ),

        // স্টোর লোগো এবং নাম (ওভারল্যাপিং অংশ)
        Positioned(
          top: 140.h, left: 16.w, right: 16.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r)),
                child: Image.asset(AppImages.leLogo, width: 70.w, height: 70.w),
              ),
              SizedBox(height: 8.h),
              Text("LE REVE", style: TextStyle(
                  fontSize: 20.sp, fontWeight: FontWeight.bold)),
              Text("Fashion • 4.9 (1,247 reviews) • Calle Gran Via 32, Madrid",
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey[600])),
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
  @override double get minExtent => _tabBar.preferredSize.height;
  @override double get maxExtent => _tabBar.preferredSize.height;
  @override Widget build(context, shrinkOffset, overlapsContent) => Container(color: Colors.white, child: _tabBar);
  @override bool shouldRebuild(oldDelegate) => false;
}