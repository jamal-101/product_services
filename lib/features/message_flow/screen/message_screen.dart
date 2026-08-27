import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/features/auth_flow/presentation/controller/auth_controller.dart';
import 'package:product_service/utils/constants/app_string.dart';
import '../../../component/bottom_navBar/nav_bar..dart';
import 'conversation_screen.dart';

class MessageScreen extends StatelessWidget {
  MessageScreen({super.key});

  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {

    return Obx(() {
      bool isSeller = authController.selectedRole.value == 'seller';
      int messageNavIndex = isSeller ? 2 : 3;

      return Scaffold(
        bottomNavigationBar: BottomNavBar(selectedIndex: messageNavIndex),
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: false,
          elevation: 0,
          title: Text(
            AppString.message,
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
                  decoration: InputDecoration(
                    icon: const Icon(Icons.search, color: Colors.grey),
                    hintText: AppString.searchConversation,
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
                    List<String> shops = [
                      "El Mercado Verde",
                      "Tech Torres",
                      "Casa Aurora",
                      "La Plomeria Pro",
                      "Boutique Gloria",
                    ];
                    return _buildMessageItem(shops[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
    );
  }

  Widget _buildMessageItem(String shopName) {
    return GestureDetector(
      onTap: () {
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
                      Text(
                        shopName,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "2m",
                        style: GoogleFonts.montserrat(
                          fontSize: 12.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "Yes, we have fresh basil!",
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
