import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../account_section/presentation/controller/store_setup_controller.dart';


class EditLegalDocumentsScreen extends StatelessWidget {
  const EditLegalDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final StoreUpdateController controller = Get.put(StoreUpdateController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'editLegalDocuments'.tr,
          style: GoogleFonts.montserrat(color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('tradeLicenseNo'.tr, style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 13.sp)),
            SizedBox(height: 8.h),
            TextField(
              controller: controller.tradeLicenseNoController,
              decoration: InputDecoration(
                hintText: 'tradeLicenseHint'.tr,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: Colors.grey.shade300)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: Colors.grey.shade300)),
                contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              ),
            ),
            SizedBox(height: 15.h),

            Text('uploadTradeLicense'.tr, style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 13.sp)),
            SizedBox(height: 8.h),
            GestureDetector(
              onTap: () => controller.pickImage('tradeLicense'),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 30.h),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green.shade200),
                  borderRadius: BorderRadius.circular(12.r),
                  color: Colors.grey.shade50,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.description_outlined, color: Colors.green, size: 32.sp),
                    SizedBox(height: 8.h),
                    Obx(() => Text(
                      controller.selectedTradeLicenseFile.value != null ? 'fileSelected'.tr : 'uploadFileHere'.tr,
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 13.sp, color: Colors.black87),
                    )),
                    SizedBox(height: 4.h),
                    Text('fileFormatInfo'.tr, style: GoogleFonts.montserrat(color: Colors.grey, fontSize: 11.sp)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15.h),

            Text('tinNumber'.tr, style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 13.sp)),
            SizedBox(height: 8.h),
            TextField(
              controller: controller.tinNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'tinHint'.tr,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: Colors.grey.shade300)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: Colors.grey.shade300)),
                contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              ),
            ),
            SizedBox(height: 40.h),

            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF27AE60),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
                onPressed: () => controller.updateStore(),
                child: Text('saveChanges'.tr, style: GoogleFonts.montserrat(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.sp)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}