import 'package:translator/translator.dart';
import '../../../../services/storage/storage_key.dart';
import '../../../../services/storage/storage_service.dart';

class AppTranslatorService {
  static final GoogleTranslator _translator = GoogleTranslator();

  /// API থেকে আসা টেক্সট ইউজার অনুযায়ী ট্রান্সলেট করবে এবং LocalStorage-এ সেভ রাখবে
  static Future<String> translateText(String originalText) async {
    if (originalText.trim().isEmpty) return originalText;

    // ১. বর্তমানে সেভ থাকা ভাষা চেক করা (ডিফল্ট 'es')
    String currentLangCode = LocalStorage.preferences?.getString(LocalStorageKeys.languageCode) ?? 'es';

    // ২. Unique Cache Key তৈরি (যেমন: trans_es_Hello_World)
    String cacheKey = "trans_${currentLangCode}_$originalText";

    // ৩. যদি লোকাল স্টোরেজে অলরেডি এই ট্রান্সলেশনটি সেভ থাকে, তবে সেখান থেকেই দিয়ে দিবে
    String? cachedTranslation = LocalStorage.preferences?.getString(cacheKey);
    if (cachedTranslation != null && cachedTranslation.isNotEmpty) {
      return cachedTranslation;
    }
    try {
      Translation translation = await _translator.translate(
        originalText,
        to: currentLangCode,
      );

      String translatedText = translation.text;

      // ৫. সেভ করে রাখা (পরের বার ইন্টারনেট ছাড়াই লোকাল স্টোরেজ থেকে দ্রুত লোড হবে)
      await LocalStorage.preferences?.setString(cacheKey, translatedText);

      return translatedText;
    } catch (e) {
      // কোনো কারণে নেটওয়ার্ক এরর হলে অরিজিনাল টেক্সট ব্যাকআপ হিসেবে রিটার্ন করবে
      return originalText;
    }
  }
}