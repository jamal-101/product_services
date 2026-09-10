// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../../services/api/api_service.dart';
// import '../../../../../services/storage/storage_service.dart';
// import '../../../../../utils/constants/api_enpoint.dart';
//
// class FavouriteController extends GetxController {
//   var isLoading = false.obs;
//
//   // Favorite Toggle API Method
//   Future<void> toggleFavorite({
//     required String targetId,
//     required String targetType, // যেমন: "service", "product", "product_store", "service_store"
//   }) async {
//     try {
//       isLoading.value = true;
//
//       final body = {
//         "targetId": targetId,
//         "targetType": targetType,
//       };
//
//       final response = await ApiService.post(
//         ApiEndPoint.favoritesToggle, // আপনার ApiEndPoint ফাইলে এই এন্ডপয়েন্টটি অ্যাড করা থাকতে হবে
//         body: body,
//         header: {
//           'Authorization': 'Bearer ${LocalStorage.token}',
//           'Content-Type': 'application/json',
//         },
//       );
//
//       if (response.isSuccess) {
//         // সফল হলে মেসেজ দেখাতে পারেন বা স্টেট আপডেট করতে পারেন
//         Get.snackbar(
//           "Success",
//           response.message ?? "Favorite updated successfully",
//           backgroundColor: Colors.green,
//           colorText: Colors.white,
//         );
//       } else {
//         Get.snackbar(
//           "Error",
//           response.message ?? "Something went wrong",
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//         );
//       }
//     } catch (e) {
//       debugPrint("Error toggling favorite: $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }