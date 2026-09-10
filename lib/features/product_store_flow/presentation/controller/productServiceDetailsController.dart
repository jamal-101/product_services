import 'dart:core';
import 'package:get/get.dart';
import '../../../../services/api/api_service.dart';
import '../model/product_model.dart';
import '../model/service_model.dart';
import '../../../../utils/constants/api_enpoint.dart';


class ProductServiceDetailsController extends GetxController {
  var isLoading = false.obs;

  Rx<ProductModel> productModel = ProductModel().obs;
  Rx<ServiceModel> serviceModel = ServiceModel().obs;
  var currentImageIndex = 0.obs;

  void fetchDetails(String id, bool isProduct) async {
    try {
      isLoading.value = true;

      if (isProduct) {
        String url = "${ApiEndPoint.baseUrl}/products/$id";
        var response = await ApiService.get(url);

        if (response.statusCode == 200 || response.statusCode == 201) {
          productModel.value = ProductModel.fromJson(response.data as Map<String, dynamic>);
        } else {
          Get.snackbar("Error", response.data['message'] ?? "Failed to load product");
        }
      } else {
        String url = "${ApiEndPoint.baseUrl}/services/$id";
        var response = await ApiService.get(url);

        if (response.statusCode == 200 || response.statusCode == 201) {
          serviceModel.value = ServiceModel.fromJson(response.data as Map<String, dynamic>);
        } else {
          Get.snackbar("Error", response.data['message'] ?? "Failed to load service");
        }
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }
}