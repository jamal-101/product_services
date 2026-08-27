// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:product_service/config/route/app_route.dart';
// import 'package:dio/dio.dart' as dio;
//
// import '../../../../services/api/api_service.dart';
// import '../../../../utils/constants/api_enpoint.dart';
//
// class EditProfileController extends GetxController {
//   final formKey = GlobalKey<FormState>();
//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   final phoneController = TextEditingController();
//   final cityController = TextEditingController();
//   final postalController = TextEditingController();
//   final streetController = TextEditingController();
//
//   var isUpdateLoading = false.obs;
//   var isLoading = false.obs;
//   Rx<File?> selectedImage = Rx<File?>(null);
//
//   var profileImageUrl = "".obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchInitialProfileData();
//   }
//
//   Future<void> updateProfile() async {
//     if (!formKey.currentState!.validate()) return;
//
//     try {
//       isUpdateLoading.value = true;
//
//       final Map<String, dynamic> locationMap = {
//         "type": "Point",
//         "coordinates": [90.3563, 23.8103],
//         "address": streetController.text.trim(),
//       };
//
//       dio.FormData formData = dio.FormData.fromMap({
//         "name": nameController.text.trim(),
//         // "email": emailController.text.trim(),
//         "phone": phoneController.text.trim(),
//         "postalCode": postalController.text.trim(),
//         "state": cityController.text.trim(),
//         "address": streetController.text.trim(),
//         "location": locationMap,
//       });
//
//       if (selectedImage.value != null) {
//         formData.files.add(
//           MapEntry(
//             "profileImage",
//             await dio.MultipartFile.fromFile(
//               selectedImage.value!.path,
//               filename: selectedImage.value!.path.split('/').last,
//             ),
//           ),
//         );
//       }
//
//       final response = await ApiService.patch(ApiEndPoint.signUp, body: formData);
//
//       if (response.isSuccess) {
//         Get.snackbar(
//           "Success",
//           "Profile updated successfully",
//           backgroundColor: Colors.green,
//           colorText: Colors.white,
//         );
//         Get.offAllNamed(AppRoutes.accountScreen);
//       } else {
//         Get.snackbar(
//           "Failed",
//           response.message,
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//         );
//       }
//     } catch (e) {
//       Get.snackbar(
//         "Error",
//         e.toString(),
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     } finally {
//       isUpdateLoading.value = false;
//     }
//   }
//
//   @override
//   void onClose() {
//     nameController.dispose();
//     emailController.dispose();
//     phoneController.dispose();
//     cityController.dispose();
//     postalController.dispose();
//     streetController.dispose();
//     super.onClose();
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:product_service/config/route/app_route.dart';
import 'package:dio/dio.dart' as dio;

import '../../../../services/api/api_service.dart';
import '../../../../utils/constants/api_enpoint.dart';

class EditProfileController extends GetxController {
  final formKey = GlobalKey<FormState>();

  // টেক্সট কন্ট্রোলারগুলো
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
      cityController.text = userData['state'] ?? '';
      streetController.text = userData['address'] ?? '';
      profileImageUrl.value = userData['profileImage'] ?? '';
    }
  }


  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  Future<void> updateProfile() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isUpdateLoading.value = true;

      final Map<String, dynamic> locationMap = {
        "type": "Point",
        "coordinates": [90.3563, 23.8103],
        "address": streetController.text.trim(),
      };

      dio.FormData formData = dio.FormData.fromMap({
        "name": nameController.text.trim(),
        "phone": phoneController.text.trim(),
        "postalCode": postalController.text.trim(),
        "state": cityController.text.trim(),
        "address": streetController.text.trim(),
        "location": locationMap,
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

      final response = await ApiService.patch(ApiEndPoint.signUp, body: formData);

      if (response.isSuccess) {
        Get.snackbar(
          "Success",
          "Profile updated successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAllNamed(AppRoutes.accountScreen);
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