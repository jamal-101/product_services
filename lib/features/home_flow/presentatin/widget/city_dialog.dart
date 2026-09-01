// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import '../controller/explore_store_controller.dart';
//
//
//
// class CityDialog extends StatelessWidget {
//   final String selectedCity;
//   final Function(String) onCitySelected;
//
//   const CityDialog({
//     super.key,
//     required this.selectedCity,
//     required this.onCitySelected
//   });
//
//   @override
//   Widget build(BuildContext context) {
//
//     final ExploreStoreController cityController = Get.put(ExploreStoreController());
//
//     return Container(
//       padding: EdgeInsets.only(top: 12.h),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             width: 40.w,
//             height: 4.h,
//             decoration: BoxDecoration(
//               color: Colors.grey.shade300,
//               borderRadius: BorderRadius.circular(2.r),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(20.w),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("Select City", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
//                     IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
//                   ],
//                 ),
//                 SizedBox(height: 10.h),
//
//                 // Obx ব্যবহার করে API ডেটা লোড হওয়া বা না হওয়ার স্টেট হ্যান্ডেল করা হলো
//                 Obx(() {
//                   if (cityController.isLoading.value) {
//                     return const Center(
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(vertical: 30.0),
//                         child: CircularProgressIndicator(color: Colors.green),
//                       ),
//                     );
//                   }
//
//                   if (cityController.cityList.isEmpty) {
//                     return const Center(
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(vertical: 20.0),
//                         child: Text("No cities found"),
//                       ),
//                     );
//                   }
//
//                   return Column(
//                     children: cityController.cityList.map((cityData) {
//                       String cityName = cityData.city ?? "";
//                       bool isSelected = cityName == selectedCity;
//                       return _buildCityOption(cityName, isSelected, context);
//                     }).toList(),
//                   );
//                 }),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildCityOption(String cityName, bool isSelected, BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         onCitySelected(cityName);
//         Navigator.pop(context);
//       },
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 6.h),
//         padding: EdgeInsets.all(12.w),
//         decoration: BoxDecoration(
//           border: Border.all(color: isSelected ? Colors.green : Colors.grey.shade300),
//           borderRadius: BorderRadius.circular(8.r),
//           color: isSelected ? Colors.green.shade50 : Colors.white,
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(cityName, style: TextStyle(color: isSelected ? Colors.green : Colors.black, fontWeight: FontWeight.bold)),
//             if (isSelected) const Icon(Icons.check, color: Colors.green, size: 18),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controller/explore_store_controller.dart';

class CityDialog extends StatelessWidget {
  final String selectedCity;
  final Function(String) onCitySelected;

  const CityDialog({
    super.key,
    required this.selectedCity,
    required this.onCitySelected,
  });

  @override
  Widget build(BuildContext context) {
    // কন্ট্রোলার ইনিশিয়ালাইজ করা
    final ExploreStoreController cityController = Get.find<ExploreStoreController>();

    return Container(
      padding: EdgeInsets.only(top: 12.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Select City", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                    IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
                  ],
                ),
                SizedBox(height: 10.h),

                // Obx ব্যবহার করে UI আপডেট হ্যান্ডেল করা
                Obx(() {
                  // ডিবাগ করার জন্য দেখতে পারেন লিস্টে ডেটা আসছে কিনা
                  debugPrint("City List Length: ${cityController.cityList.length}");

                  if (cityController.isLoading.value) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 30.0),
                        child: CircularProgressIndicator(color: Colors.green),
                      ),
                    );
                  }

                  if (cityController.cityList.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Text("No cities found"),
                      ),
                    );
                  }

                  return Column(
                    children: cityController.cityList.map((cityData) {
                      String cityName = cityData.city ?? "";
                      bool isSelected = cityName == selectedCity;
                      return _buildCityOption(cityName, isSelected, context);
                    }).toList(),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCityOption(String cityName, bool isSelected, BuildContext context) {
    return GestureDetector(
      onTap: () {
        onCitySelected(cityName);
        Navigator.pop(context);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          border: Border.all(color: isSelected ? Colors.green : Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8.r),
          color: isSelected ? Colors.green.shade50 : Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(cityName, style: TextStyle(color: isSelected ? Colors.green : Colors.black, fontWeight: FontWeight.bold)),
            if (isSelected) const Icon(Icons.check, color: Colors.green, size: 18),
          ],
        ),
      ),
    );
  }
}