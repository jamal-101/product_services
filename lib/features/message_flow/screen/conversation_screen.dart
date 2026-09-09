import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/features/message_flow/presentation/controller/conversation_controller.dart';
import 'package:product_service/services/storage/storage_service.dart';
import 'package:product_service/utils/constants/api_enpoint.dart';
import 'package:product_service/utils/constants/app_string.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  late final ConversationController conversationController;

  @override
  void initState() {
    super.initState();
    if (Get.isRegistered<ConversationController>()) {
      conversationController = Get.find<ConversationController>();
    } else {
      conversationController = Get.put(ConversationController());
    }
  }

  @override
  Widget build(BuildContext context) {
    String shopName = " ";
    String? profileImage;
    if (Get.arguments != null) {
      if (Get.arguments is Map) {
        shopName = Get.arguments['shopName'] ?? " ";
        profileImage = Get.arguments['profileImage'];
      } else if (Get.arguments is String) {
        shopName = Get.arguments;
      }
    }

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
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: profileImage != null && profileImage.isNotEmpty
                  ? Image.network(
                      profileImage.startsWith('http')
                          ? profileImage
                          : "${ApiEndPoint.imageUrl}${profileImage.startsWith('/') ? '' : '/'}$profileImage",
                      width: 35.w,
                      height: 35.w,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 35.w,
                        height: 35.w,
                        color: Colors.green,
                        child: const Icon(Icons.store, color: Colors.white, size: 20),
                      ),
                    )
                  : Container(
                      width: 35.w,
                      height: 35.w,
                      color: Colors.green,
                      child: const Icon(Icons.store, color: Colors.white, size: 20),
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
      ),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                final chatId = conversationController.chatId;
                if (chatId != null && chatId.isNotEmpty) {
                  await conversationController.getConversation(
                    chatId,
                    isRefresh: true,
                  );
                }
              },
              child: Obx(() {
                if (conversationController.isLoading.value &&
                    conversationController.messages.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (conversationController.messages.isEmpty) {
                  return ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      SizedBox(height: 100.h),
                      Center(
                        child: Text(
                          "No messages yet",
                          style: GoogleFonts.montserrat(color: Colors.grey),
                        ),
                      ),
                    ],
                  );
                }

                return ListView.builder(
                  reverse: true,
                  controller: conversationController.scrollController,
                  padding: EdgeInsets.all(16.w),
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: conversationController.messages.length + 1,
                  itemBuilder: (context, index) {
                    if (index < conversationController.messages.length) {
                      final message = conversationController.messages[index];
                      final isSentByMe =
                          message.sender.id == LocalStorage.userId;
                      return _buildMessageBubble(
                        message.text,
                        message.image,
                        isSentByMe,
                      );
                    }

                    if (conversationController.isLoadMoreLoading.value) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    }

                    if (!conversationController.hasMore.value &&
                        conversationController.messages.isNotEmpty) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: Center(
                          child: Text(
                            "No more messages",
                            style: GoogleFonts.montserrat(
                              color: Colors.grey,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                );
              }),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: _buildMessageInput(context),
          ),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(String text, String? imageUrl, bool isSentByMe) {
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
        child: Column(
          crossAxisAlignment: isSentByMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            if (imageUrl != null && imageUrl.isNotEmpty) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: _buildBubbleImage(imageUrl),
              ),
              if (text.isNotEmpty) SizedBox(height: 8.h),
            ],
            if (text.isNotEmpty)
              Text(
                text,
                style: GoogleFonts.montserrat(
                  color: isSentByMe ? Colors.white : Colors.black,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBubbleImage(String url) {
    if (url.startsWith("http")) {
      return Image.network(
        url,
        height: 150.h,
        width: 200.w,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.broken_image, color: Colors.grey),
      );
    } else if (url.isNotEmpty && File(url).existsSync()) {
      return Image.file(
        File(url),
        height: 150.h,
        width: 200.w,
        fit: BoxFit.cover,
      );
    } else {
      // Fix: Handle relative paths and ensure correct base URL concatenation
      String fullUrl = url;
      if (url.isNotEmpty) {
        if (url.startsWith('/')) {
          fullUrl = "${ApiEndPoint.imageUrl}$url";
        } else {
          fullUrl = "${ApiEndPoint.imageUrl}/$url";
        }
      }

      return Image.network(
        fullUrl,
        height: 150.h,
        width: 200.w,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.broken_image, color: Colors.grey),
      );
    }
  }

  Widget _buildMessageInput(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(() {
          final file = conversationController.selectedImage.value;
          if (file == null) return const SizedBox.shrink();
          return Container(
            margin: EdgeInsets.only(bottom: 8.h),
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.file(
                    file,
                    width: 50.w,
                    height: 50.w,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    file.path.split('/').last,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.montserrat(fontSize: 12.sp),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.red),
                  onPressed: () => conversationController.removeSelectedImage(),
                ),
              ],
            ),
          );
        }),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: const Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(30.r),
            border: Border.all(color: const Color(0xFFECECF0)),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => conversationController.pickImage(context),
                child: const Icon(Icons.camera_alt, color: Colors.grey),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: TextField(
                  controller: conversationController.textController,
                  decoration: InputDecoration(
                    hintText: AppString.typeMessage.tr,
                    border: InputBorder.none,
                    hintStyle: GoogleFonts.montserrat(
                      color: Colors.grey,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              GestureDetector(
                onTap: () => conversationController.sendMessage(),
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: const BoxDecoration(
                    color: Color(0xFF27AE60),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.send, color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
