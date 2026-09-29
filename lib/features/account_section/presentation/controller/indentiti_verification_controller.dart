import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import '../../../../config/route/app_route.dart';
import '../../../../services/api/api_service.dart';
import '../../../../utils/constants/api_enpoint.dart';

class IdentityVerificationController extends GetxController {
  RxString selectedIdType = 'National ID'.obs;
  RxString frontImagePath = ''.obs;
  RxString backImagePath = ''.obs;

  RxBool isLoading = false.obs;

  final ImagePicker _picker = ImagePicker();

  void updateIdType(String? type) {
    if (type != null) {
      selectedIdType.value = type;
    }
  }

  // Future<void> pickImage(bool isFront) async {
  //   final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  //   if (image != null) {
  //     if (isFront) {
  //       frontImagePath.value = image.path;
  //     } else {
  //       backImagePath.value = image.path;
  //     }
  //   }
  // }


  Future<void> pickImage(bool isFront) async {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),

            // Camera Option
            InkWell(
              onTap: () async {
                Get.back();
                await _getImage(ImageSource.camera, isFront);
              },
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: const Color(0xFFE3F2FD),
                    child: const Icon(Icons.camera_alt_outlined, color: Color(0xFF1E88E5), size: 24),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Camera',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Gallery Option
            InkWell(
              onTap: () async {
                Get.back();
                await _getImage(ImageSource.gallery, isFront);
              },
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: const Color(0xFFE8F5E9),
                    child: const Icon(Icons.photo_library_outlined, color: Color(0xFF43A047), size: 24),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Gallery',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // Image source ও compression হ্যান্ডেল করার প্রাইভেট মেথড
  Future<void> _getImage(ImageSource source, bool isFront) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 50, // ৪১৩ এরর আটকানোর জন্য ইমেজের সাইজ কমানো হয়েছে
        maxWidth: 1024,
        maxHeight: 1024,
      );

      if (image != null) {
        if (isFront) {
          frontImagePath.value = image.path;
        } else {
          backImagePath.value = image.path;
        }
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
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