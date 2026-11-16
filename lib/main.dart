// import 'package:flutter/cupertino.dart';
// import 'package:product_service/services/socket_service.dart';
// import 'package:product_service/services/storage/storage_service.dart';
// import 'package:product_service/utils/constants/api_enpoint.dart';
// import 'app.dart';
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await LocalStorage.getAllPrefData();
//   if (LocalStorage.token.isNotEmpty) {
//     SocketService.instance.initAndConnect(
//       url: ApiEndPoint.imageUrl,
//       token: LocalStorage.token,
//     );
//   }
//   runApp(const MyApp());
// }


import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:product_service/services/socket_service.dart';
import 'package:product_service/services/storage/storage_service.dart';
import 'package:product_service/utils/constants/api_enpoint.dart';
import 'app.dart';
import 'features/notification/presentaiton/controller/notification_service.dart';

// ✅ অ্যাপ বন্ধ বা ব্যাকগ্রাউন্ডে থাকলে নোটিফিকেশন হ্যান্ডেল করার জন্য
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint("Background Message: ${message.notification?.title}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Firebase ও নোটিফিকেশন সার্ভিস ইনিশিয়ালাইজ করুন
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await NotificationService.initialize();

  await LocalStorage.getAllPrefData();
  if (LocalStorage.token.isNotEmpty) {
    SocketService.instance.initAndConnect(
      url: ApiEndPoint.imageUrl,
      token: LocalStorage.token,
    );
  }
  runApp(const MyApp());
}