// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:dio/dio.dart' as dio;
// import 'dart:convert';
// import '../../../../services/api/api_service.dart';
// import '../../../../utils/constants/api_enpoint.dart';
//
// class StoreUpdateController extends GetxController {
//
//   final displayNameController = TextEditingController();
//   final descriptionController = TextEditingController();
//   var selectedCategoryId = "6a76eb808624bba43547e992".obs;
//
//   Rx<File?> selectedLogo = Rx<File?>(null);
//   Rx<File?> selectedCover = Rx<File?>(null);
//
//   final phoneController = TextEditingController();
//   final whatsappController = TextEditingController();
//   final emailController = TextEditingController();
//   final streetAddressController = TextEditingController();
//   final cityController = TextEditingController();
//   final postalCodeController = TextEditingController();
//   var isSameAsPhone = false.obs;
//
//   var latitude = 23.8223.obs;
//   var longitude = 90.3654.obs;
//
//   var workingDays = <String>["monday", "tuesday", "wednesday", "thursday", "friday"].obs;
//   final openingTimeController = TextEditingController(text: "09:00");
//   final closingTimeController = TextEditingController(text: "18:00");
//   var isOpen24Hours = false.obs;
//
//   final tradeLicenseNoController = TextEditingController();
//   final tinNumberController = TextEditingController();
//   Rx<File?> selectedTradeLicenseFile = Rx<File?>(null);
//
//   var isLoading = false.obs;
//
//   Future<void> pickImage(String type) async {
//     final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       if (type == 'logo') {
//         selectedLogo.value = File(pickedFile.path);
//       } else if (type == 'cover') {
//         selectedCover.value = File(pickedFile.path);
//       } else if (type == 'tradeLicense') {
//         selectedTradeLicenseFile.value = File(pickedFile.path);
//       }
//     }
//   }
//
//   void toggleSameAsPhone(bool value) {
//     isSameAsPhone.value = value;
//     if (value) {
//       whatsappController.text = phoneController.text;
//     } else {
//       whatsappController.clear();
//     }
//   }
//   void toggleWorkingDay(String day) {
//     if (workingDays.contains(day)) {
//       workingDays.remove(day);
//     } else {
//       workingDays.add(day);
//     }
//   }
//
//   Future<void> updateStore() async {
//     try {
//       isLoading.value = true;
//       final Map<String, dynamic> storeDataJson = {
//         "storeType": "product_store",
//         "displayName": displayNameController.text.trim(),
//         "description": descriptionController.text.trim(),
//         "categoryId": selectedCategoryId.value,
//         "phone": phoneController.text.trim(),
//         "whatsapp": whatsappController.text.trim().isNotEmpty ? whatsappController.text.trim() : phoneController.text.trim(),
//         "email": emailController.text.trim(),
//         "streetAddress": streetAddressController.text.trim(),
//         "city": cityController.text.trim(),
//         "postalCode": postalCodeController.text.trim(),
//         "latitude": latitude.value,
//         "longitude": longitude.value,
//         "businessLicenseNumber": tradeLicenseNoController.text.trim(),
//         "tinNumber": tinNumberController.text.trim(),
//         "workingDays": workingDays.toList(),
//         "openingTime": openingTimeController.text.trim(),
//         "closingTime": closingTimeController.text.trim(),
//         "isOpen24Hours": isOpen24Hours.value,
//         "timezone": "Asia/Dhaka"
//       };
//
//
//       dio.FormData formData = dio.FormData.fromMap({
//         "data": jsonEncode(storeDataJson),
//       });
//
//       if (selectedLogo.value != null) {
//         formData.files.add(
//           MapEntry(
//             "logo",
//             await dio.MultipartFile.fromFile(
//               selectedLogo.value!.path,
//               filename: selectedLogo.value!.path.split('/').last,
//             ),
//           ),
//         );
//       }
//
//       if (selectedCover.value != null) {
//         formData.files.add(
//           MapEntry(
//             "coverImage",
//             await dio.MultipartFile.fromFile(
//               selectedCover.value!.path,
//               filename: selectedCover.value!.path.split('/').last,
//             ),
//           ),
//         );
//       }
//
//       if (selectedTradeLicenseFile.value != null) {
//         formData.files.add(
//           MapEntry(
//             "tradeLicense",
//             await dio.MultipartFile.fromFile(
//               selectedTradeLicenseFile.value!.path,
//               filename: selectedTradeLicenseFile.value!.path.split('/').last,
//             ),
//           ),
//         );
//       }
//
//       final response = await ApiService.patch(ApiEndPoint.stores, body: formData);
//
//       if (response.isSuccess) {
//         Get.snackbar(
//           "Success",
//           "Store updated successfully",
//           backgroundColor: Colors.green,
//           colorText: Colors.white,
//         );
//       } else {
//         Get.snackbar(
//           "Failed",
//           response.message ,
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
//       isLoading.value = false;
//     }
//   }
//
//   @override
//   void onClose() {
//     displayNameController.dispose();
//     descriptionController.dispose();
//     phoneController.dispose();
//     whatsappController.dispose();
//     emailController.dispose();
//     streetAddressController.dispose();
//     cityController.dispose();
//     postalCodeController.dispose();
//     openingTimeController.dispose();
//     closingTimeController.dispose();
//     tradeLicenseNoController.dispose();
//     tinNumberController.dispose();
//     super.onClose();
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'dart:convert';
import '../../../../services/api/api_service.dart';
import '../../../../utils/constants/api_enpoint.dart';
import '../../../profile_section/presentation/screen/store_creation/presentation/model/category_model.dart';


class StoreUpdateController extends GetxController {

