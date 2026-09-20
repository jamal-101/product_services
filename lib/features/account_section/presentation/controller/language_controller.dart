// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../services/storage/storage_service.dart';
// import '../../../../services/storage/storage_key.dart';
//
// class LanguageController extends GetxController {
//   RxString currentLang = 'English'.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     // Load saved language
//     String? lang = LocalStorage.preferences?.getString(LocalStorageKeys.languageCode);
//     currentLang.value = (lang == 'es') ? 'Spanish' : 'English';
//   }
//
//   void changeLanguage(String langCode, String langName) async {
//     currentLang.value = langName;
//     String countryCode = (langCode == 'es') ? 'ES' : 'US';
//
//     Locale newLocale = Locale(langCode, countryCode);
//     Get.updateLocale(newLocale);
//
//     // Save to local storage
//     await LocalStorage.preferences?.setString(LocalStorageKeys.languageCode, langCode);
//     await LocalStorage.preferences?.setString(LocalStorageKeys.countryCode, countryCode);
//
//     Get.forceAppUpdate();
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../services/storage/storage_service.dart';
import '../../../../services/storage/storage_key.dart';

class LanguageController extends GetxController {
  RxString currentLang = 'English'.obs;

  @override
  void onInit() {
    super.onInit();
    // অ্যাপ চালু বা রিফ্রেশ হওয়ার সময় সেভ করা ভাষা লোড করা
    loadSavedLanguage();
  }

  // আলাদা একটি মেথড বানিয়ে নেওয়া ভালো যাতে যেকোনো সময় ভাষা রিফ্রেশ করা যায়
  void loadSavedLanguage() {
    String? lang = LocalStorage.preferences?.getString(LocalStorageKeys.languageCode);
    if (lang == 'es') {
      currentLang.value = 'Spanish';
    } else {
      currentLang.value = 'English'; // ডিফল্ট বা লগআউট করলে এটি কাজ করবে
    }
  }

  void changeLanguage(String langCode, String langName) async {
    currentLang.value = langName;
    String countryCode = (langCode == 'es') ? 'ES' : 'US';

    Locale newLocale = Locale(langCode, countryCode);
    Get.updateLocale(newLocale);

    // Save to local storage
    await LocalStorage.preferences?.setString(LocalStorageKeys.languageCode, langCode);
    await LocalStorage.preferences?.setString(LocalStorageKeys.countryCode, countryCode);

    Get.forceAppUpdate();
  }
}