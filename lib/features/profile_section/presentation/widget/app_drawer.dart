import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/features/profile_section/presentation/screen/save_flow/presentation/screen/privacy_and_policy.dart';
import 'package:product_service/features/profile_section/presentation/screen/save_flow/presentation/screen/safety_guidelines.dart';
import 'package:product_service/features/profile_section/presentation/screen/save_flow/presentation/screen/save_screen.dart';
import 'package:product_service/features/profile_section/presentation/screen/store_creation/presentation/screen/my_store.dart';

import '../screen/save_flow/presentation/screen/trems_and_condition.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 280.w,
      backgroundColor: Colors.white,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 60.h, left: 20.w, right: 20.w, bottom: 20.h),
            color: const Color(0xFFF1FDF5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30.r,
                  backgroundImage: const NetworkImage("https://via.placeholder.com/150"),
                ),
                SizedBox(height: 10.h),
                Text("Sazzad Chowdhury", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 16.sp)),
                Text("Buyer Mode", style: GoogleFonts.montserrat(color: const Color(0xFF27AE60), fontSize: 12.sp)),
                SizedBox(height: 15.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  decoration: BoxDecoration(color: const Color(0xFF27AE60), borderRadius: BorderRadius.circular(8.r)),
                  child: Row(
                    children: [
                      const Icon(Icons.swap_horiz, color: Colors.white, size: 18),
                      SizedBox(width: 8.w),
                      Text("Switch to Seller Mode", style: GoogleFonts.montserrat(color: Colors.white, fontSize: 12.sp)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              children: [
                _buildMenuItem(context,Icons.storefront_outlined, "My Store"),
                _buildMenuItem(context,Icons.bookmark_border, "Saved Products"),
                _buildMenuItem(context,Icons.shopping_bag_outlined, "Saved Services"),
                _buildMenuItem(context,Icons.description_outlined, "Safety Guidelines"),
                _buildMenuItem(context,Icons.privacy_tip_outlined, "Privacy Policy"),
                _buildMenuItem(context,Icons.article_outlined, "Terms & Conditions"),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Row(
              children: [
                const Icon(Icons.logout, color: Colors.red),
                SizedBox(width: 10.w),
                Text("Log Out", style: GoogleFonts.montserrat(color: Colors.red, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildMenuItem(BuildContext context, IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey.shade700),
      title: Text(
          title,
          style: GoogleFonts.montserrat(fontSize: 14.sp, color: Colors.black)
      ),
      onTap: () {
        // ড্রয়ার ক্লোজ করা
        Navigator.pop(context);

        // সুইচের মাধ্যমে রাউটিং হ্যান্ডেল করা
        switch (title) {
          case "My Store":
            Get.to(() => const MyStore()); // আপনার স্ক্রিন নেম অনুযায়ী
            break;
          case "Saved Products":
            Get.to(() => SaveScreen());
            break;
          case "Saved Services":
            // Get.to(() => const SavedServicesScreen());
            break;
          case "Safety Guidelines":
            Get.to(() => SafetyGuidelines());
            break;
          case "Privacy Policy":
            Get.to(() => const PrivacyAndPolicy());
            break;
          case "Terms & Conditions":
            Get.to(() => TremsAndCondition());
            break;
          default:
            break;
        }
      },
    );
  }
}