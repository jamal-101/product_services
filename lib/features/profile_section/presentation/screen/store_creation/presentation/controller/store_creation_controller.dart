// import 'package:get/get.dart';
//
// class StoreCreationController extends GetxController {
//   var currentStep = 1.obs;
//
//   var isWhatsAppSameAsPhone = false.obs;
//
//   void toggleWhatsApp(bool value) {
//     isWhatsAppSameAsPhone.value = value;
//   }
//
//   void nextStep() {
//     if (currentStep < 4) currentStep++;
//   }
//
// }


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:product_service/config/route/app_route.dart';
import '../../../../../../../services/api/api_service.dart';
import '../../../../../../../services/storage/storage_service.dart';
import '../../../../../../../utils/constants/api_enpoint.dart';


class StoreCreationController extends GetxController {

  var currentStep = 1.obs;
  var selectedStoreType = "".obs;

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  var categories = <dynamic>[].obs;
  var selectedCategoryName = "Select category".obs;
  var selectedCategoryId = "".obs;

  var cities = <dynamic>[].obs;
  var selectedCityName = "Select location".obs;
  var selectedCityId = "".obs;

  Rx<File?> logoFile = Rx<File?>(null);
  Rx<File?> coverImageFile = Rx<File?>(null);
  Rx<File?> tradeLicenseFile = Rx<File?>(null);


  final phoneController = TextEditingController();
  final whatsappController = TextEditingController();
  final emailController = TextEditingController();
  var isWhatsAppSameAsPhone = false.obs;

  final tradeLicenseNoController = TextEditingController();
  final tinNumberController = TextEditingController();

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchCitiesOnDemand();
  }


  void fetchCategories() async {
    try {
      final response = await ApiService.get(ApiEndPoint.categories);
      if (response.isSuccess) {
        categories.value = response.data['data'] ?? [];
      }
    } catch (e) {
      debugPrint("Error fetching categories: $e");
    }
  }

  void fetchCitiesOnDemand() async {
    print("🔄 User clicked City dropdown. Hitting Cities API...");
    try {
      final response = await ApiService.get(ApiEndPoint.cityAdConfigurationsAdmin);

      print("========== CITIES ON-DEMAND RESPONSE ==========");
      print("Status Code: ${response.statusCode}");
      print("Full Response Body: ${response.data}");
      print("===============================================");

      if (response.isSuccess) {
        cities.value = response.data['data'] ?? [];
      }
    } catch (e) {
      print("Error fetching cities on demand: $e");
    }
  }

  Future<void> pickImage(String type) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (type == 'logo') logoFile.value = File(pickedFile.path);
      if (type == 'cover') coverImageFile.value = File(pickedFile.path);
      if (type == 'license') tradeLicenseFile.value = File(pickedFile.path);
    }
  }

  void toggleWhatsApp(bool value) {
    isWhatsAppSameAsPhone.value = value;
    if (value) {
      whatsappController.text = phoneController.text;
    } else {
      whatsappController.clear();
    }
  }

  Future<void> createStore() async {
    try {
      isLoading.value = true;

      Map<String, dynamic> storePayload = {
        "storeType": selectedStoreType.value,
        "displayName": nameController.text.trim(),
        "description": descriptionController.text.trim(),
        "categoryId": selectedCategoryId.value,
        "cityId": selectedCityId.value,
        "phone": phoneController.text.trim(),
        "whatsapp": whatsappController.text.trim(),
        "email": emailController.text.trim(),
        "businessLicenseNumber": tradeLicenseNoController.text.trim(),
        "tinNumber": tinNumberController.text.trim(),
        "workingDays": ["monday", "tuesday", "wednesday", "thursday", "friday"],
        "openingTime": "09:00",
        "closingTime": "18:00",
        "isOpen24Hours": false,
        "timezone": "Asia/Dhaka"
      };

      Map<String, File?> files = {
        "logo": logoFile.value,
        "coverImage": coverImageFile.value,
        "tradeLicense": tradeLicenseFile.value,
      };
      final response = await ApiService.multipartRequest(
        ApiEndPoint.stores,
        bodyData: {"data": storePayload},
        files: files,
      );

      if (response.isSuccess) {
        await LocalStorage.setStoreType(selectedStoreType.value);
        Get.to(AppRoutes.accountScreen);
        Get.snackbar("Success", "Store created successfully!", backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar("Error", response.message, backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      debugPrint("Store creation error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}