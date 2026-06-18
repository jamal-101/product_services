import 'package:get/get.dart';
import 'package:product_service/config/route/app_route.dart';

class MessageController extends GetxController{
  void goToConversation(String shopName) {
    Get.toNamed(AppRoutes.conversationScreen, arguments: shopName);
  }
}