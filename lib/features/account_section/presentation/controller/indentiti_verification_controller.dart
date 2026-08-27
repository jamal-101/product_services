import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import '../../../../config/route/app_route.dart';
import '../../../../services/api/api_service.dart';
import '../../../../utils/constants/api_enpoint.dart';

class IdentityVerificationController extends GetxController {
  RxString selectedIdType = 'National ID'.obs;

  // Image path gulo string hishebe rakhar jonno
  RxString frontImagePath = ''.obs;
  RxString backImagePath = ''.obs;

  RxBool isLoading = false.obs;

  final ImagePicker _picker = ImagePicker();

  void updateIdType(String? type) {
    if (type != null) {
      selectedIdType.value = type;
    }
  }

  // Image Pick korar method
  Future<void> pickImage(bool isFront) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      if (isFront) {
        frontImagePath.value = image.path;
      } else {
        backImagePath.value = image.path;
      }
    }
  }

  Future<void> submitVerification() async {
    if (frontImagePath.value.isEmpty || backImagePath.value.isEmpty) {
      Get.snackbar(
        "Error",
        "Please select both front and back images",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      String docType = 'nid';
      if (selectedIdType.value == 'Passport') {
        docType = 'passport';
      } else if (selectedIdType.value == 'National ID') {
        docType = 'nid';
      }

      Map<String, dynamic> dataMap = {
        "documentType": docType,
      };

      List files = [
        {
          'name': 'documentFront',
          'image': frontImagePath.value,
        },
        {
          'name': 'documentBack',
          'image': backImagePath.value,
        },
      ];

      var response = await ApiService.multipartImage(
        ApiEndPoint.verifyIdentity,
        method: "PATCH",
        body: {
          'data': jsonEncode(dataMap),
        },
        files: files,
      );

      isLoading.value = false;

      if (response.isSuccess) {
        Get.snackbar(
          "Success",
          response.message,
          backgroundColor: Colors.white,
          colorText: Colors.green,
          snackPosition: SnackPosition.TOP
        );
        Get.toNamed(AppRoutes.accountScreen);
      } else {
        Get.snackbar(
          "Failed",
          response.message,
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
}