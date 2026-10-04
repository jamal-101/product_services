import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:product_service/config/route/app_route.dart';
import '../../../../../../../services/api/api_service.dart';
import '../../../../../../../services/storage/storage_service.dart';
import '../../../../../../../utils/constants/api_enpoint.dart';
import '../../../../../../auth_flow/presentation/controller/auth_controller.dart';

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

  var categoryPage = 1.obs;
  var hasMoreCategory = true.obs;
  var isCategoryLoadingMore = false.obs;

  Rx<File?> logoFile = Rx<File?>(null);
  Rx<File?> coverImageFile = Rx<File?>(null);

  final phoneController = TextEditingController();
  final whatsappController = TextEditingController();
  final emailController = TextEditingController();
  var isWhatsAppSameAsPhone = false.obs;

  final tinNumberController = TextEditingController();

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories(isRefresh: true);
    fetchCitiesOnDemand();
  }

  Future<void> fetchCategories({bool isRefresh = false}) async {
    if (isRefresh) {
      categoryPage.value = 1;
      hasMoreCategory.value = true;
      categories.clear();
    }

    if (!hasMoreCategory.value || isLoading.value) return;

    try {
      if (categoryPage.value == 1) {
        isLoading.value = true;
      } else {
        isCategoryLoadingMore.value = true;
      }
      final response = await ApiService.get(
        '${ApiEndPoint.categories}?page=${categoryPage.value}&limit=10',
      );

      if (response.isSuccess) {
        final List fetchedData = response.data['data'] ?? [];
        final meta = response.data['meta'];

        if (fetchedData.isNotEmpty) {
          categories.addAll(fetchedData);
        }
        if (meta != null) {
          hasMoreCategory.value = meta['hasNextPage'] ?? false;
        } else {
          hasMoreCategory.value = false;
        }
      }
    } catch (e) {
      debugPrint("Error fetching categories: $e");
    } finally {
      isLoading.value = false;
      isCategoryLoadingMore.value = false;
    }
  }

  void loadMoreCategories() {
    if (!isCategoryLoadingMore.value && hasMoreCategory.value) {
      categoryPage.value++;
      fetchCategories();
    }
  }

  void fetchCitiesOnDemand() async {
    try {
      final response = await ApiService.get(
        ApiEndPoint.activeCities,
      );

      if (response.isSuccess) {
        cities.value = response.data['data'] ?? [];
      }
    } catch (e) {
      print("Error fetching cities on demand: $e");
    }
  }

  Future<void> pickImage(String type, ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      if (type == 'logo') logoFile.value = File(pickedFile.path);
      if (type == 'cover') coverImageFile.value = File(pickedFile.path);
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
        "businessLicenseNumber": tinNumberController.text.trim(),
        "tinNumber": tinNumberController.text.trim(),
        "workingDays": ["monday", "tuesday", "wednesday", "thursday", "friday"],
        "openingTime": "09:00",
        "closingTime": "18:00",
        "isOpen24Hours": false,
        "timezone": "Asia/Dhaka",
      };

      final compressedLogo = await _compressImage(logoFile.value, 'logo');
      final compressedCover = await _compressImage(
        coverImageFile.value,
        'cover',
      );

      Map<String, File?> files = {
        "logo": compressedLogo,
        "coverImage": compressedCover,
      };
      
      final response = await ApiService.multipartRequest(
        ApiEndPoint.stores,
        bodyData: {"data": storePayload},
        files: files,
        header: {
          'Authorization':
              'Bearer ${LocalStorage.sellerAccessToken.isNotEmpty ? LocalStorage.sellerAccessToken : LocalStorage.token}',
        },
      );

      if (response.isSuccess) {
        // ১. সেলার মোডে সুইচ করা
        await LocalStorage.setUserRole('seller');
        await LocalStorage.setStoreType(selectedStoreType.value);
        if (Get.isRegistered<AuthController>()) {
          Get.find<AuthController>().selectedRole.value = 'seller';
        }

        Get.snackbar(
          "Success",
          "Store created successfully!",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAllNamed(AppRoutes.sellerHomeScreen);
      } else {
        Get.snackbar(
          "Error",
          response.message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      debugPrint("Store creation error: $e");
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

  Future<File?> _compressImage(File? file, String label) async {
    if (file == null || !await file.exists()) return file;
    final originalBytes = await file.length();
    if (originalBytes <= 500 * 1024) return file;
    try {
      final tempDir = Directory.systemTemp;
      final targetPath =
          '${tempDir.path}/store_${label}_${DateTime.now().millisecondsSinceEpoch}.jpg';

      XFile? result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: 70,
        minWidth: 1280,
        minHeight: 1280,
        format: CompressFormat.jpeg,
      );

      if (result == null) return file;
      return File(result.path);
    } catch (e) {
      return file;
    }
  }
}
