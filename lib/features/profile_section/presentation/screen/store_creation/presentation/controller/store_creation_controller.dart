import 'package:get/get.dart';

class StoreCreationController extends GetxController {
  var currentStep = 1.obs;

  var isWhatsAppSameAsPhone = false.obs;

  void toggleWhatsApp(bool value) {
    isWhatsAppSameAsPhone.value = value;
  }

  void nextStep() {
    if (currentStep < 5) currentStep++;
  }
  var selectedPlan = "Growth".obs; // Starter or Growth
  var selectedPayment = "Card".obs; // Card, Debit, Bank

  void selectPlan(String plan) => selectedPlan.value = plan;
  void selectPayment(String payment) => selectedPayment.value = payment;
}