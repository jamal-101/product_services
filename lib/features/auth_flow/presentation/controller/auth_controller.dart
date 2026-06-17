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


  @override
  void onInit() {
    super.onInit();
    // অ্যাপ চালু হলে আগের সেভ করা রোল লোড হবে
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

  // AuthController.dart

// GetStorage এর জন্য একটি প্যাকেজ যোগ করতে পারেন অথবা Get.find<GetStorage>() ব্যবহার করতে পারেন।
// আপাতত সিম্পল লজিক নিচে দেওয়া হলো:

  void selectRole(String role) async {
    selectedRole.value = role;

    // LocalStorage এ রোল পার্মানেন্টলি সেভ করে রাখা
    await LocalStorage.setUserRole(role);

    Future.delayed(const Duration(milliseconds: 300), () {
      // এখানে আপনার লজিক অনুযায়ী রাউটিং করুন
      if (role == 'seller') {
        Get.offAll(() => const SellerHomeScreen());
      } else {
        Get.offAllNamed(AppRoutes.homeScreen);
      }
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