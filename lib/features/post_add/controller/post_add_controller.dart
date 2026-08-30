// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:product_service/services/api/api_service.dart';
// import 'package:product_service/utils/constants/api_enpoint.dart';
// import 'package:product_service/services/storage/storage_service.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../services/storage/storage_key.dart';
// import '../../auth_flow/presentation/controller/auth_controller.dart';
// import '../presentation/screen/campaign_success_view.dart';
// import '../presentation/screen/post_add_step1.dart';
//
//
// class PostAddController extends GetxController {
//
//   final campaignNameController = TextEditingController();
//   var selectedCityId = "".obs;
//   var selectedCityName = "".obs;
//   var citiesList = [].obs;
//   var isLoadingCities = false.obs;
//
//   var slotAvailabilityData = Rxn<Map<String, dynamic>>();
//   var selectedSlot = "".obs;
//   var slotPrice = 0.0.obs;
//   var isLoadingSlots = false.obs;
//
//   var selectedDuration = "monthly".obs;
//   var startDate = "".obs;
//   var endDate = "".obs;
//   var featuredImage = Rxn<File>();
//   final ImagePicker _picker = ImagePicker();
//
//   var isSubmitting = false.obs;
//   var isVerifying = false.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//   }
//
//
//
//   Future<void> checkAndNavigateToPostAd() async {
//     try {
//       isVerifying.value = true;
//       final response = await ApiService.get(ApiEndPoint.verifySellerForPosting);
//       if (response.isSuccess) {
//         final AuthController authController = Get.find<AuthController>();
//         authController.selectedRole.value = 'seller';
//         await LocalStorage.setUserRole('seller');
//
//         await fetchActiveCities();
//
//         Get.to(() => const PostAdStep1Screen());
//
//       } else {
//         Get.rawSnackbar(
//           messageText: Text(
//             response.message,
//             style: GoogleFonts.plusJakartaSans(
//               fontSize: 13.sp,
//               color: Colors.white,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           backgroundColor: Colors.red.shade600,
//           snackPosition: SnackPosition.BOTTOM,
//           margin: EdgeInsets.all(16.w),
//           borderRadius: 12.r,
//           duration: const Duration(seconds: 3),
//           icon: const Icon(Icons.error_outline, color: Colors.white),
//         );
//       }
//     } catch (e) {
//       Get.rawSnackbar(
//         messageText: Text(
//           e.toString(),
//           style: GoogleFonts.plusJakartaSans(fontSize: 13.sp, color: Colors.white),
//         ),
//         backgroundColor: Colors.red.shade600,
//         snackPosition: SnackPosition.BOTTOM,
//         margin: EdgeInsets.all(16.w),
//         borderRadius: 12.r,
//       );
//     } finally {
//       isVerifying.value = false;
//     }
//   }
//
//
//
//
//
//   Future<void> fetchActiveCities() async {
//     try {
//       isLoadingCities.value = true;
//       final response = await ApiService.get(
//         ApiEndPoint.activeCities,
//         header: {
//           'Authorization': 'Bearer ${LocalStorage.sellerAccessToken}',
//           'Content-Type': 'application/json',
//         },
//       );
//
//       if (response.isSuccess) {
//         citiesList.value = response.data['data'] ?? [];
//       } else {
//         Get.snackbar(
//           "Error",
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
//       isLoadingCities.value = false;
//     }
//   }
//
//   Future<void> fetchSlotAvailability() async {
//     if (selectedCityId.value.isEmpty) return;
//     try {
//       isLoadingSlots.value = true;
//       String url = "${ApiEndPoint.slotAvailability}?cityAdConfigId=${selectedCityId.value}&advertisementType=featured";
//
//       final response = await ApiService.get(
//         url,
//         header: {
//           'Authorization': 'Bearer ${LocalStorage.sellerAccessToken}',
//           'Content-Type': 'application/json',
//         },
//       );
//
//       if (response.isSuccess) {
//         slotAvailabilityData.value = response.data['data'];
//       }
//     } catch (e) {
//       Get.snackbar("Error", e.toString(), backgroundColor: Colors.red, colorText: Colors.white);
//     } finally {
//       isLoadingSlots.value = false;
//     }
//   }
//
//   Future<void> pickFeaturedImage() async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       featuredImage.value = File(image.path);
//     }
//   }
//
//
//   Future<void> submitAdvertisement() async {
//     try {
//       isSubmitting.value = true;
//       final prefs = await SharedPreferences.getInstance();
//
//       String currentToken = prefs.getString(LocalStorageKeys.token) ?? "";
//
//       print("Using Main User Token for Advertisement: $currentToken");
//
//       Map<String, dynamic> bodyData = {
//         "campaignName": campaignNameController.text.trim(),
//         "cityAdConfigId": selectedCityId.value,
//         "advertisementType": "featured",
//         "slot": selectedSlot.value,
//         "duration": selectedDuration.value,
//         "startDate": startDate.value,
//       };
//
//       Map<String, File?> files = {
//         "featuredImage": featuredImage.value,
//       };
//
//       var response = await ApiService.multipartRequest(
//         ApiEndPoint.createAdvertisement,
//         bodyData: bodyData,
//         files: files,
//         method: "POST",
//         header: {
//           'Authorization': 'Bearer $currentToken',
//         },
//       );
//
//       if (response.isSuccess) {
//         Get.offAll(() => const CampaignSuccessView());
//       } else {
//         Get.snackbar(
//           "Error",
//           response.message,
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//           snackPosition: SnackPosition.BOTTOM,
//         );
//       }
//     } catch (e) {
//       Get.snackbar(
//         "Error",
//         e.toString(),
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       isSubmitting.value = false;
//     }
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/api/api_service.dart';
import '../../../services/storage/storage_key.dart';
import '../../../services/storage/storage_service.dart';
import '../../../utils/constants/api_enpoint.dart';
import '../../auth_flow/presentation/controller/auth_controller.dart';
import '../presentation/screen/campaign_success_view.dart';
import '../presentation/screen/post_add_step1.dart';

