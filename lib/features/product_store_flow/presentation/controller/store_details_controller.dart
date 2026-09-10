// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../services/api/api_service.dart';
// import '../../../../utils/constants/api_enpoint.dart';
// import '../model/store_details_model.dart';
//
// class StoreDetailsController extends GetxController {
//   var isLoading = false.obs;
//   var storeDetailsModel = StoreDetailsModel().obs;
//   var isFavorite = false.obs;
//   var favoriteItemIds = <String>{}.obs;
//
//
//   void clearData() {
//     storeDetailsModel.value = StoreDetailsModel();
//     isFavorite.value = false;
//     favoriteItemIds.clear();
//   }
//
//   Future<void> fetchStoreDetails(String storeId) async {
//     try {
//       isLoading.value = true;
//
//       final response = await ApiService.get('${ApiEndPoint.stores}/$storeId');
//
//       if (response.isSuccess) {
//         debugPrint("API Response Body: ${response.data}");
//         if (response.data is Map<String, dynamic>) {
//           storeDetailsModel.value = StoreDetailsModel.fromJson(response.data as Map<String, dynamic>);
//           final store = storeDetailsModel.value.data?.store;
//           if (store != null) {
//             isFavorite.value = store.isFavorite ?? false;
//             debugPrint("Updated isFavorite value from server: ${isFavorite.value}");
//           }
//           favoriteItemIds.clear();
//           if (model.data?.products != null) {
//             for (var p in model.data!.products!) {
//               if (p.isFavorite == true && p.sId != null) {
//                 favoriteItemIds.add(p.sId!);
//               }
//             }
//           }
//           if (model.data?.services != null) {
//             for (var s in model.data!.services!) {
//               if (s.isFavorite == true && s.sId != null) {
//                 favoriteItemIds.add(s.sId!);
//               }
//             }
//           }
//
//         } else {
//           debugPrint("Error: Response data is null or not in expected format.");
//           Get.snackbar("Warning", "Invalid data format received from server.");
//         }
//       } else {
//         debugPrint("API Failed with status message: ${response.message}");
//         Get.snackbar(
//           "Failed",
//           response.message,
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//         );
//       }
//     } catch (e, stackTrace) {
//       debugPrint("Exception caught while fetching store details: $e");
//       debugPrint("StackTrace: $stackTrace");
//
//       Get.snackbar(
//         "Error",
//         "Something went wrong. Please try again later.",
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//
//   Future<void> toggleFavorite(String storeId, String storeType) async {
//     final bool previousState = isFavorite.value;
//
//     try {
//       isFavorite.value = !previousState;
//
//       final store = storeDetailsModel.value.data?.store;
//       if (store != null) {
//         store.isFavorite = isFavorite.value;
//       }
//
//       String targetType = storeType.toLowerCase().contains('product')
//           ? "product_store"
//           : "service_store";
//
//       final body = {
//         "targetId": storeId,
//         "targetType": targetType,
//       };
//
//       // ৩. সার্ভারে রিকোয়েস্ট পাঠাই
//       final response = await ApiService.post(
//         ApiEndPoint.favoritesToggle,
//         body: body,
//       );
//
//       if (response.isSuccess) {
//         // ৪. সার্ভার থেকে সফল রেসপন্স আসলে চেক করব সার্ভার আসলেই কী স্ট্যাটাস দিয়েছে
//         final responseData = response.data;
//         if (responseData is Map<String, dynamic>) {
//           // ব্যাকএন্ড রেসপন্সের ফরম্যাট অনুযায়ী 'isFavorited' অথবা 'isFavorite' কী (key) থাকতে পারে
//           // আপনার ব্যাকএন্ড যদি ডাটা অবজেক্টের ভেতর পাঠায় কিংবা সরাসরি পাঠায় সেভাবে হ্যান্ডেল করা হলো:
//           final dynamic innerData = responseData['data'];
//
//           bool? serverStatus;
//           if (innerData is Map<String, dynamic>) {
//             serverStatus = innerData['isFavorited'] ?? innerData['isFavorite'];
//           } else {
//             serverStatus = responseData['isFavorited'] ?? responseData['isFavorite'];
//           }
//
//           // যদি সার্ভার থেকে সঠিক স্ট্যাটাস পাওয়া যায়, কেবল তখনই সেটি ফিক্সড করব
//           if (serverStatus != null) {
//             isFavorite.value = serverStatus;
//             if (store != null) {
//               store.isFavorite = serverStatus;
//             }
//           }
//         }
//       } else {
//         // ৫. এপিআই ফেইল করলে আগের স্টেটে ফেরত নিয়ে যাবো (Rollback)
//         isFavorite.value = previousState;
//         if (store != null) {
//           store.isFavorite = previousState;
//         }
//         debugPrint("Failed to update favorite status: ${response.message}");
//       }
//     } catch (e) {
//       // ৬. কোনো এক্সেপশন বা এরর আসলেও আগের স্টেটে ফেরত যাবো
//       isFavorite.value = previousState;
//       final store = storeDetailsModel.value.data?.store;
//       if (store != null) {
//         store.isFavorite = previousState;
//       }
//       debugPrint("Error toggling store favorite: $e");
//     }
//   }
//
//   var favoriteItemIds = <String>{}.obs;
//
//   bool isItemFavorite(String itemId) {
//     return favoriteItemIds.contains(itemId);
//   }
//
//   Future<void> toggleItemFavorite(String itemId, String itemType) async {
//     try {
//       if (favoriteItemIds.contains(itemId)) {
//         favoriteItemIds.remove(itemId);
//       } else {
//         favoriteItemIds.add(itemId);
//       }
//
//       final body = {
//         "targetId": itemId,
//         "targetType": itemType,
//       };
//
//       final response = await ApiService.post(
//         ApiEndPoint.favoritesToggle,
//         body: body,
//       );
//
//       if (!response.isSuccess) {
//         if (favoriteItemIds.contains(itemId)) {
//           favoriteItemIds.remove(itemId);
//         } else {
//           favoriteItemIds.add(itemId);
//         }
//       }
//     } catch (e) {
//       debugPrint("Error toggling item favorite: $e");
//     }
//   }
//
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../services/api/api_service.dart';
import '../../../../utils/constants/api_enpoint.dart';
import '../model/store_details_model.dart';

