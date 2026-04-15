import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mobile_app/core/classes/my_logger.dart';
import 'package:mobile_app/core/constants/app_strings.dart';
import 'package:mobile_app/core/storage/pref_services.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationsServices {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// ================= PERMISSION =================

  Future<void> requestNotificationPermission() async {
    try {
      final status = await Permission.notification.status;

      if (status.isDenied) {
        final result = await Permission.notification.request();
        MyLogger.instance.printLog("Permission result :: $result");
      }

      if (status.isPermanentlyDenied) {
        MyLogger.instance.printLog("Permission permanently denied");
        openAppSettings();
      }
    } catch (e) {
      MyLogger.instance.printLog("Permission ERROR :: $e");
    }
  }

  /// ================= INIT FCM =================

  Future<void> initFcm() async {
    try {
      await requestNotificationPermission();

      /// iOS permission
      if (Platform.isIOS) {
        await messaging.requestPermission(
          alert: true,
          badge: true,
          sound: true,
        );
      }

      /// ⏳ مهم عشان نتجنب SERVICE_NOT_AVAILABLE
      await Future.delayed(const Duration(milliseconds: 500));

      /// 🎯 get token with retry
      final token = await _getTokenWithRetry();

      if (token != null && token.isNotEmpty) {
        await PrefServices.instance.saveData(
          key: AppStrings.fcm,
          value: token,
        );
        MyLogger.instance.printLog("FCM Token :: $token");
      } else {
        MyLogger.instance.printLog("FCM Token is NULL");
      }

      /// 🔄 Token refresh
      FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
        MyLogger.instance.printLog("NEW TOKEN :: $newToken");

        await PrefServices.instance.saveData(
          key: AppStrings.fcm,
          value: newToken,
        );
      });

      /// 📲 لما المستخدم يفتح الاشعار
      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        MyLogger.instance.printLog(
          "onMessageOpenedApp ${message.notification?.title}",
        );
        MyLogger.instance.printLog(
          "onMessageOpenedApp ${message.notification?.body}",
        );
      });

      /// 📩 Foreground messages
      FirebaseMessaging.onMessage.listen((message) {
        MyLogger.instance.printLog(
          "onMessage ${message.notification?.title}",
        );
        MyLogger.instance.printLog(
          "onMessage ${message.notification?.body}",
        );

        /// عرض local notification
        if (message.notification != null) {
          showLocalNotification(
            id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
            title: message.notification?.title ?? "",
            body: message.notification?.body ?? "",
          );
        }
      });
    } catch (e, stack) {
      MyLogger.instance.printLog("initFcm ERROR :: $e");
      MyLogger.instance.printLog("STACK :: $stack");
    }
  }

  /// ================= RETRY TOKEN =================

  Future<String?> _getTokenWithRetry() async {
    const int maxAttempts = 3;

    for (int i = 1; i <= maxAttempts; i++) {
      try {
        final token = await messaging.getToken();

        if (token != null && token.isNotEmpty) {
          return token;
        }
      } catch (e) {
        MyLogger.instance.printLog("Attempt $i failed :: $e");
      }

      await Future.delayed(const Duration(seconds: 2));
    }

    return null;
  }

  /// ================= LOCAL NOTIFICATION INIT =================

  Future<void> initLocalNotification() async {
    try {
      const androidSettings = AndroidInitializationSettings(
        '@mipmap/ic_launcher',
      );

      const DarwinInitializationSettings iosSettings =
          DarwinInitializationSettings();

      const InitializationSettings initializationSettings =
          InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      );

      await notificationsPlugin.initialize(initializationSettings);
    } catch (e) {
      MyLogger.instance.printLog("Local Notification Init ERROR :: $e");
    }
  }

  /// ================= SHOW LOCAL NOTIFICATION =================

  Future<void> showLocalNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    try {
      const androidDetails = AndroidNotificationDetails(
        'default_channel_id',
        'Default Channel',
        channelDescription: 'Default notifications',
        importance: Importance.max,
        priority: Priority.high,
      );

      const iosDetails = DarwinNotificationDetails();

      await notificationsPlugin.show(
        id,
        title,
        body,
        const NotificationDetails(
          android: androidDetails,
          iOS: iosDetails,
        ),
      );
    } catch (e) {
      MyLogger.instance.printLog("Local Notification ERROR :: $e");
    }
  }
}