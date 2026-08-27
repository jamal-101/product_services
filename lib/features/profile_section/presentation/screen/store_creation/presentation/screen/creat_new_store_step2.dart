// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:product_service/utils/constants/app_color.dart';
// import '../widget/common_widget.dart';
// import 'creat_new_store_step3.dart';
//
// class CreateNewStoreStep2 extends StatelessWidget {
//   const CreateNewStoreStep2({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:AppBar(
//         surfaceTintColor: AppColor.appBackgroundColor,
//         elevation: 0,
//         leading: Padding(
//           padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
//           child: GestureDetector(
//             onTap: (){
//               Get.back();
//             },
//             child: Container(
//               decoration: BoxDecoration(
//                 color: const Color(0xFFF7F7F2),
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
//               style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
//             ),
//             Text(
//               "Step 2 of 4",
//               style: TextStyle(color: Colors.grey, fontSize: 14.sp),
//             ),
//           ],
//         ),
//         bottom: PreferredSize(
//           preferredSize: Size.fromHeight(4.h),
//           child: LinearProgressIndicator(
//             value: 0.5,
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
//               "Shop Identity",
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
//             ),
//             SizedBox(height: 5.h),
//             Text(
//               "Let's start with the basics — what is your shop?",
//               style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
//             ),
//
//             SizedBox(height: 25.h),
//             _buildTextField(
//               "Display Shop Name",
//               "e.g. Le Reve Organics",
//               limit: "0/60",
//             ),
//             _buildTextField(
//               "Description",
//               "Describe what you sell and what makes your shop unique.",
//               maxLines: 3,
//               limit: "0/300",
//             ),
//             _buildCategoryField("Category", onTap: () {  }),
//             _buildCategoryField("Time zone", onTap: () {  }),
//
//             SizedBox(height: 15.h),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Branding *",
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
//                 ),
//                 SizedBox(height: 12.h),
//                 Container(
//                   padding: EdgeInsets.all(16.w),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16.r),
//                     border: Border.all(color: Color(0xFFECECF0)),
//                   ),
//                   child: Row(
//                     children: [
//                       buildUploadBox("Upload Logo\nSquare, 500x500 px"),
//                       SizedBox(width: 15.w),
//                       buildUploadBox("Upload Cover Image\n6:9 ratio, min 1920x1080 px"),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 40.h),
//
//             buildNextButton(() {
//               Get.to(() => const CreateNewStoreStep3());
//             }),
//             SizedBox(height: 20.h),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField(
//       String label,
//       String hint, {
//         int maxLines = 1,
//         String limit = "",
//       }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
//         ),
//         SizedBox(height: 8.h),
//         TextField(
//           maxLines: maxLines,
//           textAlignVertical: TextAlignVertical.top,
//           decoration: InputDecoration(
//             hintStyle: TextStyle(
//               color: Colors.black54,
//               fontSize: 14.sp,
//             ),
//             hintText: hint,
//             hintMaxLines: maxLines > 1 ? 3 : 1,
//             fillColor: const Color(0xFFFFFFFF),
//             filled: true,
//             isDense: true,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12.r),
//               borderSide: const BorderSide(color: Color(0xFFECECF0)),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12.r),
//               borderSide: const BorderSide(color: Color(0xFFECECF0)),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12.r),
//               borderSide: const BorderSide(color: Color(0xFFECECF0)),
//             ),
//           ),
//         ),
//         if (limit.isNotEmpty)
//           Align(
//             alignment: Alignment.centerRight,
//             child: Padding(
//               padding: EdgeInsets.only(top: 4.h),
//               child: Text(
//                 limit,
//                 style: TextStyle(fontSize: 12.sp, color: Colors.grey),
//               ),
//             ),
//           ),
//         SizedBox(height: 15.h),
//       ],
//     );
//   }
//
//   Widget _buildCategoryField(String label, {required VoidCallback onTap}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
//         ),
//         SizedBox(height: 8.h),
//         GestureDetector(
//           onTap: onTap,
//           child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               border: Border.all(color: const Color(0xFFECECF0)),
//               borderRadius: BorderRadius.circular(12.r),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "Select category",
//                   style: TextStyle(color: Colors.grey.shade600),
//                 ),
//                 const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
//               ],
//             ),
//           ),
//         ),
//         SizedBox(height: 15.h),
//       ],
//     );
//   }
//
//
//
//
//   Widget buildUploadBox(String label) {
//     return Expanded(
//       child: DottedBorder(
//         borderType: BorderType.RRect,
//         radius: Radius.circular(10.r),
//         dashPattern: [6, 4],
//         color: const Color(0xFFECECF0),
//         strokeWidth: 1.5,
//         child: Container(
//           height: 110.h,
//           decoration: BoxDecoration(
//             color: Color(0xFFFAFAF7),
//             borderRadius: BorderRadius.circular(10.r),
//           ),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.add_photo_alternate_outlined,
//                   color: Colors.grey.shade600,
//                   size: 28.sp,
//                 ),
//                 SizedBox(height: 8.h),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 4.w),
//                   child: Text(
//                     label,
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 10.sp,
//                       color: Colors.grey.shade700,
//                       fontWeight: FontWeight.w500,
//                       height: 1.2,
//                     ),
//                   ),
//                 ),
//               ],
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
import 'package:product_service/utils/constants/app_color.dart';
import '../controller/store_creation_controller.dart';
import '../widget/common_widget.dart';
import 'creat_new_store_step3.dart';

