import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../component/bottom_navBar/nav_bar..dart';

class ConversationScreen extends StatelessWidget {
  const ConversationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 0,
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Container(
              width: 35.w,
              height: 35.w,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("El Mercado Verde", style: GoogleFonts.montserrat(color: Colors.black, fontSize: 14.sp, fontWeight: FontWeight.bold)),
                Text("• Online now", style: GoogleFonts.montserrat(color: Colors.green, fontSize: 10.sp)),
              ],
            ),
          ],
        ),
        actions: [IconButton(icon: const Icon(Icons.more_vert, color: Colors.black), onPressed: () {})],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.w),
              children: [
                _buildMessageBubble("Hi! Do you have fresh basil in stock?", false),
                _buildMessageBubble("Yes, we just received a fresh batch this morning 🌱", true),
                _buildMessageBubble("Is it like this one I had last week?", false),
                _buildMessageBubble("Yes exactly! Even fresher today.", true),
              ],
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  // মেসেজ বাবল ডিজাইন
  Widget _buildMessageBubble(String text, bool isSentByMe) {
    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSentByMe ? const Color(0xFF27AE60) : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: isSentByMe ? null : Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Text(
          text,
          style: GoogleFonts.montserrat(
            color: isSentByMe ? Colors.white : Colors.black,
            fontSize: 13.sp,
          ),
        ),
      ),
    );
  }

  // ইনপুট এরিয়া
  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          const Icon(Icons.attach_file, color: Colors.grey),
          SizedBox(width: 10.w),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Type a message...",
                border: InputBorder.none,
                hintStyle: GoogleFonts.montserrat(color: Colors.grey),
              ),
            ),
          ),
          const Icon(Icons.camera_alt, color: Colors.grey),
          SizedBox(width: 10.w),
          const CircleAvatar(backgroundColor: Color(0xFF27AE60), child: Icon(Icons.send, color: Colors.white)),
        ],
      ),
    );
  }
}