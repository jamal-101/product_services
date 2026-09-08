import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controller/notification_controller.dart';


class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final NotificationController controller = Get.put(NotificationController());

    return Scaffold(
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
      body: Obx(() {

        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.orange),
          );
        }

        if (controller.notificationList.isEmpty) {
          return Center(
            child: Text(
              "No notifications found",
              style: TextStyle(fontSize: 14.sp, color: Colors.grey),
            ),
          );
        }


        return ListView.builder(
          padding: EdgeInsets.all(16.w),
          itemCount: controller.notificationList.length,
          itemBuilder: (context, index) {
            var item = controller.notificationList[index];

            IconData itemIcon = Icons.notifications_outlined;
            if (item.type == 'sale') {
              itemIcon = Icons.percent;
            } else if (item.type == 'message') {
              itemIcon = Icons.chat_bubble_outline;
            }

            bool isNew = !(item.read ?? true);

            return _buildNotificationItem(
              icon: itemIcon,
              title: item.title ?? "Notification",
              desc: item.text ?? "",
              time: item.createdAt ?? "",
              isNew: isNew,
            );
          },
        );
      }),
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
            backgroundColor: const Color(0xFFE67E22).withValues(alpha: 0.1),
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
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
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