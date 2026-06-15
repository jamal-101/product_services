import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Notifications",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text("Clear all", style: TextStyle(color: Colors.orange, fontSize: 13.sp)),
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          _buildNotificationItem(
            icon: Icons.percent,
            title: "Flash Sale!",
            desc: "Get 20% off on all electronics at Anytime store. Limited time offer!",
            time: "10 min ago",
            isNew: true,
          ),
          _buildNotificationItem(
            icon: Icons.chat_bubble_outline,
            title: "New Message",
            desc: "Sarah from Organic Market replied to your inquiry.",
            time: "2 hrs ago",
            isNew: true,
          ),
          _buildNotificationItem(
            icon: Icons.assignment_turned_in_outlined,
            title: "New Message",
            desc: "Sarah from Organic Market replied to your inquiry.",
            time: "Oct 15",
            isNew: false,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem({
    required IconData icon,
    required String title,
    required String desc,
    required String time,
    required bool isNew,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFECECF0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundColor: const Color(0xFFE67E22).withOpacity(0.1),
            child: Icon(icon, color: const Color(0xFFE67E22), size: 18.w),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        if (isNew)
                          Container(
                            margin: EdgeInsets.only(right: 4.w),
                            width: 6.w,
                            height: 6.h,
                            decoration: const BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
                          ),
                        Text(time, style: TextStyle(fontSize: 11.sp, color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Text(
                  desc,
                  style: TextStyle(fontSize: 12.sp, color: Colors.black54, height: 1.4),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}