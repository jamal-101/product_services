import 'package:product_service/services/storage/storage_key.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../log/app_log.dart';


class LocalStorage {
  static String token = "";
  static String refreshToken = "";
  static bool isLogIn = false;
  static String userId = "";
  static String myImage = "";
  static String myName = "";
  static String myEmail = "";
  static String myRole = "";
  static String profileImage = "";
  static bool hasSellerAccount = false;


  static SharedPreferences? preferences;

  /// Get SharedPreferences Instance
  static Future<SharedPreferences> _getStorage() async {
    preferences ??= await SharedPreferences.getInstance();
    return preferences!;
  }

  static Future<void> getAllPrefData() async {
    final localStorage = await _getStorage();

    token = localStorage.getString(LocalStorageKeys.token) ?? "";
    refreshToken = localStorage.getString(LocalStorageKeys.refreshToken) ?? "";
    isLogIn = localStorage.getBool(LocalStorageKeys.isLogIn) ?? false;
    userId = localStorage.getString(LocalStorageKeys.userId) ?? "";
    myImage = localStorage.getString(LocalStorageKeys.myImage) ?? "";
    myName = localStorage.getString(LocalStorageKeys.myName) ?? "";
    myEmail = localStorage.getString(LocalStorageKeys.myEmail) ?? "";
    myRole = localStorage.getString(LocalStorageKeys.myRole) ?? "";
    profileImage = localStorage.getString(LocalStorageKeys.profileImage) ?? "";
    hasSellerAccount = localStorage.getBool(LocalStorageKeys.hasSellerAccount) ?? false;


    appLog(userId, source: "Local Storage");
  }


  static Future<void> removeAllPrefData() async {
    final localStorage = await _getStorage();
    await localStorage.clear();
    _resetLocalStorageData();
    try {
      // final cartBox = Hive.box<CartItem>(CartItemAdapter.boxName);
      // await cartBox.clear();
    } catch (e) {
      // appLog("Error clearing Hive box: $e", source: "LocalStorage");
    }

    // Get.offAllNamed(AppRoutes.signIn);
    await getAllPrefData();
  }

  static void _resetLocalStorageData() {
    final localStorage = preferences!;
    localStorage.setString(LocalStorageKeys.token, "");
    localStorage.setString(LocalStorageKeys.refreshToken, "");
    localStorage.setString(LocalStorageKeys.userId, "");
    localStorage.setString(LocalStorageKeys.myImage, "");
    localStorage.setString(LocalStorageKeys.myName, "");
    localStorage.setString(LocalStorageKeys.myEmail, "");
    localStorage.setBool(LocalStorageKeys.isLogIn, false);
    localStorage.setString(LocalStorageKeys.myRole, "");
    localStorage.setString(LocalStorageKeys.profileImage, "");
    localStorage.setBool(LocalStorageKeys.hasSellerAccount, false);
    hasSellerAccount = false;
  }

  static Future<void> setUserRole(String role) async {
    myRole = role;
    await setString(LocalStorageKeys.myRole, role);
  }

  static Future<void> setString(String key, String value) async {
    final localStorage = await _getStorage();
    await localStorage.setString(key, value);
  }

  static Future<void> setBool(String key, bool value) async {
    final localStorage = await _getStorage();
    await localStorage.setBool(key, value);
  }

  static Future<void> setInt(String key, int value) async {
    final localStorage = await _getStorage();
    await localStorage.setInt(key, value);
  }
}
