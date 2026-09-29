import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../services/api/api_service.dart';
import '../../../../utils/constants/api_enpoint.dart';
import '../model/notification_model.dart';


class NotificationController extends GetxController {
  var isLoading = false.obs;
  var notificationList = <Data>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    isLoading.value = true;
    try {
      var response = await ApiService.get(ApiEndPoint.notifications);

      if (response.statusCode == 200) {
        var jsonResponse = response.data;
        if (jsonResponse['success'] == true) {
          NotificationModel model = NotificationModel.fromJson(jsonResponse as Map<String, dynamic>);

          // ⚠️ এখানে '!' বাদ দিয়ে সেফ চেক দিন
          if (model.data != null) {
            notificationList.value = model.data!;
          } else {
            notificationList.clear(); // ডাটা না থাকলে লিস্ট খালি করে দিন
          }
        }
      }
    } catch (e) {
      debugPrint("Error: $e");
      Get.snackbar(
        "Error",
        "Failed to load notifications",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> clearAllNotifications() async {
    try {
      // লোডিং দেখাতে চাইলে দেখাতে পারেন, অথবা সরাসরি রিকোয়েস্ট পাঠাতে পারেন
      var response = await ApiService.delete(ApiEndPoint.notifications); // অথবা আপনার ApiService-এ DELETE মেথড যেভাবে কল করা হয়

      if (response.statusCode == 200) {
        // লোকাল লিস্ট ক্লিয়ার করে রিফ্রেশ করা
        notificationList.clear();

        Get.snackbar(
          "Success",
          "All notifications cleared successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "Failed",
          "Could not clear notifications",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      debugPrint("Error clearing notifications: $e");
      Get.snackbar(
        "Error",
        "Something went wrong",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }


}