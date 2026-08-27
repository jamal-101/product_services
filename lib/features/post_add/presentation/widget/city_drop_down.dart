// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// import 'package:get/get_state_manager/src/simple/get_state.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:product_service/features/post_add/controller/post_add_controller.dart';
//
// class CityDropDown extends StatelessWidget {
//   const CityDropDown({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<PostAddController>(
//       builder: (controller) {
//         return Container(
//           height: 44.h,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             color: const Color(0xFFF7F7F7),
//             borderRadius: BorderRadius.circular(12.r),
//             border: Border.all(color: Color(0xFFE5E7EB), width: 1.w),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(left: 16.w),
//                 child: Obx(
//                   () => Text(
//                     controller.selectedCity.value,
//                     style: GoogleFonts.manrope(
//                       fontSize: 18.sp,
//                       fontWeight: FontWeight.w400,
//                       color: const Color(0xFF1A1D24),
//                     ),
//                   ),
//                 ),
//               ),
//               PopupMenuButton<City>(
//                 offset: Offset(0, 50.h),
//                 elevation: 2,
//                 color: Colors.white,
//                 surfaceTintColor: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12.r),
//                 ),
//                 icon: const Icon(
//                   Icons.keyboard_arrow_down,
//                   color: Color(0xFF9CA3AF),
//                 ),
//                 onSelected: (City value) {
//                   controller.updateSelectedGender(value);
//                 },
//                 itemBuilder: (context) => [
//                   _buildPopupItem(
//                     City.other,
//                     "Prefer not to say",
//                     showDivider: true,
//                   ),
//                   _buildPopupItem(City.dhaka, "Dhaka", showDivider: true),
//                   _buildPopupItem(City.chattogram, "Chattogram"),
//                 ].reversed.toList(),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   PopupMenuItem<City> _buildPopupItem(
//     City value,
//     String text, {
//     bool showDivider = false,
//   }) {
//     return PopupMenuItem(
//       value: value,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (showDivider) Divider(color: Colors.grey.shade200, thickness: 1),
//           Padding(
//             padding: EdgeInsets.symmetric(vertical: 4.h),
//             child: Text(
//               text,
//               style: GoogleFonts.manrope(
//                 fontSize: 14.sp,
//                 fontWeight: FontWeight.w400,
//                 color: Color(0xFF1A1D24),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
