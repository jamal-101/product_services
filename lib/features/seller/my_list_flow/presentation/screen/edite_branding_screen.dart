// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../../../../account_section/presentation/controller/store_setup_controller.dart';
// import '../../../../account_section/presentation/screen/OperatingHoursScreen.dart';
//
// class EditBrandingScreen extends StatelessWidget {
//   const EditBrandingScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(StoreSetupController());
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: Text(
//           "Edit Branding",
//           style: GoogleFonts.montserrat(
//             color: Colors.black,
//             fontSize: 18.sp,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildLabel("Store Name"),
//             _buildTextField(controller.storeNameController, "e.g. TechZone BD"),
//             SizedBox(height: 16.h),
//             _buildLabel("Description"),
//             _buildTextField(controller.descriptionController, "Write about your store...", maxLines: 3),
//             SizedBox(height: 16.h),
//             _buildLabel("Category"),
//
//             // --- Category Dropdown Fix ---
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 12.w),
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey.shade300),
//                 borderRadius: BorderRadius.circular(10.r),
//               ),
//               child: Obx(() => DropdownButtonHideUnderline(
//                 child: DropdownButton<String>(
//                   isExpanded: true,
//                   value: controller.selectedCategory.value,
//                   hint: Text("Select Category", style: GoogleFonts.montserrat(fontSize: 14.sp)),
//                   // Map the categories list containing id and name
//                   items: controller.categories.map((cat) {
//                     return DropdownMenuItem<String>(
//                       value: cat['id'], // Backend e jabe MongoDB ObjectId
//                       child: Text(cat['name']!, style: GoogleFonts.montserrat(fontSize: 14.sp)), // UI te dekhabe Name
//                     );
//                   }).toList(),
//                   onChanged: (val) {
//                     controller.selectedCategory.value = val;
//                   },
//                 ),
//               )),
//             ),
//             // -----------------------------
//
//             SizedBox(height: 16.h),
//             _buildLabel("Branding Images"),
//             Row(
//               children: [
//                 _buildImagePicker("Logo", () => controller.pickImage('logo')),
//                 SizedBox(width: 12.w),
//                 _buildImagePicker("Cover Image", () => controller.pickImage('cover')),
//               ],
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: EdgeInsets.all(20.w),
//         child: SizedBox(
//           height: 50.h,
//           child: ElevatedButton(
//             style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF27AE60)),
//             onPressed: () {
//               if (controller.storeNameController.text.trim().isEmpty) {
//                 Get.snackbar("Error", "Please enter store name", backgroundColor: Colors.red, colorText: Colors.white);
//                 return;
//               }
//               if (controller.selectedCategory.value == null) {
//                 Get.snackbar("Error", "Please select a category", backgroundColor: Colors.red, colorText: Colors.white);
//                 return;
//               }
//               Get.to(() => const OperatingHoursScreen());
//             },
//             child: Text("Next", style: GoogleFonts.montserrat(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.sp)),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLabel(String text) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 6.h),
//       child: Text(text, style: GoogleFonts.montserrat(fontSize: 13.sp, fontWeight: FontWeight.w600)),
//     );
//   }
//
//   Widget _buildTextField(TextEditingController textController, String hint, {int maxLines = 1}) {
//     return TextField(
//       controller: textController,
//       maxLines: maxLines,
//       decoration: InputDecoration(
//         hintText: hint,
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
//         contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
//       ),
//     );
//   }
//
//   Widget _buildImagePicker(String title, VoidCallback onTap) {
//     return Expanded(
//       child: OutlinedButton.icon(
//         onPressed: onTap,
//         icon: const Icon(Icons.image, color: Color(0xFF27AE60)),
//         label: Text(title, style: GoogleFonts.montserrat(color: Colors.black87)),
//       ),
//     );
//   }
// }


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
          "Edit Branding",
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
            // Display Shop Name
            Text("Display Shop Name", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 13.sp)),
            SizedBox(height: 8.h),
            TextField(
              controller: controller.displayNameController,
              maxLength: 60,
              decoration: InputDecoration(
                hintText: "e.g. Le Reve Organics",
                hintStyle: GoogleFonts.montserrat(color: Colors.grey.shade400, fontSize: 14.sp),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: Colors.grey.shade300)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: Colors.grey.shade300)),
                contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              ),
            ),
            SizedBox(height: 10.h),

            // Description
            Text("Description", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 13.sp)),
            SizedBox(height: 8.h),
            TextField(
              controller: controller.descriptionController,
              maxLines: 4,
              maxLength: 300,
              decoration: InputDecoration(
                hintText: "Describe what you sell and what makes your shop unique.",
                hintStyle: GoogleFonts.montserrat(color: Colors.grey.shade400, fontSize: 14.sp),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: Colors.grey.shade300)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: Colors.grey.shade300)),
                contentPadding: EdgeInsets.all(15.w),
              ),
            ),
            SizedBox(height: 10.h),

            // Category Dropdown (Mock/Simple view)
            Text("Category", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 13.sp)),
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 14.h),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Electronics & Gadgets", style: GoogleFonts.montserrat(fontSize: 14.sp, color: Colors.black87)),
                  const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            // Branding Section (Logo & Cover)
            Text("Branding", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 14.sp)),
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
                  // Logo Picker
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
                            Text("Logo", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 12.sp)),
                            Text("Square, 500x500 px", style: GoogleFonts.montserrat(color: Colors.grey, fontSize: 9.sp)),
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
                            Text("Cover", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 12.sp)),
                            Text("16:9 ratio", style: GoogleFonts.montserrat(color: Colors.grey, fontSize: 9.sp)),
                          ],
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),

            // Save Button
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
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text("Save Changes", style: GoogleFonts.montserrat(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.sp))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}