import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../../services/api/api_service.dart';
import '../../../../../../../utils/constants/api_enpoint.dart';
import '../model/subscription_model.dart';
import '../screen/datafast_payment_screen.dart';
import 'store_creation_controller.dart';

class SubscriptionController extends GetxController {
  var isLoading = false.obs;
  var isPurchasing = false.obs;
  var subscriptionList = <Data>[].obs;

  var selectedPlanId = "".obs;
  var selectedPlanName = "".obs;
  var selectedPayment = "Card".obs;

  @override
  void onInit() {
    super.onInit();
    fetchSubscriptionPackages();
  }

  void fetchSubscriptionPackages() async {
    try {
      isLoading.value = true;
      final response = await ApiService.get(
        "${ApiEndPoint.subscriptionPackages}?packageType=store_creation",
      );

      if (response.isSuccess) {
        final responseData = Map<String, dynamic>.from(response.data);
        Subscription_Model model = Subscription_Model.fromJson(responseData);
        if (model.data != null && model.data!.isNotEmpty) {
          subscriptionList.assignAll(model.data!);
          selectedPlanId.value = subscriptionList.first.sId ?? "";
          selectedPlanName.value = subscriptionList.first.name ?? "";
        }
      } else {
        Get.snackbar("Error", response.message);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void selectPlan(String id, String name) {
    selectedPlanId.value = id;
    selectedPlanName.value = name;
  }

  void selectPayment(String payment) => selectedPayment.value = payment;

  // Datafast Payment সলিউশন - পেমেন্ট শেষে স্টোর তৈরির কলব্যাকসহ
  Future<void> startDatafastPayment({Future<void> Function()? onSuccess}) async {
    if (selectedPlanId.value.isEmpty) {
      Get.snackbar("Warning", "Please select a subscription plan first");
      return;
    }

    try {
      isPurchasing.value = true;
      
      String? cityId;
      if (Get.isRegistered<StoreCreationController>()) {
        cityId = Get.find<StoreCreationController>().selectedCityId.value;
      }

      if (cityId == null || cityId.isEmpty) {
        Get.snackbar("Error", "Please select a city/location in the store setup first.");
        isPurchasing.value = false;
        return;
      }

      final Map<String, dynamic> body = {
        "packageId": selectedPlanId.value,
        "cityConfigId": cityId,
        "position": 1
      };

      final response = await ApiService.post(
        ApiEndPoint.createDatafastCheckout,
        body: body,
      );

      if (response.isSuccess) {
        final resData = response.data;
        debugPrint("Datafast Response: $resData");

        String? checkoutId;
        String? paymentUrl;
        
        if (resData is Map && resData['data'] != null) {
          final innerData = resData['data'];
          if (innerData is Map) {
            checkoutId = (innerData['checkoutId'] ?? innerData['id'] ?? innerData['sessionId'])?.toString();
            paymentUrl = (innerData['paymentUrl'] ?? innerData['url'])?.toString();
          }
        }

        if (checkoutId != null && checkoutId.isNotEmpty) {
          Get.to(() => DatafastPaymentScreen(
            checkoutId: checkoutId!,
            paymentUrl: paymentUrl,
            onPaymentSuccess: (resultUrl) async {
              // পেমেন্ট সফল হওয়ার পর কলব্যাকটি রান করবে এবং await করবে
              if (onSuccess != null) {
                await onSuccess();
              }
            },
          ));
        } else {
          Get.snackbar("Error", "Checkout ID missing in response. Please try again.");
        }
      } else {
        Get.snackbar("Error", response.message);
      }
    } catch (e) {
      Get.snackbar("Error", "An unexpected error occurred: $e");
    } finally {
      isPurchasing.value = false;
    }
  }

  // Stripe Payment (যদি প্রয়োজন হয়)
  Future<void> purchaseSubscription() async {
    if (selectedPlanId.value.isEmpty) {
      Get.snackbar("Warning", "Please select a subscription plan first");
      return;
    }
    try {
      isPurchasing.value = true;
      final Map<String, dynamic> body = {"packageId": selectedPlanId.value};
      final response = await ApiService.post(ApiEndPoint.createStripeCheckout, body: body);
      if (response.isSuccess) {
        String? stripeUrl = response.data['data']?['url'];
        if (stripeUrl != null) await launchUrl(Uri.parse(stripeUrl.trim()), mode: LaunchMode.externalApplication);
      } else {
        Get.snackbar("Error", response.message);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isPurchasing.value = false;
    }
  }
}
