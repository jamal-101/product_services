import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../services/api/api_service.dart';
import '../../../../utils/constants/api_enpoint.dart';

class SupportController extends GetxController {
  var isLoading = false.obs;
  var htmlContent = "".obs;

  Future<void> fetchRuleContent() async {
    isLoading.value = true;
    try {
      String url = ApiEndPoint.rulesGuidelines;

      var response = await ApiService.get(url);

      if (response.statusCode == 200) {
        var jsonResponse = response.data;
        if (jsonResponse['success'] == true && jsonResponse['data'] != null) {
          htmlContent.value = jsonResponse['data']['content'] ?? '';
        }
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to fetch content",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> fetchPrivacyPolicy() async {
    isLoading.value = true;
    try {
      String url = ApiEndPoint.privacyPolicy;

      var response = await ApiService.get(url);

      if (response.statusCode == 200) {
        var jsonResponse = response.data;
        if (jsonResponse['success'] == true && jsonResponse['data'] != null) {
          htmlContent.value = jsonResponse['data']['content'] ?? '';
        }
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to fetch content",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> fetchTermsConditions() async {
    isLoading.value = true;
    try {
      String url = ApiEndPoint.termsAndConditions;

      var response = await ApiService.get(url);

      if (response.statusCode == 200) {
        var jsonResponse = response.data;
        if (jsonResponse['success'] == true && jsonResponse['data'] != null) {
          htmlContent.value = jsonResponse['data']['content'] ?? '';
        }
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to fetch content",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}