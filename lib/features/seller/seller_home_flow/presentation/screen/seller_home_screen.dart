import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';


class SellerHomeScreen extends StatelessWidget {
  const SellerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F7),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // ১. Top Stats (Items & Visitors)
            Row(
              children: [
                _buildStatCard("Total Items Listed", "4"),
                SizedBox(width: 16),
                _buildStatCard("Store Visitors (week)", "428"),
              ],
            ),
            SizedBox(height: 16),

            // ২. Profile Completion
            _buildProfileCompletion(),
            SizedBox(height: 16),

            // ৩. Weekly Traffic Analytics (Chart)
            _buildTrafficAnalyticsChart(),
          ],
        ),
      ),
    );
  }

  // স্ট্যাট কার্ড উইজেট
  Widget _buildStatCard(String title, String value) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: TextStyle(color: Colors.grey, fontSize: 12)),
          Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ]),
      ),
    );
  }

  // প্রোফাইল কমপ্লিশন কার্ড
  Widget _buildProfileCompletion() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.orange.withOpacity(0.3))),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text("Profile completion", style: TextStyle(fontWeight: FontWeight.bold)),
          Text("85%", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
        ]),
        SizedBox(height: 8),
        LinearProgressIndicator(value: 0.85, backgroundColor: Colors.grey[200], color: Colors.orange),
      ]),
    );
  }

  // চার্ট উইজেট
  Widget _buildTrafficAnalyticsChart() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Weekly Traffic Analytics", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Container(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(8)), child: Text("This Week", style: TextStyle(fontSize: 12))),
            ],
          ),
          Text("Simulated daily page requests", style: TextStyle(color: Colors.grey, fontSize: 12)),
          SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: true, drawVerticalLine: false, horizontalInterval: 100, getDrawingHorizontalLine: (value) => FlLine(color: Colors.grey.shade100, strokeWidth: 1)),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (value, meta) => Text(['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][value.toInt()]))),
                  leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, interval: 100)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      FlSpot(0, 20), FlSpot(1, 80), FlSpot(2, 50),
                      FlSpot(3, 50), FlSpot(4, 180), FlSpot(5, 310), FlSpot(6, 170),
                    ],
                    isCurved: true,
                    color: Color(0xFF00BFA5),
                    barWidth: 3,
                    dotData: FlDotData(show: true),
                    belowBarData: BarAreaData(show: true, color: Color(0xFF00BFA5).withOpacity(0.1)),
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