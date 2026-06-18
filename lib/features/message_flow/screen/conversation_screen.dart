import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';

class ConversationScreen extends StatelessWidget {
  const ConversationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String shopName = Get.arguments ?? " ";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade100),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
          ),
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
                Text(
                  shopName,
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "• Online now",
                  style: GoogleFonts.montserrat(
                    color: Colors.green,
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)), // কর্নার রাউন্ড করার জন্য
            onSelected: (value) {
              // এখানে ক্লিক করলে কী হবে তা কন্ট্রোল করুন
              if (value == 'mute') { /* Mute logic */ }
              if (value == 'delete') { /* Delete logic */ }
              if (value == 'block') { /* Block logic */ }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'mute',
                child: Row(
                  children: [
                    const Icon(Icons.notifications_off, color: Colors.black),
                    SizedBox(width: 10.w),
                    Text("Mute Notifications", style: GoogleFonts.montserrat()),
                  ],
                ),
              ),
              const PopupMenuDivider(), // মেনুর মাঝখানের লাইন
              PopupMenuItem<String>(
                value: 'delete',
                child: Row(
                  children: [
                    const Icon(Icons.delete, color: Colors.red),
                    SizedBox(width: 10.w),
                    Text("Delete Conversation", style: GoogleFonts.montserrat(color: Colors.red)),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'block',
                child: Row(
                  children: [
                    const Icon(Icons.block, color: Colors.red),
                    SizedBox(width: 10.w),
                    Text("Block Shop", style: GoogleFonts.montserrat(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.w),
              children: [
                _buildMessageBubble(
                  "Hi! Do you have fresh basil in stock?",
                  false,
                ),
                _buildMessageBubble(
                  "Yes, we just received a fresh batch this morning 🌱",
                  true,
                ),
                _buildMessageBubble(
                  "Is it like this one I had last week?",
                  false,
                ),
                _buildMessageBubble("Yes exactly! Even fresher today.", true),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(12.0), child: _buildMessageInput()),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(String text, bool isSentByMe) {
    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isSentByMe ? const Color(0xFF27AE60) : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
            bottomLeft: isSentByMe ? Radius.circular(20.r) : Radius.zero,
            bottomRight: isSentByMe ? Radius.zero : Radius.circular(20.r),
          ),
          border: isSentByMe
              ? null
              : Border.all(color: const Color(0xFFE5E7EB)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000000).withValues(alpha: 0.04),
              offset: const Offset(0, 4),
              blurRadius: 4,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Text(
          text,
          style: GoogleFonts.montserrat(
            color: isSentByMe ? Colors.white : Colors.black,
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(color: const Color(0xFFECECF0)),
      ),
      child: Row(
        children: [
          const Icon(Icons.attach_file, color: Colors.grey),
          SizedBox(width: 10.w),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Type a message...",
                border: InputBorder.none,
                hintStyle: GoogleFonts.montserrat(
                  color: Colors.grey,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ),
          const Icon(Icons.camera_alt, color: Colors.grey),
          SizedBox(width: 8.w),
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: const BoxDecoration(
              color: Color(0xFF27AE60),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.send, color: Colors.white, size: 18),
          ),
        ],
      ),
    );
  }
}
