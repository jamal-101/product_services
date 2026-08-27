import 'package:get/get.dart';

class MyAddController extends GetxController {
  // ট্যাব সিলেকশন (0: All, 1: Pending, 2: Live)
  var selectedTab = 0.obs;

  // এডিট স্ক্রিনের জন্য টেক্সট কন্ট্রোলার বা ভেরিয়েবল
  var campaignNameController = ''.obs;
  var selectedPlan = 'Weekly'.obs;
  var startDate = 'Jul 20, 2026'.obs;

  // ট্যাব পরিবর্তনের ফাংশন
  void changeTab(int index) {
    selectedTab.value = index;
  }
}