import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../component/bottom_navBar/nav_bar..dart';
import '../../../profile_section/presentation/widget/app_drawer.dart';
import '../controller/home_controller.dart';
import 'notification_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      backgroundColor: const Color(0xFFFBFBFB),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 0,
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 32.w,
              height: 32.h,
              decoration: BoxDecoration(
                color: const Color(0xFF27AE60),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: const Icon(Icons.grid_view_rounded, color: Colors.white, size: 18),
            ),
            SizedBox(width: 8.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("PRODUCTOS", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.green)),
                Text("Y SERVICIOS", style: TextStyle(fontSize: 10.sp, color: Colors.orange, height: 0.8)),
              ],
            )
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined, color: Colors.black),
            onPressed: () => Get.to(() => const NotificationScreen()),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF27AE60),
        shape: const CircleBorder(),
        child: const Icon(Icons.support_agent, color: Colors.white, size: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            // GestureDetector(
            //   onTap: () => Get.toNamed(AppRoutes.searchScreen),
            //   child: Container(
            //     padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(25.r),
            //       border: Border.all(color: const Color(0xFFECECF0)),
            //     ),
            //     child: Row(
            //       children: [
            //         const Icon(Icons.search, color: Colors.grey),
            //         SizedBox(width: 8.w),
            //         Text(
            //           "What would you like to buy?",
            //           style: TextStyle(color: Colors.grey, fontSize: 14.sp),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // SizedBox(height: 20.h),

            // 🎚️ ব্যানার স্লাইডার (PageView)
            SizedBox(
              height: 140.h,
              child: Stack(
                children: [
                  PageView.builder(
                    controller: controller.bannerPageController,
                    onPageChanged: (index) => controller.currentBannerIndex.value = index,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 2.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF005C97), Color(0xFF363795)],
                          ),
                        ),
                        padding: EdgeInsets.all(16.w),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Hisense", style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold)),
                                  Text("OFFICIAL SPONSOR", style: TextStyle(color: Colors.white70, fontSize: 10.sp)),
                                  SizedBox(height: 8.h),
                                  Text("Innovating for a Brighter Life", style: TextStyle(color: Colors.cyanAccent, fontSize: 12.sp, fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                            const Icon(Icons.emoji_events, size: 60, color: Colors.amber),
                          ],
                        ),
                      );
                    },
                  ),
                  // স্লাইডার ডট ইন্ডিকেটর
                  Positioned(
                    bottom: 10.h,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (index) => Obx(() => Container(
                        margin: EdgeInsets.symmetric(horizontal: 3.w),
                        width: controller.currentBannerIndex.value == index ? 12.w : 6.w,
                        height: 6.h,
                        decoration: BoxDecoration(
                          color: controller.currentBannerIndex.value == index ? Colors.white : Colors.white54,
                          borderRadius: BorderRadius.circular(3.r),
                        ),
                      ))),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20.h),

            // 📁 ক্যাটাগরি সেকশন হেডার
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Browse Categories", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.black54)),
                TextButton(
                  // onPressed: () => Get.to(() => const CategoriesScreen()),
                  onPressed: (){},
                  child: const Text("See All", style: TextStyle(color: Color(0xFF27AE60))),
                ),
              ],
            ),

            // ক্যাটাগরি হরিজন্টাল লিস্ট
            SizedBox(
              height: 85.h,
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                children: [
                  _buildCategoryItem(Icons.electric_bolt, "Electronics"),
                  _buildCategoryItem(Icons.checkroom, "Fashion"),
                  _buildCategoryItem(Icons.king_bed_outlined, "Home & \nLiving"),
                  _buildCategoryItem(Icons.brush_outlined, "Beauty"),
                  _buildCategoryItem(Icons.sports_soccer, "Sports"),
                  _buildCategoryItem(Icons.camera, "Toys and \nGames"),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Featured Stores", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.black54)),
                TextButton(
                  onPressed: () {},
                  child: const Text("See All", style: TextStyle(color: Color(0xFF27AE60))),
                ),
              ],
            ),
            _buildStoreCard("Anytime", "Electronics • Barcelona", const Color(0xFFE67E22), false),
            _buildStoreCard("Healixir", "Electronics • Barcelona", const Color(0xFF16A085), true),
            _buildStoreCard("Cocacole", "Food • Barcelona", const Color(0xFFC0392B), false),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(IconData icon, String title) {
    return Padding(
      padding: EdgeInsets.only(right: 16.w),
      child: Column(
        children: [
          CircleAvatar(
            radius: 24.r,
            backgroundColor: Colors.white,
            child: Icon(icon, color: Colors.black54, size: 20),
          ),
          SizedBox(height: 6.h),
          Text(title, style: TextStyle(fontSize: 11.sp, color: Colors.black54)),
        ],
      ),
    );
  }

  // --- 🏬 হেল্পার উইজেট: স্টোর কার্ড ---
  Widget _buildStoreCard(String title, String subtitle, Color logoBg, bool isBookmarked) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFECECF0)),
      ),
      child: Row(
        children: [
          Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(color: logoBg, borderRadius: BorderRadius.circular(8.r)),
            child: const Icon(Icons.store_mall_directory, color: Colors.white),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold)),
                SizedBox(height: 4.h),
                Text(subtitle, style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(color: const Color(0xFFFFF9E6), borderRadius: BorderRadius.circular(12.r)),
                child: Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 14),
                    SizedBox(width: 2.w),
                    Text("4.9", style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.amber[800])),
                  ],
                ),
              ),
              SizedBox(height: 8.h),
              Icon(
                isBookmarked ? Icons.bookmark : Icons.bookmark_border_outlined,
                color: isBookmarked ? Colors.orange : Colors.grey,
                size: 20,
              ),
            ],
          )
        ],
      ),
    );
  }
}