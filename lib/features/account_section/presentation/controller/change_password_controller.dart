import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_service/config/route/app_route.dart';
import '../../../../services/api/api_service.dart';
import '../../../../utils/constants/api_enpoint.dart';


class ChangePasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isCurrentPasswordHidden = true.obs;
  var isNewPasswordHidden = true.obs;
  var isConfirmPasswordHidden = true.obs;

  var isLoading = false.obs;

  void toggleCurrentPasswordVisibility() {
    isCurrentPasswordHidden.value = !isCurrentPasswordHidden.value;
  }

  void toggleNewPasswordVisibility() {
    isNewPasswordHidden.value = !isNewPasswordHidden.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  }

  Future<void> changePasswordApiCall() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    String currentPass = currentPasswordController.text.trim();
    String newPass = newPasswordController.text.trim();
    String confirmPass = confirmPasswordController.text.trim();

    isLoading.value = true;

    try {
      final response = await ApiService.post(
        ApiEndPoint.changePass,
        body: {
          "currentPassword": currentPass,
          "newPassword": newPass,
          "confirmPassword": confirmPass,
        },
      );

      isLoading.value = false;

      if (response.statusCode == 200) {
        Get.snackbar(
          "Success",
          response.data['message'] ?? "Password changed successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.toNamed(AppRoutes.accountScreen);
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
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}