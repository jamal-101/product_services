import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/features/message_flow/screen/message_screen.dart';
import '../../../../../component/bottom_navBar/nav_bar..dart';
import '../../../../../utils/constants/app_images.dart';
import '../../../../home_flow/presentatin/screen/notification_screen.dart';
import '../../../../profile_section/presentation/widget/app_drawer.dart';

class SellerHomeScreen extends StatelessWidget {
  const SellerHomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      bottomNavigationBar: BottomNavBar(selectedIndex: 0),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset(AppImages.menuIcon, height: 24.h, width: 24.w),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
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
            const SizedBox(height: 16),
            _buildProfileCompletion(),
            const SizedBox(height: 16),
            _buildTrafficAnalyticsChart(),
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

  Widget _buildProfileCompletion() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFFA726).withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: Color(0xFFE67E22),
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Profile completion",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Text(
                "85%",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFE67E22),
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: 0.85,
              backgroundColor: const Color(0xFFE67E22).withValues(alpha: 0.1),
              color: const Color(0xFFE67E22),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 16),
          FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCheckItem("Basic Info"),
                _buildCheckItem("Logo & cover"),
                _buildCheckItem("Hours"),
                _buildCheckItem("Contact"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckItem(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF2A9B4A), size: 14),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrafficAnalyticsChart() {
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
                    fontSize: 14.sp,
                    color: Color(0xFF1E293B),
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
                      getTitlesWidget: (value, meta) => Text(
                        ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][value
                            .toInt()],
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: Colors.black,
                        ),
                      ),
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
                    spots: [
                      const FlSpot(0, 30),
                      const FlSpot(1, 80),
                      const FlSpot(2, 50),
                      const FlSpot(3, 50),
                      const FlSpot(4, 180),
                      const FlSpot(5, 300),
                      const FlSpot(6, 170),
                    ],
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
  }
}