class StoreDetailsController extends GetxController {
  var isLoading = false.obs;
  var storeDetailsModel = StoreDetailsModel().obs;
  var isFavorite = false.obs;
  var favoriteItemIds = <String>{}.obs;

  void clearData() {
    storeDetailsModel.value = StoreDetailsModel();
    isFavorite.value = false;
    favoriteItemIds.clear();
  }

  Future<void> fetchStoreDetails(String storeId) async {
    try {
      isLoading.value = true;

      final response = await ApiService.get('${ApiEndPoint.stores}/$storeId');

      if (response.isSuccess) {
        debugPrint("API Response Body: ${response.data}");
        if (response.data is Map<String, dynamic>) {
          // Parse model and assign to reactive variable
          final model = StoreDetailsModel.fromJson(response.data as Map<String, dynamic>);
          storeDetailsModel.value = model;

          final store = model.data?.store;
          if (store != null) {
            isFavorite.value = store.isFavorite ?? false;
            debugPrint("Updated isFavorite value from server: ${isFavorite.value}");
          }

          // Sync product and service favorites
          favoriteItemIds.clear();

          if (model.data?.products != null) {
            for (var p in model.data!.products!) {
              if (p.isFavorite == true && p.sId != null) {
                favoriteItemIds.add(p.sId!);
              }
            }
          }

          if (model.data?.services != null) {
            for (var s in model.data!.services!) {
              if (s.isFavorite == true && s.sId != null) {
                favoriteItemIds.add(s.sId!);
              }
            }
          }

        } else {
          debugPrint("Error: Response data is null or not in expected format.");
          Get.snackbar("Warning", "Invalid data format received from server.");
        }
      } else {
        debugPrint("API Failed with status message: ${response.message}");
        Get.snackbar(
          "Failed",
          response.message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e, stackTrace) {
      debugPrint("Exception caught while fetching store details: $e");
      debugPrint("StackTrace: $stackTrace");

      Get.snackbar(
        "Error",
        "Something went wrong. Please try again later.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> toggleFavorite(String storeId, String storeType) async {
    final bool previousState = isFavorite.value;

    try {
      isFavorite.value = !previousState;

      final store = storeDetailsModel.value.data?.store;
      if (store != null) {
        store.isFavorite = isFavorite.value;
      }

      String targetType = storeType.toLowerCase().contains('product')
          ? "product_store"
          : "service_store";

      final body = {
        "targetId": storeId,
        "targetType": targetType,
      };

      final response = await ApiService.post(
        ApiEndPoint.favoritesToggle,
        body: body,
      );

      if (response.isSuccess) {
        final responseData = response.data;
        if (responseData is Map<String, dynamic>) {
          final dynamic innerData = responseData['data'];

          bool? serverStatus;
          if (innerData is Map<String, dynamic>) {
            serverStatus = innerData['isFavorited'] ?? innerData['isFavorite'];
          } else {
            serverStatus = responseData['isFavorited'] ?? responseData['isFavorite'];
          }

          if (serverStatus != null) {
            isFavorite.value = serverStatus;
            if (store != null) {
              store.isFavorite = serverStatus;
            }
          }
        }
      } else {
        // Rollback on API failure
        isFavorite.value = previousState;
        if (store != null) {
          store.isFavorite = previousState;
        }
        debugPrint("Failed to update favorite status: ${response.message}");
      }
    } catch (e) {
      // Rollback on exception
      isFavorite.value = previousState;
      final store = storeDetailsModel.value.data?.store;
      if (store != null) {
        store.isFavorite = previousState;
      }
      debugPrint("Error toggling store favorite: $e");
    }
  }

  bool isItemFavorite(String itemId) {
    return favoriteItemIds.contains(itemId);
  }

  Future<void> toggleItemFavorite(String itemId, String itemType) async {
    final bool isCurrentlyFav = favoriteItemIds.contains(itemId);

    // Optimistic UI Update
    if (isCurrentlyFav) {
      favoriteItemIds.remove(itemId);
    } else {
      favoriteItemIds.add(itemId);
    }

    try {
      final body = {
        "targetId": itemId,
        "targetType": itemType,
      };

      final response = await ApiService.post(
        ApiEndPoint.favoritesToggle,
        body: body,
      );

      if (!response.isSuccess) {
        // Rollback on API failure
        if (isCurrentlyFav) {
          favoriteItemIds.add(itemId);
        } else {
          favoriteItemIds.remove(itemId);
        }
      }
    } catch (e) {
      // Rollback on exception
      if (isCurrentlyFav) {
        favoriteItemIds.add(itemId);
      } else {
        favoriteItemIds.remove(itemId);
      }
      debugPrint("Error toggling item favorite: $e");
    }
  }
}