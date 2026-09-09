import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/features/auth_flow/presentation/controller/auth_controller.dart';
import 'package:product_service/features/message_flow/presentation/controller/message_controller.dart';
import 'package:product_service/features/message_flow/model/chat_model.dart';
import 'package:product_service/services/storage/storage_service.dart';
import 'package:product_service/utils/constants/api_enpoint.dart';
import 'package:product_service/utils/constants/app_string.dart';
import 'package:product_service/utils/constants/relative_time_extention.dart';
import '../../../component/bottom_navBar/nav_bar..dart';
import 'conversation_screen.dart';

class MessageScreen extends StatelessWidget {
  MessageScreen({super.key});

  final AuthController authController = Get.put(AuthController());
  final MessageController messageController = Get.put(MessageController());

  @override
  Widget build(BuildContext context) {
    final userId = LocalStorage.userId;
    return Obx(() {
      bool isSeller = authController.selectedRole.value == 'seller';
      int messageNavIndex = isSeller ? 3 : 3;

      return Scaffold(
        bottomNavigationBar: BottomNavBar(selectedIndex: messageNavIndex),
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: false,
          elevation: 0,
          title: Text(
            'messages'.tr,
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: TextField(
                  onChanged: messageController.onSearchChanged,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.search, color: Colors.grey),
                    hintText: AppString.searchConversation.tr,
                    hintStyle: GoogleFonts.montserrat(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await messageController.getChatList(isRefresh: true);
                  },
                  child: Obx(() {
                    if (messageController.messageListLoading.value &&
                        messageController.chats.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (messageController.chats.isEmpty) {
                      return ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          SizedBox(height: 100.h),
                          Center(
                            child: Text(
                              "No messages found",
                              style: GoogleFonts.montserrat(color: Colors.grey),
                            ),
                          ),
                        ],
                      );
                    }
                    return ListView.builder(
                      controller: messageController.scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: messageController.chats.length + 1,
                      itemBuilder: (context, index) {
                        if (index < messageController.chats.length) {
                          final chat = messageController.chats[index];
                          
                          // Find the other participant to show their info
                          final otherParticipant = chat.participants.firstWhere(
                            (p) => p.id != userId,
                            orElse: () => chat.participants.isNotEmpty
                                ? chat.participants[0]
                                : Participant(
                                    id: "",
                                    name: "User",
                                    role: "",
                                    activeRole: "",
                                    email: "",
                                    profileImage: "",
                                  ),
                          );

                          return _buildMessageItem(
                            chatId: chat.id,
                            shopName: otherParticipant.name,
                            profileImage: otherParticipant.profileImage,
                            lastMessage: chat.lastMessage?.type != "text" &&
                                    chat.lastMessage?.image != null &&
                                    chat.lastMessage!.image.isNotEmpty
                                ? "image"
                                : chat.lastMessage?.text,
                            time: chat.createdAt.toRelativeTime(fallback: ""),
                          );
                        }
                        if (messageController.isLoadMoreLoading.value) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        if (!messageController.hasMore.value &&
                            messageController.chats.isNotEmpty) {
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
            ],
          ),
        ),
      );
    });
  }

  Widget _buildMessageItem({
    String? chatId,
    String? shopName,
    String? profileImage,
    String? lastMessage,
    String? time,
  }) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => ConversationScreen(),
          arguments: {
            'chatId': chatId,
            'shopName': shopName,
            'profileImage': profileImage,
          },
        );
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
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: profileImage != null && profileImage.isNotEmpty
                  ? Image.network(
                      profileImage.startsWith('http')
                          ? profileImage
                          : "${ApiEndPoint.imageUrl}${profileImage.startsWith('/') ? '' : '/'}$profileImage",
                      width: 50.w,
                      height: 50.w,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 50.w,
                        height: 50.w,
                        color: Colors.grey.shade100,
                        child: const Icon(Icons.store, color: Colors.orange),
                      ),
                    )
                  : Container(
                      width: 50.w,
                      height: 50.w,
                      color: Colors.grey.shade100,
                      child: const Icon(Icons.store, color: Colors.orange),
                    ),
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
                      Text(
                        shopName ?? "",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        time ?? "",
                        style: GoogleFonts.montserrat(
                          fontSize: 12.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    lastMessage ?? "",
                    style: GoogleFonts.montserrat(
                      fontSize: 12.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
