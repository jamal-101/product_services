import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'package:product_service/features/account_section/presentation/screen/account_screen.dart';
import '../../../../services/api/api_service.dart';
import '../../../../utils/constants/api_enpoint.dart';
import '../../../profile_section/presentation/controller/profile_controller.dart';

class EditProfileController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();
  final postalController = TextEditingController();
  final streetController = TextEditingController();

  var isUpdateLoading = false.obs;
  Rx<File?> selectedImage = Rx<File?>(null);
  var profileImageUrl = "".obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      final userData = Get.arguments;
      nameController.text = userData['name'] ?? '';
      emailController.text = userData['email'] ?? '';
      phoneController.text = userData['phone'] ?? '';
      postalController.text = userData['postalCode'] ?? '';
      cityController.text = userData['city'] ?? userData['state'] ?? '';
      streetController.text = userData['address'] ?? '';
      profileImageUrl.value = userData['profileImage'] ?? '';
    }
  }

  // Future<void> pickImage() async {
  //   final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     selectedImage.value = File(pickedFile.path);
  //   }
  // }

  Future<void> pickImage() async {
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
            // Top indicator bar
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
                await _getImage(ImageSource.camera);
              },
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: const Color(0xFFE3F2FD),
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      color: Color(0xFF1E88E5),
                      size: 24,
                    ),
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
                await _getImage(ImageSource.gallery);
              },
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: const Color(0xFFE8F5E9),
                    child: const Icon(
                      Icons.photo_library_outlined,
                      color: Color(0xFF43A047),
                      size: 24,
                    ),
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

  Future<void> _getImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: source,
        imageQuality: 50,
        maxWidth: 1024,
        maxHeight: 1024,
      );
      if (pickedFile != null) {
        selectedImage.value = File(pickedFile.path);
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  Future<void> updateProfile() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isUpdateLoading.value = true;
      final Map<String, dynamic> updateData = {
        "name": nameController.text.trim(),
        "phone": phoneController.text.trim(),
        "postalCode": postalController.text.trim(),
        "state": cityController.text.trim(),
        "address": streetController.text.trim(),
        "location": {
          "type": "Point",
          "coordinates": [90.3563, 23.8103],
          "address": streetController.text.trim(),
          "city": cityController.text.trim(),
          if (Get.arguments != null) ...{
            "canton": Get.arguments['canton'] ?? '',
            "country": Get.arguments['country'] ?? '',
            "neighborhood": Get.arguments['neighborhood'] ?? '',
            "province": Get.arguments['province'] ?? '',
            "sector": Get.arguments['sector'] ?? '',
          },
        },
      };

      dio.FormData formData = dio.FormData.fromMap({
        "data": jsonEncode(updateData),
      });

      if (selectedImage.value != null) {
        formData.files.add(
          MapEntry(
            "profileImage",
            await dio.MultipartFile.fromFile(
              selectedImage.value!.path,
              filename: selectedImage.value!.path.split('/').last,
            ),
          ),
        );
      }

      final response = await ApiService.patch(
        ApiEndPoint.signUp,
        body: formData,
      );

      if (response.isSuccess) {
        Get.find<ProfileController>().getProfileData();
        Get.snackbar(
          "Success",
          "Profile updated successfully",
          backgroundColor: Colors.white,
          colorText: Colors.green,
          snackPosition: SnackPosition.TOP,
        );
        Get.to(AccountScreen());
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
      isUpdateLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    cityController.dispose();
    postalController.dispose();
    streetController.dispose();
    super.onClose();
  }
}
