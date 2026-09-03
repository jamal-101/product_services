import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/language_controller.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LanguageController langController = Get.put(LanguageController());

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'language'.tr,
          style: GoogleFonts.montserrat(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'selectLanguage'.tr,
              style: GoogleFonts.montserrat(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20.h),
            Obx(() {
              bool isEnglish = langController.currentLang.value == 'English';
              return _buildLanguageTile(
                title: 'English',
                subtitle: 'English (US)',
                isSelected: isEnglish,
                onTap: () {
                  langController.changeLanguage('en', 'English');
                },
              );
            }),
            SizedBox(height: 12.h),
            Obx(() {
              bool isSpanish = langController.currentLang.value == 'Spanish';
              return _buildLanguageTile(
                title: 'Español',
                subtitle: 'Spanish (ES)',
                isSelected: isSpanish,
                onTap: () {
                  langController.changeLanguage('es', 'Spanish');
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageTile({
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF27AE60).withValues(alpha: 0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF27AE60) : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.montserrat(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  subtitle,
                  style: GoogleFonts.montserrat(
                    fontSize: 12.sp,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? const Color(0xFF27AE60) : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}