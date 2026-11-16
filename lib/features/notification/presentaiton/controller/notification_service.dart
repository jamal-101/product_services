import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'notification_controller.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _localNotifications =
  FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
    playSound: true,
  );

  static Future<void> initialize() async {
    // ১. ফায়ারবেস পার্মিশন নেওয়া
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // ২. লোকাল নোটিফিকেশন সেটিংস
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosSettings =
    DarwinInitializationSettings();
    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    // ✅ পুরনো ভার্সনের জন্য সরাসরি পজিশনাল আর্গুমেন্ট
    await _localNotifications.initialize(initSettings);

    await _localNotifications
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // ৩. ফোরগ্রাউন্ডে নোটিফিকেশন আসলে
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        // ✅ পুরনো ভার্সনের জন্য সরাসরি পজিশনাল আর্গুমেন্ট
        _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _channel.id,
              _channel.name,
              channelDescription: _channel.description,
              icon: '@mipmap/ic_launcher',
              importance: Importance.max,
              priority: Priority.high,
            ),
          ),
        );
      }

      // নতুন নোটিফিকেশন আসলে লিস্ট রিফ্রেশ করবে
      _refreshNotificationController();
    });

    // ৪. ব্যাকগ্রাউন্ড থেকে নোটিফিকেশনে ক্লিক করলে
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _refreshNotificationController();
    });
  }

  static void _refreshNotificationController() {
    if (Get.isRegistered<NotificationController>()) {
      Get.find<NotificationController>().fetchNotifications();
    }
  }
}