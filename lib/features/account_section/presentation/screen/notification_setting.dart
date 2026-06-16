import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  bool isEmailAlertsEnabled = true;
  bool isPushNotificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Notification Settings",
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildNotificationTile(
                icon: Icons.email_outlined,
                title: "Email Alerts",
                subtitle: "Receive alerts via email",
                value: isEmailAlertsEnabled,
                onChanged: (val) => setState(() => isEmailAlertsEnabled = val),
              ),
              Divider(height: 1, indent: 20.w, endIndent: 20.w),
              _buildNotificationTile(
                icon: Icons.notifications_none_outlined,
                title: "Push Notifications",
                subtitle: "Get instant updates on your device",
                value: isPushNotificationsEnabled,
                onChanged: (val) => setState(() => isPushNotificationsEnabled = val),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      leading: Icon(icon, color: Colors.grey.shade600),
      title: Text(
        title,
        style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 14.sp),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.grey),
      ),
      trailing: Switch.adaptive(
        value: value,
        onChanged: onChanged,
        activeColor: const Color(0xFF27AE60),
      ),
    );
  }
}