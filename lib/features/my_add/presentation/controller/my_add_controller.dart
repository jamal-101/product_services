import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../services/api/api_service.dart';
import '../../../../services/storage/storage_service.dart';
import '../../../../utils/constants/api_enpoint.dart';
import '../model/my_add_model.dart';

class MyAddController extends GetxController {
  var isLoading = false.obs;
  var myAds = <Data>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchMyAds();
  }

  Future<void> fetchMyAds() async {
    isLoading.value = true;
    try {
      final response = await ApiService.get(
        ApiEndPoint.myAdvertisements,
        header: {
          'Authorization': 'Bearer ${LocalStorage.token}',
          'Content-Type': 'application/json',
        },
      );

      if (response.isSuccess) {
        MyAddModel model = MyAddModel.fromJson(response.data as Map<String, dynamic>);
        if (model.data != null) {
          myAds.value = model.data!;
        }
      } else {
        Get.snackbar(
          "Error",
          response.message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}