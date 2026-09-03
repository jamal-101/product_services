import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/features/message_flow/screen/message_screen.dart';
import '../../../../../component/bottom_navBar/nav_bar..dart';
import '../../../../../services/api/api_service.dart';
import '../../../../../utils/constants/api_enpoint.dart';
import '../../../../../utils/constants/app_images.dart';
import '../../../../home_flow/presentatin/screen/notification_screen.dart';
import '../../../../message_flow/presentation/controller/message_controller.dart';
import '../../../../post_add/controller/post_add_controller.dart';
import '../../../../profile_section/presentation/widget/app_drawer.dart';
import '../controller/seller_home_controller.dart';

class SellerHomeScreen extends StatelessWidget {
  const SellerHomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final SellerHomeController controller = Get.put(SellerHomeController());
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      drawer: const AppDrawer(),
      bottomNavigationBar: BottomNavBar(selectedIndex: 0),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset(AppImages.menuIcon, height: 24.h, width: 24.w),
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
            final response = await ApiService.get(ApiEndPoint.superAdmin); // আপনার এপিআই এন্ডপয়েন্ট অনুযায়ী

            if (response.isSuccess) {
              var responseData = response.data;
              String superAdminId = responseData['data']['_id'] ?? ""; // সুপার এডমিনের _id

              if (superAdminId.isNotEmpty) {
                final MessageController messageController = Get.put(MessageController());

                // সাপোর্ট চ্যাট ক্রিয়েট করা হচ্ছে
                messageController.createChat(
                  participantId: superAdminId, // সুপার এডমিনের _id
                  communicationType: "support", // টাইপ সাপোর্ট হবে
                  referenceId: "", // সাপোর্ট চ্যাটে referenceId খালি থাকবে
                  shopName: "Support",
                );
              } else {
                Get.snackbar("Error", "Super Admin ID not found", backgroundColor: Colors.red, colorText: Colors.white);
              }
            } else {
              Get.snackbar("Error", response.message, backgroundColor: Colors.red, colorText: Colors.white);
            }
          } catch (e) {
            Get.snackbar("Error", e.toString(), backgroundColor: Colors.red, colorText: Colors.white);
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                _buildStatCard("Total Items Listed", "4"),
                const SizedBox(width: 16),
                _buildStatCard("Store Visitors (week)", "428"),
              ],
            ),
            _buildAdvertiseCard(),
            const SizedBox(height: 16),
            _buildTrafficAnalyticsChart(controller),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(color: Colors.grey, fontSize: 11),
            ),
            const SizedBox(height: 5),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrafficAnalyticsChart(SellerHomeController controller) {
    return Obx(() {
      if (controller.isDashboardLoading.value) {
        return Container(
          height: 250,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Center(
            child: CircularProgressIndicator(color: Color(0xFF27AE60)),
          ),
        );
      }
      final trafficList = controller.dashboardData.value.data?.weeklyTraffic ?? [];
      final spots = trafficList.asMap().entries.map((entry) {
        int index = entry.key;
        var traffic = entry.value;
        return FlSpot(index.toDouble(), (traffic.count ?? 0).toDouble());
      }).toList();

      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Weekly Traffic Analytics",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "This Week",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: const Color(0xFF1E293B),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "Simulated daily page requests",
              style: GoogleFonts.poppins(color: Colors.grey, fontSize: 11),
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 100,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: Colors.grey.shade100,
                      strokeWidth: 1,
                      dashArray: [5, 5],
                    ),
                  ),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          int index = value.toInt();
                          String dayLabel = '';
                          if (index >= 0 && index < trafficList.length) {
                            dayLabel = trafficList[index].day ?? '';
                          }
                          return Padding(
                            padding: EdgeInsets.only(top: 8.sp),
                            child: Text(
                              dayLabel,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1A1D24),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (value, meta) => Text(
                          value.toInt().toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots.isNotEmpty ? spots : [const FlSpot(0, 0)],
                      isCurved: true,
                      color: const Color(0xFF27AE60),
                      barWidth: 4,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) =>
                            FlDotCirclePainter(
                              radius: 4,
                              color: Colors.white,
                              strokeWidth: 3,
                              strokeColor: const Color(0xFF27AE60),
                            ),
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        color: const Color(0xFF27AE60).withValues(alpha: 0.15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
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
              final PostAddController postController = Get.put(PostAddController());
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
