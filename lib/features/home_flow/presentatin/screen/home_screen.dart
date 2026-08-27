import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/config/route/app_route.dart';
import 'package:product_service/features/home_flow/presentatin/controller/home_controller.dart';
import 'package:product_service/features/message_flow/screen/message_screen.dart';
import 'package:product_service/utils/constants/api_enpoint.dart';
import 'package:product_service/utils/constants/app_images.dart';
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
      drawer:  AppDrawer(),
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

            SizedBox(
              height: 140.h,
              child: Obx(() {

                if (controller.bannerList.isEmpty) {
                  return const Center(child: Text("No banners found"));
                }

                return Stack(
                  children: [
                    PageView.builder(
                      controller: controller.bannerPageController,
                      onPageChanged: (index) =>
                      controller.currentBannerIndex.value = index,
                      itemCount: controller.bannerList.length,
                      itemBuilder: (context, index) {
                        final banner = controller.bannerList[index];
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 2.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: Colors.grey[900],

                            image: banner.image != null && banner.image!.isNotEmpty
                                ? DecorationImage(
                              image: NetworkImage("${ApiEndPoint.imageUrl}${banner.image}"),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                Colors.black.withValues(alpha: 0.3),
                                BlendMode.darken,
                              ),
                            )
                                : null,
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
                                      banner.name ?? "",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 6.h),
                                    Text(
                                      banner.description ?? "",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                  ],
                                ),
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
                          controller.bannerList.length,
                              (index) => Obx(
                                () => Container(
                              margin: EdgeInsets.symmetric(horizontal: 3.w),
                              width: controller.currentBannerIndex.value == index
                                  ? 12.w
                                  : 6.w,
                              height: 6.h,
                              decoration: BoxDecoration(
                                color: controller.currentBannerIndex.value == index
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
                );
              }),
            ),

            SizedBox(height: 16.h),
            _buildCitySelectionBox(controller),
            _buildAdvertiseCard(),
            SizedBox(height: 10.h),
            Image.asset(AppImages.addImage_1),
            SizedBox(height: 5.h),
            Image.asset(AppImages.addImage_2)
          ],
        ),
      ),
    );
  }

  Widget _buildCitySelectionBox(HomeController controller) {
    final RxString selectedCity = "Choose city".obs;
    return Align(
      alignment: Alignment.centerRight,
      child: PopupMenuButton<String>(
        onSelected: (String city) {
          selectedCity.value = city;
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: 'Choose city',
            child: Text('Choose city'),
          ),
          const PopupMenuItem<String>(
            value: 'Geneva',
            child: Text('Geneva'),
          ),
          const PopupMenuItem<String>(
            value: 'Zurich',
            child: Text('Zurich'),
          ),
          const PopupMenuItem<String>(
            value: 'Madrid',
            child: Text('Madrid'),
          ),
          const PopupMenuItem<String>(
            value: 'Barcelona',
            child: Text('Barcelona'),
          ),
        ],
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: Colors.grey.shade300, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.location_on_outlined, size: 18.sp, color: const Color(0xFF2E7D32)),
              SizedBox(width: 6.w),
              Obx(() => Text(
                  selectedCity.value,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Icon(Icons.keyboard_arrow_down, size: 18.sp, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdvertiseCard({VoidCallback? onTap}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: 8.h),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        gradient:  LinearGradient(
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
            offset:  Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ],
        border: Border.all(color:  Color(0xFFF3F4F6), width: 1.11),
      ),
      child: Row(
        children: [
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
}
