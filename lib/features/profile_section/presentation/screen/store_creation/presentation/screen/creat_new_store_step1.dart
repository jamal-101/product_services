// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import '../widget/common_widget.dart';
// import 'creat_new_store_step2.dart';
//
// class CreateNewStoreStep1 extends StatefulWidget {
//   const CreateNewStoreStep1({super.key});
//
//   @override
//   State<CreateNewStoreStep1> createState() => _CreateNewStoreStep1State();
// }
//
// class _CreateNewStoreStep1State extends State<CreateNewStoreStep1> {
//
//   String selectedStoreType = "";
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//      appBar:  AppBar(
//         backgroundColor: Colors.white,
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
//               "Step 1 of 4",
//               style: TextStyle(color: Colors.grey, fontSize: 14.sp),
//             ),
//           ],
//         ),
//         bottom: PreferredSize(
//           preferredSize: Size.fromHeight(4.h),
//           child: LinearProgressIndicator(
//             value: 0.3,
//             backgroundColor: Colors.grey.shade200,
//             color: const Color(0xFF2A9B4A),
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(20.w),
//         child: Column(
//           children: [
//             const Text("Choose Store Type",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//             SizedBox(height: 10.h),
//             const Text("A store can only support either Products or Services, which helps buyers search accurately.",
//                 textAlign: TextAlign.center),
//             SizedBox(height: 30.h),
//             _buildStoreTypeCard("Product Store",
//                 "Best for tangible products like clothing, electronics, fashion accessories, furniture etc",
//                 Icons.shopping_bag,
//                 selectedStoreType == "Product"),
//             _buildStoreTypeCard("Service Store",
//                 "Best for professional skills, services, and reservations like photography, plumbing, cleaning, or repair.",
//                 Icons.build,
//                 selectedStoreType == "Service"),
//             Container(
//               padding: EdgeInsets.all(12.w),
//               decoration: BoxDecoration(color: Colors.amber.shade50,
//                   borderRadius: BorderRadius.circular(8.r)),
//               child: const Text("Notice: Payments are settled strictly outside of our platform directly via chat, cash, or invoice. We never ask for client transaction percentages."),
//             ),
//             const Spacer(),
//             buildNextButton(() {
//               if (selectedStoreType.isNotEmpty) {
//                 Get.to(() => const CreateNewStoreStep2());
//               } else {
//                 Get.snackbar("Required", "Please select a store type to continue");
//               }
//             }),
//           ],
//         ),
//       ),
//     );
//   }
//   Widget _buildStoreTypeCard(String title, String description, IconData icon, bool isSelected) {
//     return InkWell(
//       onTap: () {
//         setState(() {
//           selectedStoreType = title.contains("Product") ? "Product" : "Service";
//         });
//       },
//       child: Container(
//         margin: EdgeInsets.only(bottom: 15.h),
//         padding: EdgeInsets.all(15.w),
//         decoration: BoxDecoration(
//           color: isSelected ? const Color(0xFFF1FDF5) : Colors.transparent,
//           border: Border.all(
//               color: isSelected ? const Color(0xFF27AE60) : Colors.grey.shade300,
//               width: isSelected ? 2 : 1
//           ),
//           borderRadius: BorderRadius.circular(10.r),
//         ),
//         child: Row(
//           children: [
//             Icon(icon, size: 30, color: isSelected ? const Color(0xFF27AE60) : Colors.grey),
//             SizedBox(width: 15.w),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
//                   Text(description, style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600)),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controller/store_creation_controller.dart'; // আপনার কন্ট্রোলার পাথ দিন
import '../widget/common_widget.dart';
import 'creat_new_store_step2.dart';

class CreateNewStoreStep1 extends StatelessWidget {
  CreateNewStoreStep1({super.key});

  final StoreCreationController controller = Get.put(StoreCreationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
            const Text("Create New Store", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
            Text("Step 1 of 4", style: TextStyle(color: Colors.grey, fontSize: 14.sp)),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.h),
          child: LinearProgressIndicator(
            value: 0.3,
            backgroundColor: Colors.grey.shade200,
            color: const Color(0xFF2A9B4A),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            const Text("Choose Store Type", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 10.h),
            const Text("A store can only support either Products or Services, which helps buyers search accurately.", textAlign: TextAlign.center),
            SizedBox(height: 30.h),
            Obx(() => _buildStoreTypeCard("Product Store", "Best for tangible products like clothing, electronics, fashion accessories, furniture etc", Icons.shopping_bag, controller.selectedStoreType.value == "product_store", "product_store")),
            Obx(() => _buildStoreTypeCard("Service Store", "Best for professional skills, services, and reservations like photography, plumbing, cleaning, or repair.", Icons.build, controller.selectedStoreType.value == "service_store", "service_store")),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(8.r)),
              child: const Text("Notice: Payments are settled strictly outside of our platform directly via chat, cash, or invoice. We never ask for client transaction percentages."),
            ),
            const Spacer(),
            buildNextButton(() {
              if (controller.selectedStoreType.value.isNotEmpty) {
                Get.to(() => const CreateNewStoreStep2());
              } else {
                Get.snackbar("Required", "Please select a store type to continue");
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildStoreTypeCard(String title, String description, IconData icon, bool isSelected, String typeValue) {
    return InkWell(
      onTap: () => controller.selectedStoreType.value = typeValue,
      child: Container(
        margin: EdgeInsets.only(bottom: 15.h),
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF1FDF5) : Colors.transparent,
          border: Border.all(color: isSelected ? const Color(0xFF27AE60) : Colors.grey.shade300, width: isSelected ? 2 : 1),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            Icon(icon, size: 30, color: isSelected ? const Color(0xFF27AE60) : Colors.grey),
            SizedBox(width: 15.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
                  Text(description, style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}