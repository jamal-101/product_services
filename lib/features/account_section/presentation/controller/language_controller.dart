import 'dart:ui';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../../services/storage/storage_key.dart';
import '../../../../services/storage/storage_service.dart';

class LanguageController extends GetxController {
  RxString currentLang = 'Spanish'.obs;

  @override
  void onInit() {
    super.onInit();
    loadSavedLanguage();
  }

  void loadSavedLanguage() {
    String? lang = LocalStorage.preferences?.getString(LocalStorageKeys.languageCode);
    if (lang == 'en') {
      currentLang.value = 'English';
    } else {
      currentLang.value = 'Spanish';
    }
  }

  void changeLanguage(String langCode, String langName) async {
    currentLang.value = langName;
    String countryCode = (langCode == 'es') ? 'ES' : 'US';
    Locale newLocale = Locale(langCode, countryCode);
    Get.updateLocale(newLocale);
    await LocalStorage.preferences?.setString(LocalStorageKeys.languageCode, langCode);
    await LocalStorage.preferences?.setString(LocalStorageKeys.countryCode, countryCode);

    Get.forceAppUpdate();
  }
}