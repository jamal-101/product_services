import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../services/api/api_service.dart';
import '../../../../../utils/constants/api_enpoint.dart';
import '../model/get_my_store_model.dart';

class MyStoreController extends GetxController {
  var isLoading = false.obs;
  var isProductStore = true.obs;

  Rx<GetMyStore?> myStoreModel = Rx<GetMyStore?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchMyStoreData();
  }

  Future<void> fetchMyStoreData() async {
    isLoading.value = true;
    try {
      var response = await ApiService.get(ApiEndPoint.myStore);

      if (response.statusCode == 200) {
        var jsonResponse = response.data;
        myStoreModel.value = GetMyStore.fromJson(jsonResponse as Map<String, dynamic>);
        String storeType = myStoreModel.value?.data?.storeType ?? "product_store";
        isProductStore.value = !storeType.toLowerCase().contains("service");
            }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to load store data: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}