import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/config/route/app_route.dart';
import 'package:product_service/features/home_flow/presentatin/controller/home_controller.dart';
import 'package:product_service/features/home_flow/presentatin/screen/features_stories_screen.dart';
import 'package:product_service/features/message_flow/screen/message_screen.dart';
import 'package:product_service/utils/constants/app_images.dart';
import 'package:product_service/utils/constants/app_string.dart';
import '../../../../component/bottom_navBar/nav_bar..dart';
import '../../../profile_section/presentation/widget/app_drawer.dart';
import 'notification_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final HomeController controller = Get.put(HomeController());
    return Scaffold(
      key: scaffoldKey,
      drawer: const AppDrawer(),
      bottomNavigationBar: BottomNavBar(selectedIndex: 0),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset(AppImages.menuIcon, height: 30.h, width: 30.w),
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: Image.asset(
          AppImages.home_center_icon,
          height: 180.h,
          width: 180.w,
          fit: BoxFit.contain,
        ),
        actions: [
          IconButton(
            icon: Image.asset(
              AppImages.homeNotificationIcon,
              height: 35.h,
              width: 35.w,
            ),
            onPressed: () => Get.to(() => const NotificationScreen()),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(MessageScreen());
        },
        backgroundColor: Colors.transparent,
        elevation: 0,
        highlightElevation: 0,
        shape: const CircleBorder(),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 90.r,
              width: 90.r,
              decoration: BoxDecoration(
                color: const Color(0xFF27AE60),
                shape: BoxShape.circle,
                border: Border.all(width: 3.w,color: Color(0xFFFFFFFF)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(AppImages.floatingIcon,height: 12.h,width: 12.w),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                height: 18.r,
                width: 18.r,
                decoration: BoxDecoration(
                  color: const Color(0xFFF44336),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3.w),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            SizedBox(
              height: 140.h,
              child: Stack(
                children: [
                  PageView.builder(
                    controller: controller.bannerPageController,
                    onPageChanged: (index) =>
                        controller.currentBannerIndex.value = index,
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
                                  Text(
                                    "Hisense",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "OFFICIAL SPONSOR",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    "Innovating for a Brighter Life",
                                    style: TextStyle(
                                      color: Colors.cyanAccent,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.emoji_events,
                              size: 60,
                              color: Colors.amber,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 10.h,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        3,
                        (index) => Obx(
                          () => Container(
                            margin: EdgeInsets.symmetric(horizontal: 3.w),
                            width: controller.currentBannerIndex.value == index
                                ? 12.w
                                : 6.w,
                            height: 6.h,
                            decoration: BoxDecoration(
                              color:
                                  controller.currentBannerIndex.value == index
                                  ? Colors.white
                                  : Colors.white54,
                              borderRadius: BorderRadius.circular(3.r),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            _buildAdvertiseCard(),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       "Browse Categories",
            //       style: TextStyle(
            //         fontSize: 16.sp,
            //         fontWeight: FontWeight.bold,
            //         color: Colors.black54,
            //       ),
            //     ),
            //     TextButton(
            //       onPressed: () => Get.to(() => CategoriesScreen()),
            //       child: const Text(
            //         "See All",
            //         style: TextStyle(color: Color(0xFF27AE60)),
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(
            //   height: 85.h,
            //   child: ListView(
            //     scrollDirection: Axis.horizontal,
            //     physics: const BouncingScrollPhysics(),
            //     children: [
            //       _buildCategoryItem(Icons.electric_bolt, "Electronics"),
            //       _buildCategoryItem(Icons.checkroom, "Fashion"),
            //       _buildCategoryItem(
            //         Icons.king_bed_outlined,
            //         "Home & \nLiving",
            //       ),
            //       _buildCategoryItem(Icons.brush_outlined, "Beauty"),
            //       _buildCategoryItem(Icons.sports_soccer, "Sports"),
            //       _buildCategoryItem(Icons.camera, "Toys and \nGames"),
            //     ],
            //   ),
            // ),
            // SizedBox(height: 10.h),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       AppString.featuredStores,
            //       style: GoogleFonts.plusJakartaSans(
            //         fontSize: 16.sp,
            //         fontWeight: FontWeight.bold,
            //         color: Colors.black54,
            //       ),
            //     ),
            //     TextButton(
            //       onPressed: () {
            //         Get.to(FeaturesStoriesScreen());
            //       },
            //       child: Text(
            //         AppString.seeAll,
            //         style: GoogleFonts.plusJakartaSans(color: Color(0xFF27AE60)),
            //       ),
            //     ),
            //   ],
            // ),
            // _buildStoreCard(
            //   AppString.anyTime,
            //   AppString.electronics,
            //   Color(0xFFE67E22),
            //   false,
            // ),
            // _buildStoreCard(
            //   "Healixir",
            //   "Electronics • Barcelona",
            //   const Color(0xFF16A085),
            //   true,
            // ),
            // _buildStoreCard(
            //   "Cocacole",
            //   "Food • Barcelona",
            //   const Color(0xFFC0392B),
            //   false,
            // ),
            // SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  // Widget _buildCategoryItem(IconData icon, String title) {
  //   return Padding(
  //     padding: EdgeInsets.only(right: 16.w),
  //     child: Column(
  //       children: [
  //         CircleAvatar(
  //           radius: 24.r,
  //           backgroundColor: Colors.white,
  //           child: Icon(icon, color: Colors.black54, size: 20),
  //         ),
  //         SizedBox(height: 6.h),
  //         Text(
  //           title,
  //           style: TextStyle(fontSize: 11.sp, color: Colors.black54),
  //         ),
  //       ],
  //     ),
  //   );
  // }


  Widget _buildAdvertiseCard({VoidCallback? onTap}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: 8.h),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFFE7FCF0),
            Color(0xFFFFFFFF),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ],
        border: Border.all(color: const Color(0xFFF3F4F6), width: 1.11),
      ),
      child: Row(
        children: [
          // Container(
          //   width: 50.w,
          //   height: 50.h,
          //   decoration: BoxDecoration(
          //     shape: BoxShape.circle,
          //     border: Border.all(color: const Color(0xFF2E7D32), width: 1.5),
          //   ),
          //   child: Icon(
          //     Icons.campaign_outlined,
          //     color: const Color(0xFF2E7D32),
          //     size: 26.sp,
          //   ),
          // ),
          Image.asset(AppImages.add_icon,height: 60.h,width: 60.w,),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Post Your Ad Here",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2E7D32),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "Reach more customers today",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: onTap ?? () {
              Get.toNamed(AppRoutes.advertiseWithUs);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF228B22),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.campaign_outlined, size: 20.sp, color: Colors.white),
                SizedBox(width: 6.w),
                Text(
                  "Advertise Here",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoreCard(
    String title,
    String subtitle,
    Color logoBg,
    bool isBookmarked,
   ) {
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
            decoration: BoxDecoration(
              color: logoBg,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: const Icon(Icons.store_mall_directory, color: Colors.white),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, color: Colors.grey),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Color(0xFFFFF9E6),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 14),
                    SizedBox(width: 2.w),
                    Text(
                      "4.9",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber[800],
                      ),
                    ),
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
          ),
        ],
      ),
    );
  }
}
