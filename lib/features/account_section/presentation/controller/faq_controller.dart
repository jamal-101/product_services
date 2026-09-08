import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_service/services/api/api_service.dart';
import 'package:product_service/utils/constants/api_enpoint.dart';
import '../model/faq_model.dart';

class FaqController extends GetxController {
  var isLoading = false.obs;
  var faqList = <FaqData>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchFaqs();
  }

  Future<void> fetchFaqs() async {
    try {
      isLoading.value = true;
      final response = await ApiService.get(ApiEndPoint.faqs);

      if (response.isSuccess) {
        FaqModel faqModel = FaqModel.fromJson(response.data as Map<String, dynamic>);
        if (faqModel.data != null) {
          faqList.value = faqModel.data!;
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