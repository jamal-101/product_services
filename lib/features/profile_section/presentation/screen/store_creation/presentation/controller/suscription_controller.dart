// import 'package:get/get.dart';
//
// class SubscriptionController extends GetxController{
//   var selectedPlan = "Growth".obs;
//   var selectedPayment = "Card".obs;
//
//   void selectPlan(String plan) => selectedPlan.value = plan;
//   void selectPayment(String payment) => selectedPayment.value = payment;
// }

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../../services/api/api_service.dart';
import '../../../../../../../utils/constants/api_enpoint.dart';
import '../model/subscription_model.dart';

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
        "${ApiEndPoint.baseUrl}/subscription-packages?packageType=store_creation",
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
  Future<void> purchaseSubscription() async {
    if (selectedPlanId.value.isEmpty) {
      Get.snackbar("Warning", "Please select a subscription plan first");
      return;
    }

    try {
      isPurchasing.value = true;
      final Map<String, dynamic> body = {
        "packageId": selectedPlanId.value,
      };

      final response = await ApiService.post(
        "${ApiEndPoint.baseUrl}/stripe/create-checkout-session",
        body: body,
      );

      if (response.isSuccess) {
        final resData = response.data;
        String? stripeUrl = resData['data']?['url'];
        if (stripeUrl != null && stripeUrl.isNotEmpty) {
          final cleanUrl = stripeUrl.replaceAll('\n', '').trim();
          final Uri uri = Uri.parse(cleanUrl);
          try {
            await launchUrl(
              uri,
              mode: LaunchMode.externalApplication,
            );
          } catch (launchError) {
            Get.snackbar("Error", "Could not open payment link: $launchError");
          }
        } else {
          Get.snackbar("Error", "Payment URL not found in response");
        }
      } else {
        final errorMsg = response.data['message'];
        Get.snackbar("Error", errorMsg ?? "Failed to create checkout session");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isPurchasing.value = false;
    }
  }
}