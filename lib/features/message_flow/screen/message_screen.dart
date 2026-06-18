import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/config/route/app_route.dart';

import '../../../component/bottom_navBar/nav_bar..dart';
import 'conversation_screen.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 2,
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
        title: Text(
          "Messages",
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            // সার্চ বার
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: TextField(
                decoration: InputDecoration(
                  icon: const Icon(Icons.search, color: Colors.grey),
                  hintText: "Search conversations...",
                  hintStyle: GoogleFonts.montserrat(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            // মেসেজ লিস্ট
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  // এখানে উদাহরণস্বরূপ কিছু নাম পাঠাচ্ছি, আপনি আপনার ডাটা লিস্ট থেকে এটি পাঠাবেন
                  List<String> shops = ["El Mercado Verde", "Tech Torres", "Casa Aurora", "La Plomeria Pro", "Boutique Gloria"];
                  return _buildMessageItem(shops[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageItem(String shopName) {
    return GestureDetector(
      onTap: (){
        Get.to(() => const ConversationScreen(), arguments: shopName);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000000).withValues(alpha: 0.04),
              offset: const Offset(0, 4),
              blurRadius: 4,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: const Icon(Icons.store, color: Colors.orange),
            ),
            SizedBox(width: 12.w),
            // মেসেজ ডিটেইলস
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // এখানে হার্ডকোড করা নামের পরিবর্তে shopName ব্যবহার করা হয়েছে
                      Text(shopName, style: GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
                      Text("2m", style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.grey)),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text("Yes, we have fresh basil!", style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}