class PostAddController extends GetxController {

  final campaignNameController = TextEditingController();
  var selectedCityId = "".obs;
  var selectedCityName = "".obs;
  var citiesList = [].obs;
  var isLoadingCities = false.obs;

  var slotAvailabilityData = Rxn<Map<String, dynamic>>();
  var selectedSlot = "".obs;
  var slotPrice = 0.0.obs;
  var isLoadingSlots = false.obs;

  var selectedDuration = "monthly".obs;
  var startDate = "".obs;
  var endDate = "".obs;
  var featuredImage = Rxn<File>();
  final ImagePicker _picker = ImagePicker();

  var isSubmitting = false.obs;
  var isVerifying = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  // Future<void> checkAndNavigateToPostAd() async {
  //   try {
  //     isVerifying.value = true;
  //     final response = await ApiService.get(
  //       ApiEndPoint.verifySellerForPosting,
  //       header: {
  //         'Authorization': 'Bearer ${LocalStorage.token}',
  //         'Content-Type': 'application/json',
  //       },
  //     );
  //
  //     if (response.isSuccess) {
  //       final AuthController authController = Get.find<AuthController>();
  //       authController.selectedRole.value = 'seller';
  //       await LocalStorage.setUserRole('seller');
  //       bool isCityFetched = await fetchActiveCities();
  //       if (!isCityFetched) return;
  //       Get.to(() => const PostAdStep1Screen());
  //
  //     } else {
  //       Get.rawSnackbar(
  //         messageText: Text(
  //           response.message,
  //           style: GoogleFonts.plusJakartaSans(
  //             fontSize: 13.sp,
  //             color: Colors.white,
  //             fontWeight: FontWeight.w500,
  //           ),
  //         ),
  //         backgroundColor: Colors.red.shade600,
  //         snackPosition: SnackPosition.BOTTOM,
  //         margin: EdgeInsets.all(16.w),
  //         borderRadius: 12.r,
  //         duration: const Duration(seconds: 3),
  //         icon: const Icon(Icons.error_outline, color: Colors.white),
  //       );
  //     }
  //   } catch (e) {
  //     Get.rawSnackbar(
  //       messageText: Text(
  //         e.toString(),
  //         style: GoogleFonts.plusJakartaSans(fontSize: 13.sp, color: Colors.white),
  //       ),
  //       backgroundColor: Colors.red.shade600,
  //       snackPosition: SnackPosition.BOTTOM,
  //       margin: EdgeInsets.all(16.w),
  //       borderRadius: 12.r,
  //     );
  //   } finally {
  //     isVerifying.value = false;
  //   }
  // }


