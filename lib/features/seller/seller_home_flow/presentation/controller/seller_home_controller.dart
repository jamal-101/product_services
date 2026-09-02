import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../services/api/api_service.dart';
import '../../../../../services/storage/storage_service.dart';
import '../../../../../utils/constants/api_enpoint.dart';
import '../model/desh_board_model.dart';

class SellerHomeController extends GetxController {

  var dashboardData = desh_board_model().obs;
  var isDashboardLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDashboardData();
  }

  Future<void> fetchDashboardData() async {
    try {
      isDashboardLoading.value = true;
      final response = await ApiService.get(
        ApiEndPoint.sellerDashboard,
        header: {
          'Authorization': 'Bearer ${LocalStorage.token}',
          'Content-Type': 'application/json',
        },
      );

      if (response.isSuccess) {
        dashboardData.value = desh_board_model.fromJson(response.data as Map<String, dynamic>);
      }
    } catch (e) {
      debugPrint("Error fetching dashboard data: $e");
    } finally {
      isDashboardLoading.value = false;
    }
  }
}