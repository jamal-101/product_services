import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/route/app_route.dart';

class AuthController extends GetxController {

  final registerNameController = TextEditingController();
  final registerPhoneController = TextEditingController();
  final registerEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerConfirmPasswordController = TextEditingController();

  var isRegisterPasswordVisible = false.obs;
  var isRegisterConfirmPasswordVisible = false.obs;

// Phone Verification Timer
  var phoneCountdown = 42.obs;

  // Login Controllers
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();
  var isLoginPasswordVisible = false.obs;

  // Forgot & Reset Controllers
  final forgotEmailController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  var isNewPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;

  // Role Selection State
  var selectedRole = "".obs; // 'buyer' or 'seller'

  // OTP Timer State
  var resendCountdown = 55.obs;
  Timer? _timer;

  void startOtpTimer() {
    resendCountdown.value = 55;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendCountdown.value > 0) {
        resendCountdown.value--;
      } else {
        _timer?.cancel();
      }
    });
  }

  void selectRole(String role) {
    selectedRole.value = role;
    Future.delayed(const Duration(milliseconds: 300), () {
      Get.offAllNamed(AppRoutes.homeScreen);
    });
  }

  @override
  void onClose() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
    forgotEmailController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    _timer?.cancel();
    super.onClose();
  }
}