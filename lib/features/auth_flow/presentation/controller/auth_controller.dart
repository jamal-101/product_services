import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../config/route/app_route.dart';
import '../../../../services/api/api_service.dart';
import '../../../../services/storage/storage_key.dart';
import '../../../../services/storage/storage_service.dart';
import '../../../../utils/constants/api_enpoint.dart';
import '../../../../utils/constants/app_color.dart';

class AuthController extends GetxController {
  final registerNameController = TextEditingController();
  final registerPhoneController = TextEditingController();
  final registerEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerConfirmPasswordController = TextEditingController();
  var isRegisterPasswordVisible = false.obs;
  var isRegisterConfirmPasswordVisible = false.obs;
  var phoneCountdown = 180.obs;
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
  var isLoading = false.obs;
  final documentTypeController = TextEditingController();
  final documentNumberController = TextEditingController();
  Rxn<File> documentFrontImage = Rxn<File>();
  Rxn<File> documentBackImage = Rxn<File>();

  var selectedDocumentType = "".obs;
  List<String> documentTypes = ['NID', 'Passport'];

  final List<TextEditingController> otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  @override
  void onInit() {
    super.onInit();
    selectedRole.value = LocalStorage.myRole;
  }

  var isTermsAccepted = false.obs;

  void toggleTermsAccepted(bool? value) {
    isTermsAccepted.value = value ?? false;
  }

  Timer? _phoneTimer;

