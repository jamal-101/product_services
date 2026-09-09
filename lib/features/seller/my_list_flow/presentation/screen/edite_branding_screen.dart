import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../account_section/presentation/controller/store_setup_controller.dart';

class EditBrandingScreen extends StatelessWidget {
  const EditBrandingScreen({super.key});

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
          'editBranding'.tr,
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('displayShopName'.tr, style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 13.sp)),
            SizedBox(height: 8.h),
            TextField(
              controller: controller.displayNameController,
              maxLength: 60,
              decoration: InputDecoration(
                hintText: 'displayShopNameHint'.tr,
                hintStyle: GoogleFonts.montserrat(color: Colors.grey.shade400, fontSize: 14.sp),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: Colors.grey.shade300)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: Colors.grey.shade300)),
                contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              ),
            ),
            SizedBox(height: 10.h),

            Text('description'.tr, style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 13.sp)),
            SizedBox(height: 8.h),
            TextField(
              controller: controller.descriptionController,
              maxLines: 4,
              maxLength: 300,
              decoration: InputDecoration(
                hintText: 'descriptionHint'.tr,
                hintStyle: GoogleFonts.montserrat(color: Colors.grey.shade400, fontSize: 14.sp),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: Colors.grey.shade300)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: Colors.grey.shade300)),
                contentPadding: EdgeInsets.all(15.w),
              ),
            ),
            SizedBox(height: 10.h),

            Text('category'.tr, style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 13.sp)),
            SizedBox(height: 8.h),
            Obx(() => controller.isCategoryLoading.value
                ? const Center(child: CircularProgressIndicator())
                : Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: controller.selectedCategoryId.value.isNotEmpty &&
                      controller.categoryList.any((cat) => cat.sId == controller.selectedCategoryId.value)
                      ? controller.selectedCategoryId.value
                      : null,
                  hint: Text('selectCategory'.tr, style: GoogleFonts.montserrat(fontSize: 14.sp, color: Colors.black87)),
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                  items: controller.categoryList.map((category) {
                    return DropdownButtonMenuItemStyleHelper(
                      child: DropdownMenuItem<String>(
                        value: category.sId,
                        child: Text(
                          category.name ?? "",
                          style: GoogleFonts.montserrat(fontSize: 14.sp, color: Colors.black87),
                        ),
                      ),
                    ).child;
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      controller.selectedCategoryId.value = newValue;
                      final selectedCat = controller.categoryList.firstWhere((cat) => cat.sId == newValue);
                      controller.selectedCategoryName.value = selectedCat.name ?? "";
                    }
                  },
                ),
              ),
            ),
            ),
            SizedBox(height: 20.h),
            Text('brandingSection'.tr, style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 14.sp)),
            SizedBox(height: 10.h),
            Container(
              padding: EdgeInsets.all(15.w),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(15.r),
                color: Colors.grey.shade50,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => controller.pickImage('logo'),
                      child: Container(
                        height: 100.h,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green.shade200),
                          borderRadius: BorderRadius.circular(12.r),
                          color: Colors.white,
                        ),
                        child: Obx(() => controller.selectedLogo.value != null
                            ? ClipRRect(borderRadius: BorderRadius.circular(12.r), child: Image.file(controller.selectedLogo.value!, fit: BoxFit.cover))
                            : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.image, color: Colors.green, size: 28.sp),
                            SizedBox(height: 5.h),
                            Text('logo'.tr, style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 12.sp)),
                            Text('logoSize'.tr, style: GoogleFonts.montserrat(color: Colors.grey, fontSize: 9.sp)),
                          ],
                        )),
                      ),
                    ),
                  ),
                  SizedBox(width: 15.w),
                  // Cover Picker
                  Expanded(
                    child: GestureDetector(
                      onTap: () => controller.pickImage('cover'),
                      child: Container(
                        height: 100.h,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green.shade200),
                          borderRadius: BorderRadius.circular(12.r),
                          color: Colors.white,
                        ),
                        child: Obx(() => controller.selectedCover.value != null
                            ? ClipRRect(borderRadius: BorderRadius.circular(12.r), child: Image.file(controller.selectedCover.value!, fit: BoxFit.cover))
                            : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.image, color: Colors.green, size: 28.sp),
                            SizedBox(height: 5.h),
                            Text('cover'.tr, style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 12.sp)),
                            Text('coverRatio'.tr, style: GoogleFonts.montserrat(color: Colors.grey, fontSize: 9.sp)),
                          ],
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF27AE60),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
                onPressed: () => controller.updateStore(),
                child: Obx(() => controller.isLoading.value
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text('saveChanges'.tr, style: GoogleFonts.montserrat(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.sp))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DropdownButtonMenuItemStyleHelper {
  final DropdownMenuItem<String> child;
  DropdownButtonMenuItemStyleHelper({required this.child});
}