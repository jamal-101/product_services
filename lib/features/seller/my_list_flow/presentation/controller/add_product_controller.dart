import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:product_service/features/seller/my_list_flow/presentation/screen/my_list_screen.dart';
import '../../../../../services/api/api_service.dart';
import '../../../../../utils/constants/api_enpoint.dart';
import '../../../../profile_section/presentation/controller/profile_controller.dart';
import 'listing_controller.dart';


class AddProductController extends GetxController {
  var isLoading = false.obs;

  final titleController = TextEditingController();
  final activePriceController = TextEditingController();
  final originalPriceController = TextEditingController();
  final descriptionController = TextEditingController();
  final extraInfoController = TextEditingController();

  var whatsIncludedList = <TextEditingController>[].obs;

  var selectedImage = Rxn<File>();
  final ImagePicker _picker = ImagePicker();

  late ProfileController profileController;

  String get storeType {
    if (Get.isRegistered<ProfileController>()) {
      profileController = Get.find<ProfileController>();
      return profileController.profileModel.value.data?.storeType ?? "product_store";
    }
    return "product_store";
  }

  bool isEditMode = false;
  String? itemId;

  @override
  void onInit() {
    super.onInit();
    if (Get.isRegistered<ProfileController>()) {
      profileController = Get.find<ProfileController>();
    } else {
      profileController = Get.put(ProfileController());
    }

    final dynamic arguments = Get.arguments;
    if (arguments != null) {
      isEditMode = true;

      itemId = arguments.sId;
      titleController.text = arguments.title ?? '';
      activePriceController.text = arguments.activePrice?.toString() ?? '';
      originalPriceController.text = arguments.originalPrice?.toString() ?? '';
      descriptionController.text = arguments.description ?? '';

      if (storeType == "product_store") {
        extraInfoController.text = arguments.additionalInformation ?? '';
      } else {
        List<dynamic> included = arguments.whatsIncluded ?? [];
        whatsIncludedList.value = included.map((e) => TextEditingController(text: e.toString())).toList();
      }
    }

    if (storeType == "service_store" && whatsIncludedList.isEmpty) {
      addWhatsIncludedField();
    }
  }

  // Future<void> pickImage() async {
  //   final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  //   if (image != null) {
  //     selectedImage.value = File(image.path);
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
                await _getImage(ImageSource.gallery);
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

  // Image Source ও Compression হ্যান্ডেল করার প্রাইভেট মেথড
  Future<void> _getImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 50, // ৪১৩ এরর এড়াতে সাইজ ও কোয়ালিটি কমানো হয়েছে
        maxWidth: 1024,
        maxHeight: 1024,
      );

      if (image != null) {
        selectedImage.value = File(image.path);
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  void addWhatsIncludedField() {
    whatsIncludedList.add(TextEditingController());
  }

  void removeWhatsIncludedField(int index) {
    if (whatsIncludedList.length > 1) {
      whatsIncludedList.removeAt(index);
    } else {
      whatsIncludedList[index].clear();
    }
  }

  Future<void> submitData() async {
    if (titleController.text.isEmpty || activePriceController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill in all required fields",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    try {
      isLoading.value = true;

      Map<String, dynamic> bodyJson = {
        "title": titleController.text.trim(),
        "activePrice": double.tryParse(activePriceController.text.trim()) ?? 0,
        "originalPrice": double.tryParse(originalPriceController.text.trim()) ?? 0,
        "description": descriptionController.text.trim(),
      };

      if (storeType == "product_store") {
        bodyJson["additionalInformation"] = extraInfoController.text.trim();
      } else {
        bodyJson["whatsIncluded"] = whatsIncludedList
            .map((controller) => controller.text.trim())
            .where((text) => text.isNotEmpty)
            .toList();
      }

      String endpoint = storeType == "service_store" ? ApiEndPoint.services : ApiEndPoint.products;
      String method = "POST";

      if (isEditMode && itemId != null) {
        endpoint = "$endpoint/$itemId";
        method = "PATCH";
      }

      Map<String, File?> filesMap = {};
      if (selectedImage.value != null) {
        filesMap["images"] = selectedImage.value;
      }

      var response = await ApiService.multipartRequest(
        endpoint,
        bodyData: {"data": bodyJson},
        files: filesMap,
        method: method,
      );

      debugPrint("API Response Success: ${response.isSuccess}");
      debugPrint("API Response Data: ${response.data}");

      if (response.isSuccess == true) {
        Get.snackbar(
          "Success",
          isEditMode ? "Updated successfully!" : "Added successfully!",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 2),
        );
        if (Get.isRegistered<MyListingController>()) {
          Get.put(MyListingController()).fetchMyListings();
        }
        Get.to(MyListingScreen());
      } else {
        Get.snackbar(
          "Error",
          response.data['message'] ?? "Failed to process",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      debugPrint("Error submitting data: $e");
      Get.snackbar(
        "Error",
        "Something went wrong: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    activePriceController.dispose();
    originalPriceController.dispose();
    descriptionController.dispose();
    extraInfoController.dispose();
    for (var c in whatsIncludedList) {
      c.dispose();
    }
    super.onClose();
  }
}