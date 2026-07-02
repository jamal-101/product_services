import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/utils/constants/app_string.dart';
import '../../../../config/route/app_route.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
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
        title: Text(
          AppString.helpAndSupport,
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildExpansionTile(
                    AppString.canIBuy,
                    "No, [App Name] does not process payments or handle transactions. Buyers and sellers arrange payments and delivery directly between themselves.",
                  ),
                  _buildDivider(),
                  _buildExpansionTile("How do I contact a seller?", "Answer text goes here..."),
                  _buildDivider(),
                  _buildExpansionTile("Is there any fee to use the platform?", "Answer text goes here..."),
                  _buildDivider(),
                  _buildExpansionTile("How do I create a seller account?", "Answer text goes here..."),
                  _buildDivider(),
                  _buildExpansionTile("Can I export my payment history?", "Answer text goes here..."),
                  _buildDivider(),
                  _buildExpansionTile("How do I get my listings approved faster?", "Answer text goes here..."),
                ],
              ),
            ),
            SizedBox(height: 25.h),
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: const Color(0xFFB9E2C5).withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                children: [
                  Icon(Icons.support_agent, size: 40.sp, color: const Color(0xFF27AE60)),
                  SizedBox(height: 10.h),
                  Text(
                   AppString.stillNed,
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 16.sp),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    AppString.ourSupport,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.grey.shade700),
                  ),
                  SizedBox(height: 15.h),
                  SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF2A9B4A), Color(0xFF1F7A3A)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        onPressed: () {
                          Get.toNamed(AppRoutes.messageScreen);
                        },
                        child: Text(
                          AppString.contactSupport,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
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

  Widget _buildExpansionTile(String title, String subtitle) {
    return ExpansionTile(
      title: Text(
        title,
        style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 14.sp, color: Colors.black),
      ),
      childrenPadding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 15.h),
      children: [
        Text(subtitle, style: GoogleFonts.montserrat(fontSize: 13.sp, color: Colors.grey.shade600)),
      ],
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, indent: 20.w, endIndent: 20.w);
  }
}