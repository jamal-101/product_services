import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../services/storage/storage_service.dart';
import '../../../../services/storage/storage_key.dart';

class LanguageController extends GetxController {
  RxString currentLang = 'English'.obs;

  @override
  void onInit() {
    super.onInit();
    // Load saved language
    String? lang = LocalStorage.preferences?.getString(LocalStorageKeys.languageCode);
    currentLang.value = (lang == 'es') ? 'Spanish' : 'English';
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