  Future<void> checkAndNavigateToPostAd() async {
    try {
      isVerifying.value = true;

      final response = await ApiService.get(
        ApiEndPoint.verifySellerForPosting,
        header: {
          'Authorization': 'Bearer ${LocalStorage.token}',
          'Content-Type': 'application/json',
        },
      );

      if (response.isSuccess) {
        final responseData = response.data['data'];
        final bool hasStore = responseData['hasStore'] ?? false;
        if (!hasStore) {
          Get.rawSnackbar(
            messageText: Text(
              "You must create a store first to post an ad!",
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13.sp,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            backgroundColor: Colors.red.shade600,
            snackPosition: SnackPosition.TOP,
            margin: EdgeInsets.all(16.w),
            borderRadius: 12.r,
            duration: const Duration(seconds: 3),
            icon: const Icon(Icons.error_outline, color: Colors.white),
          );
          return;
        }
        final AuthController authController = Get.find<AuthController>();
        authController.selectedRole.value = 'seller';
        await LocalStorage.setUserRole('seller');

        bool isCityFetched = await fetchActiveCities();
        if (!isCityFetched) return;
        Get.to(() => const PostAdStep1Screen());

      } else {
        Get.rawSnackbar(
          messageText: Text(
            response.message,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13.sp,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: Colors.red.shade600,
          snackPosition: SnackPosition.TOP,
          margin: EdgeInsets.all(16.w),
          borderRadius: 12.r,
          duration: const Duration(seconds: 3),
          icon: const Icon(Icons.error_outline, color: Colors.white),
        );
      }
    } catch (e) {
      Get.rawSnackbar(
        messageText: Text(
          e.toString(),
          style: GoogleFonts.plusJakartaSans(fontSize: 13.sp, color: Colors.white),
        ),
        backgroundColor: Colors.red.shade600,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(16.w),
        borderRadius: 12.r,
      );
    } finally {
      isVerifying.value = false;
    }
  }

  Future<bool> fetchActiveCities() async {
    try {
      isLoadingCities.value = true;
      final response = await ApiService.get(
        ApiEndPoint.activeCities,
        header: {
          'Authorization': 'Bearer ${LocalStorage.token}',
          'Content-Type': 'application/json',
        },
      );

      if (response.isSuccess) {
        citiesList.value = response.data['data'] ?? [];
        return true;
      } else {
        Get.snackbar(
          "Error",
          response.message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    } finally {
      isLoadingCities.value = false;
    }
  }

  Future<void> fetchSlotAvailability() async {
    if (selectedCityId.value.isEmpty) return;
    try {
      isLoadingSlots.value = true;
      String url = "${ApiEndPoint.slotAvailability}?cityAdConfigId=${selectedCityId.value}&advertisementType=featured";

      final response = await ApiService.get(
        url,
        header: {
          'Authorization': 'Bearer ${LocalStorage.token}',
          'Content-Type': 'application/json',
        },
      );

      if (response.isSuccess) {
        slotAvailabilityData.value = response.data['data'];
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoadingSlots.value = false;
    }
  }

  Future<void> pickFeaturedImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      featuredImage.value = File(image.path);
    }
  }

  Future<void> submitAdvertisement() async {
    try {
      isSubmitting.value = true;
      final prefs = await SharedPreferences.getInstance();

      String currentToken = prefs.getString(LocalStorageKeys.token) ?? "";

      Map<String, dynamic> bodyData = {
        "campaignName": campaignNameController.text.trim(),
        "cityAdConfigId": selectedCityId.value,
        "advertisementType": "featured",
        "slot": selectedSlot.value,
        "duration": selectedDuration.value,
        "startDate": startDate.value,
      };

      Map<String, File?> files = {
        "featuredImage": featuredImage.value,
      };

      var response = await ApiService.multipartRequest(
        ApiEndPoint.createAdvertisement,
        bodyData: bodyData,
        files: files,
        method: "POST",
        header: {
          'Authorization': 'Bearer $currentToken',
        },
      );

      if (response.isSuccess) {
        Get.offAll(() => const CampaignSuccessView());
      } else {
        Get.snackbar(
          "Error",
          response.message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isSubmitting.value = false;
    }
  }
}