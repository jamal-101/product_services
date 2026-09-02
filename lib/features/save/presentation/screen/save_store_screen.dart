// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../../controller/save_controller.dart';
//
//
// class SaveStoreScreen extends StatelessWidget {
//   const SaveStoreScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final SaveController controller = Get.put(SaveController());
//
//     return Scaffold(
//       backgroundColor: const Color(0xFFF9FAFB),
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: Padding(
//           padding: EdgeInsets.all(8.r),
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.grey.shade100,
//               borderRadius: BorderRadius.circular(12.r),
//             ),
//             child: IconButton(
//               icon: const Icon(Icons.arrow_back, color: Colors.black),
//               onPressed: () => Get.back(),
//             ),
//           ),
//         ),
//         title: Text(
//           "Saved",
//           style: GoogleFonts.montserrat(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//             fontSize: 18.sp,
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             SizedBox(height: 12.h),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16.w),
//               child: Container(
//                 padding: EdgeInsets.all(4.r),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFF3F4F6),
//                   borderRadius: BorderRadius.circular(16.r),
//                   border: Border.all(color: const Color(0xFFE5E7EB)),
//                 ),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: _buildTabButton(
//                         controller: controller,
//                         title: "Products Stores",
//                         icon: Icons.shopping_bag_outlined,
//                         index: 0,
//                       ),
//                     ),
//                     Expanded(
//                       child: _buildTabButton(
//                         controller: controller,
//                         title: "Services Providers",
//                         icon: Icons.design_services_outlined,
//                         index: 1,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 16.h),
//
//             Expanded(
//               child: Obx(() {
//                 bool isProductTab = controller.selectedTab.value == 0;
//
//                 return ListView(
//                   physics: const BouncingScrollPhysics(),
//                   padding: EdgeInsets.symmetric(horizontal: 16.w),
//                   children: isProductTab
//                       ? [
//                     _buildStoreCard(
//                       imageColor: Colors.deepOrange,
//                       title: "Anytime",
//                       category: "Electronics • 📍 Barcelona",
//                       rating: "4.9",
//                       isSaved: true,
//                     ),
//                     SizedBox(height: 12.h),
//                     _buildStoreCard(
//                       imageColor: Colors.red.shade800,
//                       title: "Cocacola",
//                       category: "Food • 📍 Barcelona",
//                       rating: "4.9",
//                       isSaved: true,
//                     ),
//                     SizedBox(height: 12.h),
//                     _buildStoreCard(
//                       imageColor: Colors.blue.shade900,
//                       title: "Dove",
//                       category: "Electronics • 📍 Barcelona",
//                       rating: "4.9",
//                       isSaved: true,
//                     ),
//                     SizedBox(height: 12.h),
//                     _buildStoreCard(
//                       imageColor: const Color(0xFF064E3B),
//                       title: "Healexir",
//                       category: "Electronics • 📍 Barcelona",
//                       rating: "4.9",
//                       isSaved: true,
//                     ),
//                     SizedBox(height: 12.h),
//                     _buildStoreCard(
//                       imageColor: Colors.grey.shade900,
//                       title: "Samsung",
//                       category: "Electronics • 📍 Barcelona",
//                       rating: "4.9",
//                       isSaved: true,
//                     ),
//                     SizedBox(height: 12.h),
//                     _buildStoreCard(
//                       imageColor: Colors.grey.shade800,
//                       title: "Sony",
//                       category: "Electronics • 📍 Barcelona",
//                       rating: "4.9",
//                       isSaved: true,
//                     ),
//                   ]
//                       : [
//                     _buildStoreCard(
//                       imageColor: Colors.amber.shade800,
//                       title: "Handyman",
//                       category: "Home Repairs • 📍 Barcelona",
//                       rating: "4.9",
//                       isSaved: false,
//                     ),
//                     SizedBox(height: 12.h),
//                     _buildStoreCard(
//                       imageColor: Colors.blueAccent,
//                       title: "Cocacola",
//                       category: "Electrician • 📍 Barcelona",
//                       rating: "4.9",
//                       isSaved: true,
//                     ),
//                     SizedBox(height: 12.h),
//                     _buildStoreCard(
//                       imageColor: Colors.green,
//                       title: "Jones Exterior",
//                       category: "Cleaning Services • 📍 Barcelona",
//                       rating: "4.9",
//                       isSaved: false,
//                     ),
//                     SizedBox(height: 12.h),
//                     _buildStoreCard(
//                       imageColor: const Color(0xFF064E3B),
//                       title: "Healexir",
//                       category: "Electronics • 📍 Barcelona",
//                       rating: "4.9",
//                       isSaved: true,
//                     ),
//                     SizedBox(height: 12.h),
//                     _buildStoreCard(
//                       imageColor: Colors.grey.shade900,
//                       title: "Samsung",
//                       category: "Electronics • 📍 Barcelona",
//                       rating: "4.9",
//                       isSaved: true,
//                     ),
//                   ],
//                 );
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ট্যাব বাটন উইজেট
//   Widget _buildTabButton({
//     required SaveController controller,
//     required String title,
//     required IconData icon,
//     required int index,
//   }) {
//     return Obx(() {
//       bool isSelected = controller.selectedTab.value == index;
//       return GestureDetector(
//         onTap: () => controller.changeTab(index),
//         child: Container(
//           padding: EdgeInsets.symmetric(vertical: 10.h),
//           decoration: BoxDecoration(
//             color: isSelected ? Colors.white : Colors.transparent,
//             borderRadius: BorderRadius.circular(12.r),
//             boxShadow: isSelected
//                 ? [
//               BoxShadow(
//                 color: Colors.black.withValues(alpha: 0.05),
//                 blurRadius: 4,
//                 offset: const Offset(0, 2),
//               )
//             ]
//                 : [],
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 icon,
//                 size: 16.sp,
//                 color: isSelected ? Colors.black : Colors.grey.shade600,
//               ),
//               SizedBox(width: 6.w),
//               Text(
//                 title,
//                 style: GoogleFonts.plusJakartaSans(
//                   fontSize: 12.sp,
//                   fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
//                   color: isSelected ? Colors.black : Colors.grey.shade600,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
//
//
//   Widget _buildStoreCard({
//     required Color imageColor,
//     required String title,
//     required String category,
//     required String rating,
//     required bool isSaved,
//   }) {
//     return Container(
//       padding: EdgeInsets.all(12.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16.r),
//         border: Border.all(color: const Color(0xFFF3F4F6)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.02),
//             blurRadius: 6,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             height: 52.h,
//             width: 52.w,
//             decoration: BoxDecoration(
//               color: imageColor,
//               borderRadius: BorderRadius.circular(12.r),
//             ),
//             child: Center(
//               child: Text(
//                 title[0],
//                 style: GoogleFonts.plusJakartaSans(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 20.sp,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(width: 12.w),
//
//           // টাইপ ও ক্যাটাগরি
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: GoogleFonts.plusJakartaSans(
//                     fontSize: 15.sp,
//                     fontWeight: FontWeight.bold,
//                     color: const Color(0xFF111827),
//                   ),
//                 ),
//                 SizedBox(height: 4.h),
//                 Text(
//                   category,
//                   style: GoogleFonts.plusJakartaSans(
//                     fontSize: 12.sp,
//                     color: Colors.grey.shade500,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           // রেটিং এবং বুকমার্ক আইকন
//           Column(
//             // crossAxisAlignment: End,
//             children: [
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFFEF3C7),
//                   borderRadius: BorderRadius.circular(6.r),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(Icons.star, size: 12.sp, color: Colors.amber.shade800),
//                     SizedBox(width: 2.w),
//                     Text(
//                       rating,
//                       style: GoogleFonts.plusJakartaSans(
//                         fontSize: 11.sp,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.amber.shade900,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 12.h),
//               Icon(
//                 isSaved ? Icons.bookmark : Icons.bookmark_border,
//                 size: 20.sp,
//                 color: isSaved ? Colors.orange.shade700 : Colors.grey.shade400,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/save_controller.dart';

