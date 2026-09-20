import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_service/config/route/app_route.dart';
import 'package:product_service/services/storage/storage_service.dart';
import '../../../../services/api/api_service.dart'; // আপনার প্রজেক্টের ApiService পাথ
import '../../../../utils/constants/api_enpoint.dart';   // আপনার প্রজেক্টের ApiEndPoint পাথ

class DeleteAccountController extends GetxController {
  final formKey = GlobalKey<FormState>(); // ফর্ম ভ্যালিডেশনের জন্য (যদি রাখতে চান)
  final passwordController = TextEditingController();

  var isPasswordHidden = true.obs;
  var isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  Future<void> deleteAccountApiCall() async {
    if (passwordController.text.trim().isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter your password",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    String password = passwordController.text.trim();
    isLoading.value = true;

    try {
      final response = await ApiService.delete(
        ApiEndPoint.deleteAccount,
        body: {
          "password": password,
        },
      );

      isLoading.value = false;

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar(
          "Success",
          response.data['message'] ?? "Account deleted successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        await LocalStorage.removeAllPrefData();
        Get.offAllNamed(AppRoutes.loginScreen);
      } else {
        Get.snackbar(
          "Failed",
          response.data['message'] ?? "Something went wrong. Try again.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    passwordController.dispose();
    super.onClose();
  }
}