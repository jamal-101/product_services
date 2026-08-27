// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_instance/src/extension_instance.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// import 'package:product_service/features/profile_section/presentation/screen/store_creation/presentation/controller/suscription_controller.dart';
//
//
// class CreateNewStoreStep5 extends StatelessWidget {
//   final SubscriptionController controller = Get.put(SubscriptionController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         surfaceTintColor: Colors.white,
//         elevation: 0,
//         leading: Padding(
//           padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
//           child: GestureDetector(
//             onTap: () {
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
//           ],
//         ),
//       ), // আগের মতোই অ্যাপবার
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(20.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Store Publication Plan",
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
//             ),
//             Text(
//               "Pick a recurring plan to host your newly registered storefront.",
//               style: TextStyle(color: Colors.grey),
//             ),
//             SizedBox(height: 20.h),
//
//             // Plan Selection
//             Row(
//               children: [
//                 _buildPlanCard(
//                   "Starter",
//                   "\$19/m",
//                   "Perfect for single boutique launches.",
//                   false,
//                 ),
//                 SizedBox(width: 15.w),
//                 _buildPlanCard(
//                   "Growth",
//                   "\$49/m",
//                   "Custom domain integrations included.",
//                   true,
//                 ),
//               ],
//             ),
//
//             SizedBox(height: 25.h),
//             SizedBox(height: 40.h),
//             buildNextButton(() {
//             }),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPlanCard(
//       String title,
//       String price,
//       String desc,
//       bool isRecommended,
//       ) {
//     return Obx(() {
//       bool isSelected = controller.selectedPlan.value == title;
//       return Expanded(
//         child: GestureDetector(
//           onTap: () => controller.selectPlan(title),
//           child: Container(
//             padding: EdgeInsets.all(16.w),
//             decoration: BoxDecoration(
//               color: isSelected ? const Color(0xFFF9FBF9) : Colors.white, // সিলেক্টেড হলে হালকা সবুজ ব্যাকগ্রাউন্ড
//               border: Border.all(
//                 color: isSelected ? const Color(0xFF2A9B4A) : const Color(0xFFECECF0),
//                 width: 1.5,
//               ),
//               borderRadius: BorderRadius.circular(16.r),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 if (isRecommended)
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF2A9B4A),
//                       borderRadius: BorderRadius.circular(20.r),
//                     ),
//                     child: Text(
//                       "RECOMMENDED",
//                       style: TextStyle(fontSize: 8.sp, color: Colors.white, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 SizedBox(height: isRecommended ? 8.h : 0),
//                 Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
//                 SizedBox(height: 4.h),
//                 Text(price, style: TextStyle(color: const Color(0xFF2A9B4A), fontWeight: FontWeight.bold, fontSize: 14.sp)),
//                 SizedBox(height: 4.h),
//                 Text(desc, style: TextStyle(fontSize: 10.sp, color: Colors.grey.shade600), maxLines: 2, overflow: TextOverflow.ellipsis),
//               ],
//             ),
//           ),
//         ),
//       );
//     });
//   }
//
//
//
//   Widget buildNextButton(VoidCallback onTap, {String text = "Pay & Publish Store"}) {
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



import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:product_service/features/profile_section/presentation/screen/store_creation/presentation/controller/suscription_controller.dart';

class CreateNewStoreStep5 extends StatelessWidget {
  const CreateNewStoreStep5({super.key});

  @override
  Widget build(BuildContext context) {
    // কন্ট্রোলার ইনিশিয়ালাইজ
    final SubscriptionController controller = Get.put(SubscriptionController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5EF),
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
          ],
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator(color: Color(0xFF2A9B4A)));
        }

        if (controller.subscriptionList.isEmpty) {
          return const Center(child: Text("No subscription packages available"));
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Store Publication Plan",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
              ),
              Text(
                "Pick a recurring plan to host your newly registered storefront.",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 20.h),
              Row(
                children: controller.subscriptionList.map((plan) {
                  int index = controller.subscriptionList.indexOf(plan);
                  bool isRecommended = index == 1;

                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: index == 0 ? 15.w : 0),
                      child: _buildPlanCard(
                        controller,
                        plan.sId ?? "",
                        plan.name ?? "",
                        "\$${plan.price ?? 0}/m",
                        plan.features != null && plan.features!.isNotEmpty
                            ? plan.features!.first
                            : "Host your storefront seamlessly.",
                        isRecommended,
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 40.h),
              Obx(() => controller.isPurchasing.value
                  ? const Center(child: CircularProgressIndicator(color: Color(0xFF2A9B4A)))
                  : buildNextButton(() {
                controller.purchaseSubscription();
              })),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildPlanCard(
      SubscriptionController controller,
      String planId,
      String title,
      String price,
      String desc,
      bool isRecommended,
      ) {
    return Obx(() {
      bool isSelected = controller.selectedPlanId.value == planId;
      return GestureDetector(
        onTap: () => controller.selectPlan(planId, title),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFF9FBF9) : Colors.white,
            border: Border.all(
              color: isSelected ? const Color(0xFF2A9B4A) : const Color(0xFFECECF0),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isRecommended)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A9B4A),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    "RECOMMENDED",
                    style: TextStyle(fontSize: 8.sp, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              SizedBox(height: isRecommended ? 8.h : 0),
              Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
              SizedBox(height: 4.h),
              Text(price, style: TextStyle(color: const Color(0xFF2A9B4A), fontWeight: FontWeight.bold, fontSize: 14.sp)),
              SizedBox(height: 4.h),
              Text(desc, style: TextStyle(fontSize: 10.sp, color: Colors.grey.shade600), maxLines: 2, overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      );
    });
  }

  Widget buildNextButton(VoidCallback onTap, {String text = "Pay & Publish Store"}) {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF2A9B4A), Color(0xFF1F7A3A)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(10.r),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}