class CreateNewStoreStep2 extends StatelessWidget {
  const CreateNewStoreStep2({super.key});

  @override
  Widget build(BuildContext context) {
    final StoreCreationController controller =
        Get.find<StoreCreationController>();

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColor.appBackgroundColor,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF7F7F2),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: const Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Create New Store",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Step 2 of 4",
              style: TextStyle(color: Colors.grey, fontSize: 14.sp),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.h),
          child: LinearProgressIndicator(
            value: 0.5,
            backgroundColor: Colors.grey.shade200,
            color: const Color(0xFF2A9B4A),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Shop Identity",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
            ),
            SizedBox(height: 5.h),
            Text(
              "Let's start with the basics — what is your shop?",
              style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
            ),
            SizedBox(height: 25.h),

            _buildTextField(
              "Display Shop Name",
              "e.g. Le Reve Organics",
              controller.nameController,
            ),
            _buildTextField(
              "Description",
              "Describe what you sell...",
              controller.descriptionController,
              maxLines: 3,
            ),
            _buildDropdownField(
              "Category",
              controller.selectedCategoryName,
              () {
                _showCategoryBottomSheet(context, controller);
              },
            ),
            _buildDropdownField(
              "Time zone / City",
              controller.selectedCityName,
                  () {
                controller.fetchCitiesOnDemand();
                _showCityBottomSheet(context, controller);
              },
            ),

            SizedBox(height: 15.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Branding *",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 12.h),
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: const Color(0xFFECECF0)),
                  ),
                  child: Row(
                    children: [
                      Obx(
                        () => buildUploadBox(
                          "Upload Logo\nSquare, 500x500 px",
                          controller.logoFile.value,
                          () => controller.pickImage('logo'),
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Obx(
                        () => buildUploadBox(
                          "Upload Cover\n6:9 ratio",
                          controller.coverImageFile.value,
                          () => controller.pickImage('cover'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.h),
            buildNextButton(() {
              if (controller.nameController.text.isNotEmpty &&
                  controller.selectedCategoryId.value.isNotEmpty) {
                Get.to(() => const CreateNewStoreStep3());
              } else {
                Get.snackbar(
                  "Required",
                  "Please fill in all required fields and select a category.",
                );
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    String hint,
    TextEditingController textController, {
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: textController,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFFECECF0)),
            ),
          ),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }

  Widget _buildDropdownField(
    String label,
    RxString selectedValue,
    VoidCallback onTap,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFFECECF0)),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => Text(
                    selectedValue.value,
                    style: TextStyle(
                      color: selectedValue.value.contains("Select")
                          ? Colors.grey.shade600
                          : Colors.black,
                    ),
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
              ],
            ),
          ),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }

  void _showCategoryBottomSheet(
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
        child: Obx(
          () => ListView.builder(
            shrinkWrap: true,
            itemCount: controller.categories.length,
            itemBuilder: (context, index) {
              final cat = controller.categories[index];
              return ListTile(
                title: Text(cat['name'] ?? ''),
                onTap: () {
                  controller.selectedCategoryName.value = cat['name'];
                  controller.selectedCategoryId.value = cat['_id'];
                  Get.back();
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void _showCityBottomSheet(
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
        child: Obx(
          () => ListView.builder(
            shrinkWrap: true,
            itemCount: controller.cities.length,
            itemBuilder: (context, index) {
              final city = controller.cities[index];
              return ListTile(
                title: Text("${city['city']}, ${city['country']}"),
                onTap: () {
                  controller.selectedCityName.value = city['city'];
                  controller.selectedCityId.value = city['_id'];
                  Get.back();
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildUploadBox(String label, File? file, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(10.r),
          dashPattern: [6, 4],
          color: const Color(0xFFECECF0),
          strokeWidth: 1.5,
          child: Container(
            height: 110.h,
            decoration: BoxDecoration(
              color: const Color(0xFFFAFAF7),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Center(
              child: file != null
                  ? Image.file(
                      file,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_photo_alternate_outlined,
                          color: Colors.grey.shade600,
                          size: 28.sp,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          label,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
