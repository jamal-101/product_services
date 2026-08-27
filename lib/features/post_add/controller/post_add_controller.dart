// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:image_picker/image_picker.dart';
//
// enum City { dhaka, chattogram, other }
//
// class PostAddController extends GetxController {
//
//   var currentStep = 1.obs;
//
//   var selectedBannerType = 0.obs;
//   var selectedSlotIndex = (-1).obs;
//   var selectedPlanIndex = (-1).obs;
//
//   var startDate = ''.obs;
//   var endDate = ''.obs;
//
//   RxString selectedCity = "Select".obs;
//
//   void updateSelectedGender(City genderItem) {
//     switch (genderItem) {
//       case City.dhaka: selectedCity.value = "dhaka"; break;
//       case City.chattogram: selectedCity.value = "chattogram"; break;
//       case City.other: selectedCity.value = "Prefer not to say"; break;
//     }
//   }
//
//   void selectBannerType(int type) {
//     selectedBannerType.value = type;
//     selectedSlotIndex.value = -1;
//   }
//
//   void selectSlot(int index) {
//     selectedSlotIndex.value = index;
//   }
//
//   void selectPlan(int plan) {
//     selectedPlanIndex.value = plan;
//     calculateEndDate();
//   }
//   Future<void> chooseStartDate(BuildContext context) async {
//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2030),
//       builder: (context, child) {
//         return Theme(
//           data: ThemeData.light().copyWith(
//             colorScheme: const ColorScheme.light(
//               primary: Color(0xFF2E7D32),
//               onPrimary: Colors.white,
//               surface: Colors.white,
//               onSurface: Colors.black,
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//
//     if (picked != null) {
//       startDate.value = DateFormat('MM/dd/yyyy').format(picked);
//       calculateEndDate(picked: picked);
//     }
//   }
//   void calculateEndDate({DateTime? picked}) {
//     if (startDate.value.isEmpty || selectedPlanIndex.value == -1) return;
//
//     DateTime start = picked ?? DateFormat('MM/dd/yyyy').parse(startDate.value);
//     int daysToAdd = selectedPlanIndex.value == 1 ? 7 : 30;
//
//     DateTime end = start.add(Duration(days: daysToAdd));
//     endDate.value = DateFormat('MMM dd, yyyy').format(end);
//   }
//
//   void nextStep() {
//     if (currentStep.value == 1) {
//       currentStep.value = 2;
//     } else if (currentStep.value == 2) {
//     }
//   }
//
//   void previousStep() {
//     if (currentStep.value > 1) {
//       currentStep.value--;
//     } else {
//       Get.back();
//     }
//   }
//
//
//   RxString uploadedBannerPath = ''.obs;
//   final ImagePicker _picker = ImagePicker();
//
//   void pickBannerImage() async {
//     try {
//       final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//       if (image != null) {
//         uploadedBannerPath.value = image.path;
//       }
//     } catch (e) {
//       debugPrint("Image pick error: $e");
//     }
//   }
//
//   void removeBannerImage() {
//     uploadedBannerPath.value = '';
//   }
//
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:product_service/services/api/api_service.dart';
import 'package:product_service/utils/constants/api_enpoint.dart';

import '../presentation/screen/campaign_success_view.dart';

class PostAddController extends GetxController {

  final campaignNameController = TextEditingController();
  var selectedCityId = "".obs;
  var selectedCityName = "".obs;
  var citiesList = [].obs;
  var isLoadingCities = false.obs;

  // Step 2 Fields (Slot Availability)
  var slotAvailabilityData = Rxn<Map<String, dynamic>>();
  var selectedSlot = "".obs; // অথবা স্লট আইডি/নাম
  var slotPrice = 0.0.obs;
  var isLoadingSlots = false.obs;

  // Step 3 Fields (Creative & Schedule)
  var selectedDuration = "monthly".obs; // 'weekly' বা 'monthly'
  var startDate = "".obs;
  var endDate = "".obs;
  var featuredImage = Rxn<File>();
  final ImagePicker _picker = ImagePicker();

  // Loading for Final Submit
  var isSubmitting = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchActiveCities();
  }

  // ১. একটিভ সিটি গেট করার এপিআই
  Future<void> fetchActiveCities() async {
    try {
      isLoadingCities.value = true;
      final response = await ApiService.get(ApiEndPoint.activeCities); // বা আপনার রুট এন্ডপয়েন্ট
      if (response.isSuccess) {
        citiesList.value = response.data['data'] ?? [];
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoadingCities.value = false;
    }
  }

  // ২. স্লট অ্যাভেইল্যাবিলিটি গেট করার এপিআই
  Future<void> fetchSlotAvailability() async {
    if (selectedCityId.value.isEmpty) return;
    try {
      isLoadingSlots.value = true;
      String url = "${ApiEndPoint.slotAvailability}?cityAdConfigId=${selectedCityId.value}&advertisementType=featured";
      final response = await ApiService.get(url);
      if (response.isSuccess) {
        slotAvailabilityData.value = response.data['data'];
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoadingSlots.value = false;
    }
  }

  // ৩. ইমেজ পিকার
  Future<void> pickFeaturedImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      featuredImage.value = File(image.path);
    }
  }


  Future<void> submitAdvertisement() async {
    try {
      isSubmitting.value = true;

      // ১. বডি ডেটা ম্যাপ তৈরি
      Map<String, dynamic> bodyData = {
        "campaignName": campaignNameController.text.trim(),
        "cityAdConfigId": selectedCityId.value,
        "advertisementType": "featured",
        "startDate": startDate.value.isNotEmpty ? startDate.value : "2026-09-25",
      };

      // ২. ফাইল ম্যাপ তৈরি (আপনার ApiService এর `multipartRequest` মেথডের স্ট্রাকচার অনুযায়ী)
      Map<String, File?> files = {
        "featuredImage": featuredImage.value, // এখানে ইমেজ ফাইলটি দেওয়া হলো
      };

      // ৩. ApiService এর multipartRequest কল
      var response = await ApiService.multipartRequest(
        ApiEndPoint.createAdvertisement, // ইউআরএল
        bodyData: bodyData,              // জেসন ডাটা
        files: files,                    // ফাইলগুলো ম্যাপ আকারে
        method: "POST",                  // মেথড (ডিফল্ট POST)
      );

      if (response.isSuccess) {
        // Get.snackbar(
        //   "Success",
        //   "Advertisement created successfully!",
        //   backgroundColor: Colors.green,
        //   colorText: Colors.white,
        // );

        Get.offAll(() => const CampaignSuccessView());

      } else {
        Get.snackbar(
          "Error",
          response.message ?? "Something went wrong",
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
      isSubmitting.value = false;
    }
  }
}