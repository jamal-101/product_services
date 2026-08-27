import 'package:get/get.dart';
import '../../../../../../../services/api/api_service.dart';
import '../../../../../../../utils/constants/api_enpoint.dart';
import '../model/subscription_history_model.dart';

class SubscriptionHistoryController extends GetxController {
  var isLoading = false.obs;
  var historyList = <Data>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchSubscriptionHistory();
  }

  void fetchSubscriptionHistory() async {
    try {
      isLoading.value = true;
      final response = await ApiService.get(
        "${ApiEndPoint.baseUrl}/subscriptions/my-subscriptions",
      );

      if (response.isSuccess) {
        final responseData = response.data;
        SubscriptionHistory model = SubscriptionHistory.fromJson(
          Map<String, dynamic>.from(responseData),
        );

        if (model.data != null) {
          historyList.assignAll(model.data!);
        }
            } else {
        Get.snackbar("Error", response.message );
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}