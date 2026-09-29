// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import '../../../../../../../utils/constants/app_color.dart';
// import '../widget/common_widget.dart';
// import 'creat_new_store_step4.dart';
//
// class CreateNewStoreStep3 extends StatelessWidget {
//   const CreateNewStoreStep3({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColor.appBackgroundColor,
//         surfaceTintColor: AppColor.appBackgroundColor,
//         elevation: 0,
//         leading: Padding(
//           padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
//           child: Container(
//             decoration: BoxDecoration(
//               color: const Color(0xFFF7F7F2),
//               borderRadius: BorderRadius.circular(12.r),
//             ),
//             child: GestureDetector(
//               onTap: (){
//                 Get.back();
//               },
//               child: Container(
//                 height: 36.h,
//                 width: 36.w,
//                 decoration: BoxDecoration(
//                   color: Color(0xFFF5F5EF),
//                   borderRadius: BorderRadius.circular(12.r),
//                 ),
//                 child: Icon(Icons.arrow_back, color: Colors.black, size: 20.sp),
//               ),
//             ),
//           ),
//         ),
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text(
//               "Create New Store",
//               style: TextStyle(
//                 color: Color(0xFF1A1D24),
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             Text(
//               "Step 3 of 4",
//               style: TextStyle(color: Color(0xFF7A818F), fontSize: 14.sp),
//             ),
//           ],
//         ),
//         bottom: PreferredSize(
//           preferredSize: Size.fromHeight(4.h),
//           child: LinearProgressIndicator(
//             value: 0.7,
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
//               "Contact Details",
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
//             ),
//             Text(
//               "How can customers and our team reach you?",
//               style: TextStyle(color: Colors.grey),
//             ),
//             SizedBox(height: 20.h),
//
//             _buildLabel("Phone Number *"),
//             _buildTextField("+880 1XXX XXX XXX"),
//             _buildLabel("WhatsApp"),
//                 // Row(
//                 //   children: [
//                 //     Text(
//                 //       "Same as phone number",
//                 //       style: TextStyle(
//                 //         fontSize: 14.sp,
//                 //         color: Color(0xFF7A818F),
//                 //       ),
//                 //     ),
//                 //     Obx(
//                 //           () => Transform.scale(
//                 //         scale: 0.70,
//                 //         child: Switch(
//                 //           value: controller.isWhatsAppSameAsPhone.value,
//                 //           activeColor: Colors.white,
//                 //           activeTrackColor: const Color(0xFF2A9B4A),
//                 //           inactiveTrackColor: const Color(0xFFE5E5E5),
//                 //           inactiveThumbColor: Colors.white,
//                 //           onChanged: (val) {
//                 //             controller.toggleWhatsApp(val);
//                 //           },
//                 //         ),
//                 //       ),
//                 //     ),
//                 //   ],
//                 // ),
//
//             _buildTextField("+880 1XXX XXX XXX"),
//
//             _buildLabel("Email Address *"),
//             _buildTextField(
//               "shop@example.com",
//               prefixIcon: Icons.email_outlined,
//             ),
//
//             SizedBox(height: 20.h),
//             _buildLabel("Location *"),
//             Container(
//               padding: EdgeInsets.all(12.w),
//               decoration: BoxDecoration(
//                 border: Border.all(color: const Color(0xFFECECF0)),
//                 borderRadius: BorderRadius.circular(12.r),
//               ),
//               child: Center(
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Text("Select Location"),
//                     SizedBox(width: 110.w),
//                     Icon(Icons.keyboard_arrow_down_outlined)
//                   ],
//                 ),
//               ),
//             ),
//
//             SizedBox(height: 30.h),
//             buildNextButton(() {
//               Get.to(() => const CreateNewStoreStep4());
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
//   Widget _buildTextField(String hint, {IconData? prefixIcon}) => TextField(
//     decoration: InputDecoration(
//       filled: true,
//       fillColor: Color(0xFFFFFFFF),
//       hintText: hint,
//       prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: 20.sp) : null,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12.r),
//         borderSide: const BorderSide(color: Color(0xFFECECF0)),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12.r),
//         borderSide: const BorderSide(color: Color(0xFFECECF0)),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12.r),
//         borderSide: const BorderSide(color: Color(0xFFECECF0)),
//       ),
//       contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
//     ),
//   );
//
//   Widget _buildMapBox() {
//     return Container(
//       margin: EdgeInsets.only(top: 15.h),
//       child: DottedBorder(
//         borderType: BorderType.RRect,
//         radius: Radius.circular(12.r),
//         dashPattern: [6, 4],
//         color: const Color(0xFFECECF0),
//         strokeWidth: 1.5,
//         child: Container(
//           width: double.infinity,
//           padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
//           decoration: BoxDecoration(
//             color: const Color(0xFFFAFAFA),
//             borderRadius: BorderRadius.circular(12.r),
//           ),
//           child: Column(
//             children: [
//               Icon(
//                 Icons.map_outlined,
//                 color: Colors.grey.shade500,
//                 size: 28.sp,
//               ),
//               SizedBox(height: 10.h),
//               Text(
//                 "Pin exact location on map",
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 14.sp,
//                   color: Colors.black,
//                 ),
//               ),
//               SizedBox(height: 6.h),
//               Text(
//                 "Drag the pin to your store's precise location",
//                 style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade500),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../../utils/constants/app_color.dart';
import '../controller/store_creation_controller.dart';
import '../widget/common_widget.dart';
import 'creat_new_store_step4.dart';

class CreateNewStoreStep3 extends StatelessWidget {
  const CreateNewStoreStep3({super.key});

  @override
  Widget build(BuildContext context) {
    final StoreCreationController controller = Get.find<StoreCreationController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.appBackgroundColor,
        surfaceTintColor: AppColor.appBackgroundColor,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              height: 36.h,
              width: 36.w,
              decoration: BoxDecoration(color: const Color(0xFFF5F5EF), borderRadius: BorderRadius.circular(12.r)),
              child: Icon(Icons.arrow_back, color: Colors.black, size: 20.sp),
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Create New Store", style: TextStyle(color: Color(0xFF1A1D24), fontWeight: FontWeight.w600)),
            Text("Step 3 of 4", style: TextStyle(color: Color(0xFF7A818F), fontSize: 14.sp)),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.h),
          child: LinearProgressIndicator(value: 0.7, backgroundColor: Colors.grey.shade200, color: const Color(0xFF2A9B4A)),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Contact Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
            Text("How can customers and our team reach you?", style: TextStyle(color: Colors.grey)),
            SizedBox(height: 20.h),

            _buildLabel("Phone Number *"),
            _buildTextField("+880 1XXX XXX XXX", controller.phoneController),
            _buildLabel("WhatsApp"),
                // Row(
                //   children: [
                //     Text("Same as phone number", style: TextStyle(fontSize: 12.sp, color: Color(0xFF7A818F))),
                //     Obx(
                //           () => Transform.scale(
                //         scale: 0.70,
                //         child: Switch(
                //           value: controller.isWhatsAppSameAsPhone.value,
                //           activeColor: Colors.white,
                //           activeTrackColor: const Color(0xFF2A9B4A),
                //           onChanged: (val) => controller.toggleWhatsApp(val),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),

            _buildTextField("+880 1XXX XXX XXX", controller.whatsappController),

            _buildLabel("Email Address *"),
            _buildTextField("shop@example.com", controller.emailController, prefixIcon: Icons.email_outlined),

            SizedBox(height: 30.h),
            buildNextButton(() {
              Get.to(() => const CreateNewStoreStep4());
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

  Widget _buildTextField(String hint, TextEditingController textController, {IconData? prefixIcon}) => TextField(
    controller: textController,
    decoration: InputDecoration(
      filled: true,
      fillColor: const Color(0xFFFFFFFF),
      hintText: hint,
      prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: 20.sp) : null,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: Color(0xFFECECF0))),
    ),
  );
}