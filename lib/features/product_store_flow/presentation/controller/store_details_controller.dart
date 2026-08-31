import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../services/api/api_service.dart';
import '../model/store_details_model.dart';

class StoreDetailsController extends GetxController {
  var isLoading = false.obs;
  var storeDetailsModel = StoreDetailsModel().obs;

  Future<void> fetchStoreDetails(String storeId) async {
    try {
      isLoading.value = true;

      final response = await ApiService.get('/stores/$storeId');

      if (response.isSuccess) {
        debugPrint("API Response Body: ${response.data}");

        if (response.data is Map<String, dynamic>) {
          storeDetailsModel.value = StoreDetailsModel.fromJson(response.data as Map<String, dynamic>);
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
}