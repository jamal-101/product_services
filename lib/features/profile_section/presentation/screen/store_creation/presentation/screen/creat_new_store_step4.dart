// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'creat_new_store_step5.dart';
//
//
// class CreateNewStoreStep4 extends StatelessWidget {
//   const CreateNewStoreStep4({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         surfaceTintColor: Colors.white,
//         elevation: 0,
//         leading: Padding(
//           padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
//           child: GestureDetector(
//             onTap: (){
//               Get.back();
//             },
//             child: Container(
//               decoration: BoxDecoration(
//                 color: const Color(0xFFF5F5EF),
//                 borderRadius: BorderRadius.circular(12.r),
//               ),
//               child: const Icon(Icons.arrow_back, color: Colors.black),
//             ),
//           ),
//         ),
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text(
//               "Create New Store",
//               style: TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             Text(
//               "Step 4 of 4",
//               style: TextStyle(color: Colors.grey, fontSize: 14.sp),
//             ),
//           ],
//         ),
//         bottom: PreferredSize(
//           preferredSize: Size.fromHeight(4.h),
//           child: LinearProgressIndicator(
//             value: 10,
//             backgroundColor: Colors.grey.shade200,
//             color: const Color(0xFF2A9B4A),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Legal Documents",
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
//             ),
//             Text(
//               "Required for marketplace compliance and delivery setup.",
//               style: TextStyle(color: Colors.grey, fontSize: 13.sp),
//             ),
//             SizedBox(height: 20.h),
//
//             Text(
//               "Business License",
//               style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.sp),
//             ),
//             SizedBox(height: 15.h),
//             Container(
//               padding: EdgeInsets.all(20.w),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16.r),
//                 border: Border.all(color: const Color(0xFFECECF0)),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withValues(alpha: 0.03),
//                     blurRadius: 10,
//                     offset: const Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildLabel("Trade License No. *"),
//                   _buildTextField("e.g. TL-8829-2024"),
//
//                   _buildLabel("Upload Trade License *"),
//                   _buildUploadBox(),
//
//                   _buildLabel("TIN Number *"),
//                   _buildTextField("e.g. 123-456-789"),
//                 ],
//               ),
//             ),
//             SizedBox(height: 40.h),
//             buildNextButton(() {
//               Get.to(() => CreateNewStoreStep5());
//             }),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLabel(String text) => Padding(
//     padding: EdgeInsets.only(bottom: 8.h, top: 10.h),
//     child: Text(
//       text,
//       style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp),
//     ),
//   );
//
//   Widget _buildTextField(String hint) => TextField(
//     decoration: InputDecoration(
//       hintText: hint,
//       fillColor: const Color(0xFFF9F9F9),
//       filled: true,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12.r),
//         borderSide: const BorderSide(color: Color(0xFFECECF0)),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12.r),
//         borderSide: const BorderSide(color: Color(0xFFECECF0)),
//       ),
//       contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
//     ),
//   );
//
//   Widget _buildUploadBox() {
//     return Container(
//       margin: EdgeInsets.only(top: 8.h),
//       child: DottedBorder(
//         borderType: BorderType.RRect,
//         radius: Radius.circular(12.r),
//         dashPattern: [6, 4],
//         color: const Color(0xFFECECF0),
//         strokeWidth: 1.5,
//         child: Container(
//           width: double.infinity,
//           padding: EdgeInsets.symmetric(vertical: 24.h),
//           decoration: BoxDecoration(
//             color: const Color(0xFFF9F9F9),
//             borderRadius: BorderRadius.circular(12.r),
//           ),
//           child: Column(
//             children: [
//               Icon(Icons.badge_outlined, color: Colors.grey.shade500, size: 30.sp),
//               SizedBox(height: 10.h),
//               Text("Upload your file here", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
//               Text("PDF or image .or PNG up to 10MB", style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget buildNextButton(VoidCallback onTap, {String text = "Create Store"}) {
//     return SizedBox(
//       width: double.infinity,
//       height: 50.h,
//       child: InkWell(
//         onTap: onTap,
//         child: Container(
//           decoration: BoxDecoration(
//             gradient: const LinearGradient(
//               colors: [Color(0xFF2A9B4A), Color(0xFF1F7A3A)],
//               begin: Alignment.centerLeft,
//               end: Alignment.centerRight,
//             ),
//             borderRadius: BorderRadius.circular(
//                 10.r),
//           ),
//           alignment: Alignment.center,
//           child: Text(
//             text,
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 16.sp,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controller/profile_controller.dart';
import '../controller/store_creation_controller.dart';
import 'creat_new_store_step5.dart';
import 'package:image_picker/image_picker.dart' as img_picker;

class CreateNewStoreStep4 extends StatelessWidget {
  const CreateNewStoreStep4({super.key});

  @override
  Widget build(BuildContext context) {
    final StoreCreationController controller = Get.find<StoreCreationController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              decoration: BoxDecoration(color: const Color(0xFFF5F5EF), borderRadius: BorderRadius.circular(12.r)),
              child: const Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Create New Store", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
            Text("Step 4 of 5", style: TextStyle(color: Colors.grey, fontSize: 14.sp)),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.h),
          child: LinearProgressIndicator(value: 0.8, backgroundColor: Colors.grey.shade200, color: const Color(0xFF2A9B4A)),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Legal Documents", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
            Text("Required for marketplace compliance and delivery setup.", style: TextStyle(color: Colors.grey, fontSize: 13.sp)),
            SizedBox(height: 20.h),
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16.r), border: Border.all(color: const Color(0xFFECECF0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel("Trade License No. *"),
                  _buildTextField("e.g. TL-8829-2024", controller.tradeLicenseNoController),

                  // _buildLabel("Upload Trade License *"),
                  // InkWell(
                  //   onTap: () => controller.pickImage('trade_license'),
                  //   child: Obx(() => _buildUploadBox(controller.tradeLicenseFile.value)),
                  // ),

                  _buildLabel("Upload Trade License *"),
                  InkWell(
                    onTap: () => _showImageSourceBottomSheet(context, controller), // 🔹 Bottom sheet function call kora holo
                    child: Obx(() => _buildUploadBox(controller.tradeLicenseFile.value)),
                  ),

                  _buildLabel("TIN Number *"),
                  _buildTextField("e.g. 123-456-789", controller.tinNumberController),
                ],
              ),
            ),
            SizedBox(height: 40.h),
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(color: Color(0xFF2A9B4A)),
                );
              }
              return buildNextButton(
                () {
                  // Already subscribed: create store without paying again.
                  final profile = Get.isRegistered<ProfileController>()
                      ? Get.find<ProfileController>()
                      : null;
                  final alreadyPaid = profile
                          ?.profileModel.value.data?.storeSubscription?.isPurchased ??
                      false;
                  if (alreadyPaid) {
                    controller.createStore();
                  } else {
                    Get.to(() => const CreateNewStoreStep5(payMode: true));
                  }
                },
                text: "Continue",
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) => Padding(
    padding: EdgeInsets.only(bottom: 8.h, top: 10.h),
    child: Text(text, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp)),
  );

  Widget _buildTextField(String hint, TextEditingController textController) => TextField(
    controller: textController,
    decoration: InputDecoration(
      hintText: hint,
      fillColor: const Color(0xFFF9F9F9),
      filled: true,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: Color(0xFFECECF0))),
    ),
  );

  Widget _buildUploadBox(File? file) {
    return Container(
      margin: EdgeInsets.only(top: 8.h),
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(12.r),
        dashPattern: [6, 4],
        color: const Color(0xFFECECF0),
        strokeWidth: 1.5,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          decoration: BoxDecoration(
            color: const Color(0xFFF9F9F9),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Center(
            child: file != null
                ? Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.file(
                    file,
                    height: 100.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "File Selected: ${file.path.split('/').last}",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            )
                : Column(
              children: [
                Icon(Icons.badge_outlined, color: Colors.grey.shade500, size: 30.sp),
                SizedBox(height: 10.h),
                Text("Upload your file here", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
                Text("PDF or image up to 10MB", style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNextButton(VoidCallback onTap, {String text = "Create Store"}) {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFF2A9B4A), Color(0xFF1F7A3A)]),
            borderRadius: BorderRadius.circular(10.r),
          ),
          alignment: Alignment.center,
          child: Text(text, style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }


  void _showImageSourceBottomSheet(
      BuildContext context,
      StoreCreationController controller,
      ) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Wrap(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Text(
                "Select Image Source",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Color(0xFF2A9B4A)),
              title: const Text("Gallery"),
              onTap: () {
                Get.back();
                controller.pickImage('trade_license', img_picker.ImageSource.gallery); // 🔹 type ebong source duitai pass kora holo
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Color(0xFF2A9B4A)),
              title: const Text("Camera"),
              onTap: () {
                Get.back();
                controller.pickImage('trade_license', img_picker.ImageSource.camera); // 🔹 type ebong source duitai pass kora holo
              },
            ),
          ],
        ),
      ),
    );
  }
}