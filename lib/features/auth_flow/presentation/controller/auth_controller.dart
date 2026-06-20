import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/route/app_route.dart';
import '../../../../services/storage/storage_service.dart';
import '../../../seller/seller_home_flow/presentation/screen/seller_home_screen.dart';

class AuthController extends GetxController {

  final registerNameController = TextEditingController();
  final registerPhoneController = TextEditingController();
  final registerEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerConfirmPasswordController = TextEditingController();
  var isRegisterPasswordVisible = false.obs;
  var isRegisterConfirmPasswordVisible = false.obs;
  var phoneCountdown = 42.obs;
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();
  var isLoginPasswordVisible = false.obs;
  final forgotEmailController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  var isNewPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;
  var selectedRole = "".obs;
  var resendCountdown = 55.obs;
  Timer? _timer;


  @override
  void onInit() {
    super.onInit();
    selectedRole.value = LocalStorage.myRole;
  }

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

  void selectRole(String role) async {
    selectedRole.value = role;
    await LocalStorage.setUserRole(role);
    Future.delayed(const Duration(milliseconds: 300), () {
      if (role == 'seller') {
        Get.offAllNamed(AppRoutes.sellerHomeScreen);
      } else {
        Get.offAllNamed(AppRoutes.homeScreen);
      }
    });
  }

  void toggleRole() async {
    // বর্তমানে কি আছে তা চেক করা
    String currentRole = LocalStorage.myRole;

    // উল্টো রোল সেট করা
    String newRole = (currentRole == 'buyer') ? 'seller' : 'buyer';

    // লোকাল স্টোরেজে আপডেট করা
    await LocalStorage.setUserRole(newRole);
    selectedRole.value = newRole;

    // রাউটিং লজিক
    if (newRole == 'seller') {
      Get.offAllNamed(AppRoutes.sellerHomeScreen);
    } else {
      Get.offAllNamed(AppRoutes.homeScreen);
    }
  }

  @override
  void onClose() {
    _timer?.cancel();

    super.onClose();
  }
}