class SaveStoreScreen extends StatelessWidget {
  const SaveStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SaveController controller = Get.put(SaveController());

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(8.r),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Get.back(),
            ),
          ),
        ),
        title: Text(
          "Saved",
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                padding: EdgeInsets.all(4.r),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildTabButton(
                        controller: controller,
                        title: "Products Stores",
                        icon: Icons.shopping_bag_outlined,
                        index: 0,
                      ),
                    ),
                    Expanded(
                      child: _buildTabButton(
                        controller: controller,
                        title: "Services Providers",
                        icon: Icons.design_services_outlined,
                        index: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),

            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.favoriteStoreList.isEmpty) {
                  return Center(
                    child: Text(
                      "No saved stores found",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14.sp,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: controller.favoriteStoreList.length,
                  itemBuilder: (context, index) {
                    var item = controller.favoriteStoreList[index];
                    var store = item.targetId;
                    String categoryName = store?.categoryId?.name ?? "Store";
                    String cityName = store?.cityId?.city ?? store?.city ?? "Barcelona";
                    String categoryText = "$categoryName • 📍 $cityName";
                    String ratingVal = (store?.averageRating != null)
                        ? store!.averageRating.toString()
                        : "4.9";
                    String titleText = store?.displayName ?? "Store Name";
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: _buildStoreCard(
                        imageColor: _getStoreColor(index),
                        title: titleText,
                        category: categoryText,
                        rating: ratingVal,
                        isSaved: true,
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildTabButton({
    required SaveController controller,
    required String title,
    required IconData icon,
    required int index,
  }) {
    return Obx(() {
      bool isSelected = controller.selectedTab.value == index;
      return GestureDetector(
        onTap: () => controller.changeTab(index),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: isSelected
                ? [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              )
            ]
                : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16.sp,
                color: isSelected ? Colors.black : Colors.grey.shade600,
              ),
              SizedBox(width: 6.w),
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12.sp,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: isSelected ? Colors.black : Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  // স্টোর কার্ড উইজেট (আপনার অরিজিনাল ডিজাইন অপরিবর্তিত রাখা হয়েছে)
  Widget _buildStoreCard({
    required Color imageColor,
    required String title,
    required String category,
    required String rating,
    required bool isSaved,
  }) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFF3F4F6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 52.h,
            width: 52.w,
            decoration: BoxDecoration(
              color: imageColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: Text(
                title.isNotEmpty ? title[0].toUpperCase() : "S",
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),

          // টাইপ ও ক্যাটাগরি
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF111827),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  category,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12.sp,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),

          // রেটিং এবং বুকমার্ক আইকন
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.star, size: 12.sp, color: Colors.amber.shade800),
                    SizedBox(width: 2.w),
                    Text(
                      rating,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber.shade900,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              Icon(
                isSaved ? Icons.bookmark : Icons.bookmark_border,
                size: 20.sp,
                color: isSaved ? Colors.orange.shade700 : Colors.grey.shade400,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStoreColor(int index) {
    List<Color> colors = [
      Colors.deepOrange,
      Colors.red.shade800,
      Colors.blue.shade900,
      const Color(0xFF064E3B),
      Colors.grey.shade900,
      Colors.amber.shade800,
      Colors.green,
    ];
    return colors[index % colors.length];
  }
}