  void startPhoneOtpTimer() {
    phoneCountdown.value = 180;
    _phoneTimer?.cancel();
    _phoneTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (phoneCountdown.value > 0) {
        phoneCountdown.value--;
      } else {
        _phoneTimer?.cancel();
      }
    });
  }

  Future<void> pickDocumentImage(bool isFront) async {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt, color: AppColor.primary),
              title: Text(
                'Take a Photo',
                style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600),
              ),
              onTap: () async {
                Get.back();
                final ImagePicker picker = ImagePicker();
                final XFile? image = await picker.pickImage(
                  source: ImageSource.camera,
                );
                if (image != null) {
                  if (isFront) {
                    documentFrontImage.value = File(image.path);
                  } else {
                    documentBackImage.value = File(image.path);
                  }
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: AppColor.primary),
              title: Text(
                'Choose from Gallery',
                style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600),
              ),
              onTap: () async {
                Get.back();
                final ImagePicker picker = ImagePicker();
                final XFile? image = await picker.pickImage(
                  source: ImageSource.gallery,
                );
                if (image != null) {
                  if (isFront) {
                    documentFrontImage.value = File(image.path);
                  } else {
                    documentBackImage.value = File(image.path);
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signUp() async {
    isLoading.value = true;

    try {
      final Map<String, dynamic> bodyData = {
        "name": registerNameController.text.trim(),
        "email": registerEmailController.text.trim(),
        "phone": registerPhoneController.text.trim(),
        "countryCode": "+880",
        "password": registerPasswordController.text,
        "documentType": selectedDocumentType.value.toLowerCase(),
        "documentNumber": documentNumberController.text.trim(),
        "role": "user",
      };

      Map<String, File?> files = {
        "documentFront": documentFrontImage.value,
        "documentBack": documentBackImage.value,
      };

      final response = await ApiService.multipartRequest(
        ApiEndPoint.signUp,
        bodyData: bodyData,
        files: files,
        method: "POST",
      );

      if (response.isSuccess) {
        final responseData = response.data;
        String? token;

        if (responseData is Map<String, dynamic>) {
          if (responseData.containsKey('data') &&
              responseData['data'] != null) {
            token = responseData['data']['token']?.toString();
          } else if (responseData.containsKey('token')) {
            token = responseData['token']?.toString();
          }
        }

        if (token != null && token.isNotEmpty) {
          LocalStorage.token = token;
          await LocalStorage.setString(LocalStorageKeys.token, token);
        }

        Get.snackbar(
          "Success",
          response.message,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        startPhoneOtpTimer();
        Get.toNamed(AppRoutes.verifySignUpOtpScreen);
      } else {
        Get.snackbar(
          "Failed",
          response.message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e, stackTrace) {
      debugPrint("SignUp Error: $e");
      debugPrint("StackTrace: $stackTrace");

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

  void toggleRegisterPasswordVisibility() {
    isRegisterPasswordVisible.toggle();
    update();
  }

  void toggleRegisterConfirmPasswordVisibility() {
    isRegisterConfirmPasswordVisible.toggle();
    update();
  }

  void startOtpTimer() {
    resendCountdown.value = 180;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendCountdown.value > 0) {
        resendCountdown.value--;
      } else {
        _timer?.cancel();
      }
    });
  }

  Future<void> verifyOtp() async {
    String otpCode = otpControllers.map((c) => c.text.trim()).join();

    isLoading.value = true;

    final Map<String, dynamic> body = {
      "email": registerEmailController.text.trim(),
      "oneTimeCode": otpCode,
    };

    try {
      final response = await ApiService.post(ApiEndPoint.verifyOtp, body: body);

      if (response.isSuccess) {
        Get.snackbar(
          "Success",
          response.message,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAllNamed(AppRoutes.loginScreen);
      } else {
        Get.snackbar(
          "Failed",
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

  Future<void> resendSignUpOtp() async {
    if (phoneCountdown.value > 0) {
      Get.snackbar(
        "Wait",
        "Please wait until the countdown finishes.",
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    final Map<String, dynamic> body = {
      "email": registerEmailController.text.trim(),
    };

    try {
      final response = await ApiService.post(ApiEndPoint.resendOtp, body: body);

      if (response.isSuccess) {
        Get.snackbar(
          "Success",
          response.message,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        startPhoneOtpTimer();
      } else {
        Get.snackbar(
          "Failed",
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

  var isLoginLoading = false.obs;

  Future<void> loginUser() async {
    isLoginLoading.value = true;

    final Map<String, dynamic> body = {
      "email": loginEmailController.text.trim(),
      "password": loginPasswordController.text,
    };

    try {
      final response = await ApiService.post(ApiEndPoint.login, body: body);

      if (response.isSuccess) {
        var responseData = response.data;
        String? token = responseData['data']?['token'];
        String? userId = responseData['data']?['user']?['_id'];

        if (token != null && userId != null) {
          LocalStorage.token = token;
          LocalStorage.userId = userId;
          await LocalStorage.setString(LocalStorageKeys.token, token);
          await LocalStorage.setString(LocalStorageKeys.userId, userId);

          final activeRole =
              responseData['data']?['user']?['activeRole']?.toString() ?? '';
          if (activeRole == 'seller') {
            await LocalStorage.setSellerToken(token);
          }
        }
        bool hasSellerAccount =
            responseData['data']?['hasSellerAccount'] ?? false;
        LocalStorage.hasSellerAccount = hasSellerAccount;
        await LocalStorage.setBool(
          LocalStorageKeys.hasSellerAccount,
          hasSellerAccount,
        );

        Get.snackbar(
          "Success",
          response.message,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        if (!hasSellerAccount) {
          Get.offAllNamed(AppRoutes.homeScreen);
        } else {
          Get.offAllNamed(AppRoutes.selectRoleScreen);
        }
      } else {
        Get.snackbar(
          "Failed",
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
      isLoginLoading.value = false;
    }
  }

  Future<void> selectRole(String role) async {
    String previousRole = selectedRole.value;
    String apiRole = (role == 'buyer') ? 'user' : role;

    final Map<String, dynamic> body = {"role": apiRole};

    try {
      final response = await ApiService.post(
        ApiEndPoint.switchRole,
        body: body,
      );

      if (response.isSuccess) {
        var responseData = response.data;

        String? token =
            responseData['data']?['accessToken']?.toString() ??
            responseData['data']?['token']?.toString();
        if (token != null && token.isNotEmpty) {
          LocalStorage.token = token;
          await LocalStorage.setString(LocalStorageKeys.token, token);
          if (role == 'seller') {
            await LocalStorage.setSellerToken(token);
          }
        }

        selectedRole.value = role; // ✅ API Successful হলে মান আপডেট হবে
        await LocalStorage.setUserRole(role);

        if (role == 'seller') {
          Get.offAllNamed(AppRoutes.sellerHomeScreen);
        } else {
          Get.offAllNamed(AppRoutes.homeScreen);
        }
      } else {
        // ❌ ব্যর্থ হলে রোল আগেরটাই থাকবে
        selectedRole.value = previousRole;

        Get.snackbar(
          "Failed",
          response.message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      // ❌ Exception হলেও রোল আগেরটাই থাকবে
      selectedRole.value = previousRole;

      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> toggleRole() async {
    String currentRole = LocalStorage.myRole;
    String newRole = (currentRole == 'buyer') ? 'seller' : 'buyer';
    await selectRole(newRole);
  }

  var isForgotLoading = false.obs;

  Future<void> forgotPassword() async {
    isForgotLoading.value = true;

    final Map<String, dynamic> body = {
      "email": forgotEmailController.text.trim(),
    };
    try {
      final response = await ApiService.post(
        ApiEndPoint.forgotPassword,
        body: body,
      );
      if (response.isSuccess) {
        startOtpTimer();
        Get.toNamed(AppRoutes.forgetPassVerifyOtpScreen);
      } else {
        Get.snackbar(
          "Failed",
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
      isForgotLoading.value = false;
    }
  }

  var isVerifyLoading = false.obs;
  final List<TextEditingController> otpEmailControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> otpFocusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );

  Future<void> verifyForgetEmailOtp(String otpCode) async {
    isVerifyLoading.value = true;

    final Map<String, dynamic> body = {
      "email": forgotEmailController.text.trim(),
      "oneTimeCode": int.parse(otpCode),
    };
    try {
      final response = await ApiService.post(
        ApiEndPoint.verifyEmail,
        body: body,
      );

      if (response.isSuccess) {
        var responseData = response.data;
        String? resetToken = responseData['data'];
        if (resetToken != null && resetToken.isNotEmpty) {
          LocalStorage.token = resetToken;
          await LocalStorage.setString(LocalStorageKeys.token, resetToken);
        }

        Get.snackbar(
          "Success",
          response.message,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.toNamed(AppRoutes.resetPassword);
      } else {
        Get.snackbar(
          "Failed",
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
      isVerifyLoading.value = false;
    }
  }

  Future<void> resendForgotEmailOtp() async {
    if (resendCountdown.value > 0) return;

    isForgotLoading.value = true;

    final Map<String, dynamic> body = {
      "email": forgotEmailController.text.trim(),
    };

    try {
      final response = await ApiService.post(
        ApiEndPoint.forgotPassword,
        body: body,
      );

      if (response.isSuccess) {
        Get.snackbar(
          "Success",
          response.message,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        startOtpTimer();
      } else {
        Get.snackbar(
          "Failed",
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
      isForgotLoading.value = false;
    }
  }

  var isResetLoading = false.obs;

  Future<void> resetPassword() async {
    isResetLoading.value = true;

    final Map<String, dynamic> body = {
      "newPassword": newPasswordController.text,
      "confirmPassword": confirmPasswordController.text,
    };

    try {
      final response = await ApiService.post(
        ApiEndPoint.resetPassword,
        body: body,
        header: {"resettoken": LocalStorage.token},
      );

      if (response.isSuccess) {
        Get.snackbar(
          "Success",
          response.message,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAllNamed(AppRoutes.loginScreen);
      } else {
        Get.snackbar(
          "Failed",
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
      isResetLoading.value = false;
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    _phoneTimer?.cancel();
    super.onClose();
  }
}