  final displayNameController = TextEditingController();
  final descriptionController = TextEditingController();

  // ডাইনামিক ক্যাটাগরির জন্য
  var selectedCategoryId = "".obs;
  var selectedCategoryName = "Select Category".obs;
  var categoryList = <CategoryData>[].obs;
  var isCategoryLoading = false.obs;

  Rx<File?> selectedLogo = Rx<File?>(null);
  Rx<File?> selectedCover = Rx<File?>(null);

  final phoneController = TextEditingController();
  final whatsappController = TextEditingController();
  final emailController = TextEditingController();
  final streetAddressController = TextEditingController();
  final cityController = TextEditingController();
  final postalCodeController = TextEditingController();
  var isSameAsPhone = false.obs;

  var latitude = 23.8223.obs;
  var longitude = 90.3654.obs;

  var workingDays = <String>["monday", "tuesday", "wednesday", "thursday", "friday"].obs;
  final openingTimeController = TextEditingController(text: "09:00");
  final closingTimeController = TextEditingController(text: "18:00");
  var isOpen24Hours = false.obs;

  final tradeLicenseNoController = TextEditingController();
  final tinNumberController = TextEditingController();
  Rx<File?> selectedTradeLicenseFile = Rx<File?>(null);

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories(); // কন্ট্রোলার ইনিশিয়াল হলে ক্যাটাগরি ফেচ করবে
  }

  // ক্যাটাগরি API কল করার মেথড
  Future<void> fetchCategories() async {
    try {
      isCategoryLoading.value = true;
      final response = await ApiService.get(ApiEndPoint.categories); // আপনার এন্ডপয়েন্ট অনুযায়ী ঠিক করুন (যেমন: ApiEndPoint.categories)

      if (response.isSuccess) {
        CategoryModel categoryModel = CategoryModel.fromJson(response.data as Map<String, dynamic>);
        if (categoryModel.data != null && categoryModel.data!.isNotEmpty) {
          categoryList.value = categoryModel.data!;


          selectedCategoryId.value = categoryList.first.sId ?? "";
          selectedCategoryName.value = categoryList.first.name ?? "Select Category";
        }
      } else {
        Get.snackbar("Error", response.message, backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isCategoryLoading.value = false;
    }
  }

  Future<void> pickImage(String type) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (type == 'logo') {
        selectedLogo.value = File(pickedFile.path);
      } else if (type == 'cover') {
        selectedCover.value = File(pickedFile.path);
      } else if (type == 'tradeLicense') {
        selectedTradeLicenseFile.value = File(pickedFile.path);
      }
    }
  }

  void toggleSameAsPhone(bool value) {
    isSameAsPhone.value = value;
    if (value) {
      whatsappController.text = phoneController.text;
    } else {
      whatsappController.clear();
    }
  }

  void toggleWorkingDay(String day) {
    if (workingDays.contains(day)) {
      workingDays.remove(day);
    } else {
      workingDays.add(day);
    }
  }

  Future<void> updateStore() async {
    try {
      isLoading.value = true;
      final Map<String, dynamic> storeDataJson = {
        "storeType": "product_store",
        "displayName": displayNameController.text.trim(),
        "description": descriptionController.text.trim(),
        "categoryId": selectedCategoryId.value, // ডাইনামিক আইডি এখানে পাস হবে
        "phone": phoneController.text.trim(),
        "whatsapp": whatsappController.text.trim().isNotEmpty ? whatsappController.text.trim() : phoneController.text.trim(),
        "email": emailController.text.trim(),
        "streetAddress": streetAddressController.text.trim(),
        "city": cityController.text.trim(),
        "postalCode": postalCodeController.text.trim(),
        "latitude": latitude.value,
        "longitude": longitude.value,
        "businessLicenseNumber": tradeLicenseNoController.text.trim(),
        "tinNumber": tinNumberController.text.trim(),
        "workingDays": workingDays.toList(),
        "openingTime": openingTimeController.text.trim(),
        "closingTime": closingTimeController.text.trim(),
        "isOpen24Hours": isOpen24Hours.value,
        "timezone": "Asia/Dhaka"
      };

      dio.FormData formData = dio.FormData.fromMap({
        "data": jsonEncode(storeDataJson),
      });

      if (selectedLogo.value != null) {
        formData.files.add(
          MapEntry(
            "logo",
            await dio.MultipartFile.fromFile(
              selectedLogo.value!.path,
              filename: selectedLogo.value!.path.split('/').last,
            ),
          ),
        );
      }

      if (selectedCover.value != null) {
        formData.files.add(
          MapEntry(
            "coverImage",
            await dio.MultipartFile.fromFile(
              selectedCover.value!.path,
              filename: selectedCover.value!.path.split('/').last,
            ),
          ),
        );
      }

      if (selectedTradeLicenseFile.value != null) {
        formData.files.add(
          MapEntry(
            "tradeLicense",
            await dio.MultipartFile.fromFile(
              selectedTradeLicenseFile.value!.path,
              filename: selectedTradeLicenseFile.value!.path.split('/').last,
            ),
          ),
        );
      }

      final response = await ApiService.patch(ApiEndPoint.stores, body: formData);

      if (response.isSuccess) {
        Get.snackbar(
          "Success",
          "Store updated successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
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

  @override
  void onClose() {
    displayNameController.dispose();
    descriptionController.dispose();
    phoneController.dispose();
    whatsappController.dispose();
    emailController.dispose();
    streetAddressController.dispose();
    cityController.dispose();
    postalCodeController.dispose();
    openingTimeController.dispose();
    closingTimeController.dispose();
    tradeLicenseNoController.dispose();
    tinNumberController.dispose();
    super.onClose();
  }
}