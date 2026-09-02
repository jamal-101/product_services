import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../services/api/api_service.dart';
import '../../../../../utils/constants/api_enpoint.dart';
import '../../../../profile_section/presentation/controller/profile_controller.dart';
import '../model/service_model.dart' as s_model;
import '../model/product_model.dart' as p_model;

class MyListingController extends GetxController {
  var isLoading = true.obs;

  var serviceList = <s_model.Data>[].obs;
  var productList = <p_model.Data>[].obs;

  late ProfileController profileController;

  @override
  void onInit() {
    super.onInit();

    if (Get.isRegistered<ProfileController>()) {
      profileController = Get.find<ProfileController>();
    } else {
      profileController = Get.put(ProfileController());
    }
    ever(profileController.profileModel, (_) {
      fetchMyListings();
    });
    if (profileController.profileModel.value.data != null) {
      fetchMyListings();
    }
  }

  String get storeType {
    return profileController.profileModel.value.data?.storeType ?? "product_store";
  }

  Future<void> fetchMyListings() async {
    if (profileController.profileModel.value.data == null) return;

    try {
      isLoading.value = true;
      if (storeType == "service_store") {
        await _fetchServices();
      } else {
        await _fetchProducts();
      }
    } catch (e) {
      debugPrint("Error fetching listings: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _fetchServices() async {
    // final response = await ApiService.get("/services/my-services");
    final response = await ApiService.get(ApiEndPoint.myServices);
    if (response.isSuccess) {
      s_model.ServiceModel model = s_model.ServiceModel.fromJson(response.data as Map<String, dynamic>);
      serviceList.value = model.data ?? [];
    }
  }

  Future<void> _fetchProducts() async {
    // final response = await ApiService.get("/products/my-products");
    final response = await ApiService.get(ApiEndPoint.myProducts);
    if (response.isSuccess) {
      p_model.get_product_model model = p_model.get_product_model.fromJson(response.data as Map<String, dynamic>);
      productList.value = model.data ?? [];
    }
  }

  void deleteItem(String id) async {
    try {
      // String endpoint = storeType == "service_store" ? "/services/$id" : "/products/$id";
      String endpoint = storeType == "service_store"
          ? '${ApiEndPoint.services}/$id'
          : '${ApiEndPoint.products}/$id';
      final response = await ApiService.delete(endpoint);

      if (response.isSuccess) {
        Get.snackbar(
          "Success",
          "Item deleted successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        fetchMyListings();
      } else {
        Get.snackbar(
          "Error",
          response.message.isNotEmpty ? response.message : "Failed to delete",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      debugPrint("Error deleting item: $e");
    }
  }
}

