import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/features/home_flow/presentatin/controller/home_controller.dart';
import 'package:product_service/utils/constants/api_enpoint.dart';
import 'package:product_service/utils/constants/app_color.dart';
import 'package:product_service/utils/constants/app_images.dart';
import '../../../../component/bottom_navBar/nav_bar..dart';
import '../../../../services/api/api_service.dart';
import '../../../message_flow/presentation/controller/message_controller.dart';
import '../../../post_add/controller/post_add_controller.dart';
import '../../../product_store_flow/presentation/screen/store_details_page.dart';
import '../../../profile_section/presentation/widget/app_drawer.dart';
import '../model/city_model.dart';
import '../../../notification/presentaiton/screen/notification_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final HomeController controller = Get.put(HomeController());
    return Scaffold(
      key: scaffoldKey,
      drawer: AppDrawer(),
      bottomNavigationBar: BottomNavBar(selectedIndex: 0),
      appBar: AppBar(
        backgroundColor: AppColor.appBackgroundColor,
        surfaceTintColor: AppColor.appBackgroundColor,
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
        onPressed: () async {
          try {
            final response = await ApiService.get(
              ApiEndPoint.superAdmin,
            );
            if (response.isSuccess) {
              var responseData = response.data;
              String superAdminId =
                  responseData['data']['_id'] ?? "";
              if (superAdminId.isNotEmpty) {
                final MessageController messageController = Get.put(
                  MessageController(),
                );
                messageController.createChat(
                  participantId: superAdminId,
                  communicationType: "support",
                  referenceId: "",
                  shopName: "Support",
                );
              } else {
                Get.snackbar(
                  "Error",
                  "Super Admin ID not found",
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              }
            } else {
              Get.snackbar(
                "Error",
                response.message,
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
            }
          } catch (e) {
            Get.snackbar(
              "Error",
              e.toString(),
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }
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
                border: Border.all(width: 3.w, color: Color(0xFFFFFFFF)),
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
                child: Image.asset(
                  AppImages.floatingIcon,
                  height: 12.h,
                  width: 12.w,
                ),
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
                            image:
                                banner.image != null && banner.image!.isNotEmpty
                                ? DecorationImage(
                                    image: NetworkImage(
                                      "${ApiEndPoint.imageUrl}${banner.image}",
                                    ),
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
                              width:
                                  controller.currentBannerIndex.value == index
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
                );
              }),
            ),
            SizedBox(height: 16.h),
            _buildAdvertiseCard(),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Featured Stores",
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1D24),
                    fontSize: 18.sp,
                  ),
                ),
                _buildCitySelectionBox(controller),
              ],
            ),
            SizedBox(height: 10.h),
            Obx(() {
              if (controller.isFeaturedLoading.value) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: const CircularProgressIndicator(
                      color: Color(0xFF27AE60),
                    ),
                  ),
                );
              }
              if (controller.featuredList.isEmpty) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: Text(
                      "No Featured Stores Found",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.featuredList.length,
                itemBuilder: (context, index) {
                  final item = controller.featuredList[index];
                  String imageUrl = "";
                  if (item.featuredImage != null &&
                      item.featuredImage!.isNotEmpty) {
                    if (item.featuredImage!.startsWith('http')) {
                      imageUrl = item.featuredImage!;
                    } else {
                      imageUrl = "${ApiEndPoint.imageUrl}${item.featuredImage}";
                    }
                  }
                  String? storeId = item.storeId?.sId;
                  String storeType = item.storeId?.storeType ?? "";

                  return GestureDetector(
                    onTap: () {
                      if (storeId != null && storeId.isNotEmpty) {
                        Get.to(
                          () => const ProductDetailsScreen(),
                          arguments: {
                            'storeId': storeId,
                            'storeType': storeType,
                          },
                        );
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 12.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: Colors.grey.shade200),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (imageUrl.isNotEmpty)
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16.r),
                              ),
                              child: Image.network(
                                imageUrl,
                                height: 150.h,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                      height: 150.h,
                                      color: Colors.grey.shade200,
                                      child: const Icon(
                                        Icons.image_not_supported,
                                        color: Colors.grey,
                                      ),
                                    ),
                              ),
                            ),
                          Padding(
                            padding: EdgeInsets.all(12.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.campaignName ?? "No Campaign Name",
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  "Store: ${item.storeId?.displayName?.isNotEmpty == true ? item.storeId!.displayName : "N/A"} (${item.city ?? ""})",
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 12.sp,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  "Price: \$${item.price ?? 0}",
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF27AE60),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildCitySelectionBox(HomeController controller) {
    return Align(
      alignment: Alignment.centerRight,
      child: Obx(() {
        if (controller.isCityLoading.value) {
          return SizedBox(
            height: 20.h,
            width: 20.w,
            child: const CircularProgressIndicator(
              strokeWidth: 2,
              color: Color(0xFF2E7D32),
            ),
          );
        }

        return PopupMenuButton<CityData>(
          onSelected: (CityData cityData) {
            controller.onCitySelected(cityData);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          itemBuilder: (BuildContext context) => <PopupMenuEntry<CityData>>[
            PopupMenuItem<CityData>(
              value: CityData(
                city: "Choose city",
                latitude: null,
                longitude: null,
              ),
              child: const Text('Choose city'),
            ),
            ...controller.cityList.map((city) {
              return PopupMenuItem<CityData>(
                value: city,
                child: Text(city.city ?? ""),
              );
            }).toList(),
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
                Icon(
                  Icons.location_on_outlined,
                  size: 18.sp,
                  color: const Color(0xFF2E7D32),
                ),
                SizedBox(width: 6.w),
                Text(
                  controller.selectedCityName.value,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 18.sp,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildAdvertiseCard({VoidCallback? onTap}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: 8.h),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFFE7FCF0), Color(0xFFFFFFFF)],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ],
        border: Border.all(color: Color(0xFFF3F4F6), width: 1.11),
      ),
      child: Row(
        children: [
          Image.asset(AppImages.add_icon, height: 60.h, width: 60.w),
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
            onPressed:
                onTap ??
                () {
                  final PostAddController postController = Get.put(
                    PostAddController(),
                  );
                  postController.checkAndNavigateToPostAd();
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
