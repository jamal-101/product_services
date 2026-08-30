// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'contuctForm_widget.dart';
//
//
// class AboutWidget extends StatelessWidget {
//   const AboutWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         SingleChildScrollView(
//           padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.w, bottom: 100.h),
//           child: Column(
//             children: [
//               _buildInfoContainer(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("About", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
//                     SizedBox(height: 8.h),
//                     Text("Anytime Electronics is Madrid's premier tech destination. Founded in 2012, we offer the latest gadgets, appliances, and accessories from top brands at competitive prices. Our expert staff are always on hand to help you find the perfect device.",
//                         style: TextStyle(color: Colors.grey[600], fontSize: 13.sp)),
//                     SizedBox(height: 8.h),
//                     Text("Read more →", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 13.sp)),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 16.h),
//               _buildInfoContainer(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Contact", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
//                     SizedBox(height: 12.h),
//                     _buildContactRow(Icons.location_on_outlined, "Calle Gran Vía 32, Madrid"),
//                     _buildContactRow(Icons.phone_outlined, "+34 912 345 678"),
//                     _buildContactRow(Icons.email_outlined, "info@leve.com"),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 16.h),
//               Container(
//                 padding: EdgeInsets.all(12.w),
//                 decoration: BoxDecoration(
//                   color: Colors.green[50],
//                   borderRadius: BorderRadius.circular(12.r),
//                   border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
//                 ),
//                 child: Row(
//                   children: [
//                     const Icon(Icons.check_circle_outline, color: Colors.green),
//                     SizedBox(width: 10.w),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("Verified Store", style: TextStyle(color: Colors.green[800], fontWeight: FontWeight.bold)),
//                         Text("Identity and business documents verified", style: TextStyle(fontSize: 11.sp, color: Colors.green[700])),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Positioned(
//           bottom: 16.h,
//           left: 16.w,
//           right: 16.w,
//           child: const ContactFooterWidget(),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildInfoContainer({required Widget child}) {
//     return Container(
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12.r),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: child,
//     );
//   }
//
//   Widget _buildContactRow(IconData icon, String text) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 6.h),
//       child: Row(
//         children: [
//           Icon(icon, size: 18.sp, color: Colors.grey),
//           SizedBox(width: 10.w),
//           Text(text, style: TextStyle(fontSize: 13.sp, color: Colors.grey[700])),
//         ],
//       ),
//     );
//   }
// }
//

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controller/store_details_controller.dart';
import 'contuctForm_widget.dart';

class AboutWidget extends StatelessWidget {
  const AboutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final StoreDetailsController controller = Get.find<StoreDetailsController>();

    return Obx(() {
      final store = controller.storeDetailsModel.value.data?.store;

      return Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.w, bottom: 100.h),
            child: Column(
              children: [
                _buildInfoContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("About", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8.h),
                      Text(
                        store?.description ?? "No description available for this store.",
                        style: TextStyle(color: Colors.grey[600], fontSize: 13.sp),
                      ),
                      SizedBox(height: 8.h),
                      Text("Read more →", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 13.sp)),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                _buildInfoContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Contact", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                      SizedBox(height: 12.h),
                      _buildContactRow(Icons.location_on_outlined, store?.displayName ?? "Madrid, Spain"),
                      _buildContactRow(Icons.phone_outlined, store?.phone ?? "+34 000 000 000"),
                      _buildContactRow(Icons.email_outlined, store?.email ?? "info@store.com"),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle_outline, color: Colors.green),
                      SizedBox(width: 10.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Verified Store", style: TextStyle(color: Colors.green[800], fontWeight: FontWeight.bold)),
                          Text("Identity and business documents verified", style: TextStyle(fontSize: 11.sp, color: Colors.green[700])),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16.h,
            left: 16.w,
            right: 16.w,
            child: const ContactFooterWidget(),
          ),
        ],
      );
    });
  }

  Widget _buildInfoContainer({required Widget child}) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: child,
    );
  }

  Widget _buildContactRow(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Icon(icon, size: 18.sp, color: Colors.grey),
          SizedBox(width: 10.w),
          Text(text, style: TextStyle(fontSize: 13.sp, color: Colors.grey[700])),
        ],
      ),
    );
  }
}
