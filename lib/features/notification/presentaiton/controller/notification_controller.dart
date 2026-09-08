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
          if (model.data != null) {
            notificationList.value = model.data!;
          }
        }
      }
    } catch (e) {
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
}