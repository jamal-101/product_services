import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../../services/api/api_service.dart';
import '../../../../../../../services/storage/storage_service.dart';
import '../../../../../../../utils/constants/api_enpoint.dart';
import '../model/subscription_model.dart';
import '../screen/datafast_payment_screen.dart';

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

  /// Store creation: only packageId is required.
  /// (Ad posting uses packageId + cityConfigId + position in PostAddController.)
  Future<void> startDatafastPayment() async {
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
        "${ApiEndPoint.baseUrl}/datafast/create-checkout-session",
        body: body,
        header: {
          'Authorization':
              'Bearer ${LocalStorage.sellerAccessToken.isNotEmpty ? LocalStorage.sellerAccessToken : LocalStorage.token}',
          'Content-Type': 'application/json',
        },
      );

      if (response.isSuccess) {
        final resData = response.data;
        final data = resData is Map ? resData['data'] : null;
        String? checkoutId;
        if (data is Map) {
          checkoutId = data['id']?.toString() ??
              data['checkoutId']?.toString() ??
              data['ndc']?.toString();
        }
        checkoutId ??= resData['checkoutId']?.toString() ??
            resData['id']?.toString();

        if (checkoutId != null && checkoutId.isNotEmpty) {
          Get.to(() => DatafastPaymentScreen(
                checkoutId: checkoutId!,
                onPaymentSuccess: (resultUrl) =>
                    verifyDatafastPayment(checkoutId!, resultUrl),
              ));
        } else {
          Get.snackbar("Error", "Checkout ID not found in server response");
        }
      } else {
        Get.snackbar(
          "Error",
          response.message.isNotEmpty
              ? response.message
              : "Failed to initiate Datafast payment",
        );
      }
    } catch (e) {
      Get.snackbar("Error", "An unexpected error occurred: $e");
    } finally {
      isPurchasing.value = false;
    }
  }

  /// POST /datafast/verify-payment after widget redirect (store_creation).
  Future<void> verifyDatafastPayment(
    String checkoutId, [
    String? resultUrl,
  ]) async {
    if (selectedPlanId.value.isEmpty) {
      Get.snackbar("Error", "Package ID missing for payment verification");
      return;
    }

    String resourcePath = '';
    String resolvedCheckoutId = checkoutId;
    if (resultUrl != null && resultUrl.isNotEmpty) {
      final uri = Uri.tryParse(resultUrl);
      resourcePath = uri?.queryParameters['resourcePath'] ?? '';
      final idFromQuery = uri?.queryParameters['id'];
      if (idFromQuery != null && idFromQuery.isNotEmpty) {
        resolvedCheckoutId = idFromQuery;
      }
    }

    try {
      isPurchasing.value = true;
      final body = <String, dynamic>{
        "checkoutId": resolvedCheckoutId,
        "packageId": selectedPlanId.value,
      };
      if (resourcePath.isNotEmpty) {
        body["resourcePath"] = resourcePath;
      }

      // Let OPPWA settle before status GET (backend)
      await Future.delayed(const Duration(seconds: 5));

      final response = await ApiService.post(
        "${ApiEndPoint.baseUrl}/datafast/verify-payment",
        body: body,
        header: {
          'Authorization':
              'Bearer ${LocalStorage.sellerAccessToken.isNotEmpty ? LocalStorage.sellerAccessToken : LocalStorage.token}',
          'Content-Type': 'application/json',
        },
      );

      if (response.isSuccess) {
        Get.snackbar(
          "Success",
          response.message.isNotEmpty
              ? response.message
              : "Payment verified successfully",
        );
      } else {
        Get.snackbar(
          "Payment verification failed",
          response.message.isNotEmpty
              ? response.message
              : "Could not verify Datafast payment",
        );
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isPurchasing.value = false;
    }
  }
}
