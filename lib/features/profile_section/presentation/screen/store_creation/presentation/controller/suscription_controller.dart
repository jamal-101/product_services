import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../config/route/app_route.dart';
import '../../../../../../../services/api/api_service.dart';
import '../../../../../../../services/storage/storage_service.dart';
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

  Map<String, String> get _sellerAuthHeader => {
        'Authorization':
            'Bearer ${LocalStorage.sellerAccessToken.isNotEmpty ? LocalStorage.sellerAccessToken : LocalStorage.token}',
        'Content-Type': 'application/json',
      };

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
        final Subscription_Model model =
            Subscription_Model.fromJson(responseData);

        final packages = (model.data ?? []).where((p) {
          final status = (p.status ?? '').toLowerCase();
          return status.isEmpty || status == 'active';
        }).toList();

        if (packages.isNotEmpty) {
          subscriptionList.assignAll(packages);
          selectedPlanId.value = subscriptionList.first.sId ?? "";
          selectedPlanName.value = subscriptionList.first.name ?? "";
        } else {
          subscriptionList.clear();
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
    // Legacy Stripe path — prefer Datafast for store creation
    await startDatafastPayment();
  }

  /// Store creation: POST body is only `{ packageId }`.
  /// Opens backend `paymentUrl` in WebView, then verify → create store.
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
        header: _sellerAuthHeader,
      );

      if (response.isSuccess) {
        final resData = response.data;
        final data = resData is Map ? resData['data'] : null;

        String? checkoutId;
        String? paymentUrl;
        if (data is Map) {
          checkoutId = data['checkoutId']?.toString() ??
              data['sessionId']?.toString() ??
              data['id']?.toString() ??
              data['ndc']?.toString();
          paymentUrl = data['paymentUrl']?.toString() ??
              data['url']?.toString();
        }
        checkoutId ??= resData['checkoutId']?.toString() ??
            resData['id']?.toString();
        paymentUrl ??= resData['paymentUrl']?.toString() ??
            resData['url']?.toString();

        paymentUrl = _normalizePaymentUrl(paymentUrl);

        if (checkoutId != null && checkoutId.isNotEmpty) {
          Get.to(
            () => DatafastPaymentScreen(
              checkoutId: checkoutId!,
              paymentUrl: paymentUrl,
              onPaymentSuccess: (resultUrl) =>
                  verifyDatafastPayment(checkoutId!, resultUrl),
            ),
          );
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

  String? _normalizePaymentUrl(String? raw) {
    if (raw == null || raw.trim().isEmpty) return null;
    final uri = Uri.tryParse(raw.trim());
    if (uri == null) return raw.trim();
    if (uri.scheme == 'http' &&
        uri.host.isNotEmpty &&
        uri.host != 'localhost' &&
        !uri.host.startsWith('10.') &&
        !uri.host.startsWith('192.168.')) {
      return uri.replace(scheme: 'https').toString();
    }
    return raw.trim();
  }

  /// POST /datafast/verify-payment → then create store if wizard data exists.
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

      debugPrint('🔐 store verify-payment body: $body');
      await Future.delayed(const Duration(seconds: 5));

      final response = await ApiService.post(
        "${ApiEndPoint.baseUrl}/datafast/verify-payment",
        body: body,
        header: _sellerAuthHeader,
      );

      if (!response.isSuccess) {
        Get.snackbar(
          "Payment verification failed",
          response.message.isNotEmpty
              ? response.message
              : "Could not verify Datafast payment",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      Get.snackbar(
        "Success",
        response.message.isNotEmpty
            ? response.message
            : "Payment verified successfully",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // New store wizard: create store after successful payment
      if (Get.isRegistered<StoreCreationController>()) {
        final storeCtrl = Get.find<StoreCreationController>();
        final hasWizardData =
            storeCtrl.nameController.text.trim().isNotEmpty &&
                storeCtrl.selectedCategoryId.value.isNotEmpty;
        if (hasWizardData) {
          await storeCtrl.createStore();
          return;
        }
      }

      // Subscription-only path (store already exists / renew)
      if (Get.currentRoute != AppRoutes.sellerHomeScreen) {
        Get.offAllNamed(AppRoutes.sellerHomeScreen);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isPurchasing.value = false;
    }
  }
}
