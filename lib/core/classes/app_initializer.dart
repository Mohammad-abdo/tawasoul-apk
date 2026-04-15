import 'package:error_stack/error_stack.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile_app/core/classes/bloc_observer.dart';
import 'package:mobile_app/core/classes/my_logger.dart';
import 'package:mobile_app/core/notifications/notifications_services.dart';
import 'package:mobile_app/core/storage/pref_services.dart';
import 'package:mobile_app/core/storage/secure_storage_service.dart';
import 'package:mobile_app/features/app_injections.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (message.notification != null) {
    if (kDebugMode) {
      print("======================= onBackGround ================");
    }

    MyLogger.instance.printLog("onBackGround ${message.notification?.title}");
    MyLogger.instance.printLog("onBackGround ${message.notification?.body}");
    MyLogger.instance.printLog("onBackGround ${message.data}");

    if (kDebugMode) {
      print("======================= onBackGround ================");
    }
  }
}

class AppInitializer {
  /// Entry point
  static Future<void> init() async {
  

    await _bootstrap();
  }

  /// Main bootstrap flow (ordered safely)
  static Future<void> _bootstrap() async {
    MyLogger.instance.initLogger(); //* to display or hide data in console
    await _initErrorStack(); //* find bugs in development mode
    //await _initFirebase();
    await _initStorage();
    //await _initNotifications();
    _initCore();
  }

  // -------------------- Error Stack --------------------

  static Future<void> _initErrorStack() async {
    try {
      await ErrorStack.init();
    } catch (e) {
      MyLogger.instance.printLog("ErrorStack init error: $e");
    }
  }

  // -------------------- Firebase --------------------

  static Future<void> _initFirebase() async {
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  // -------------------- Storage --------------------

  static Future<void> _initStorage() async {
    // تقدر نشغلهم مع بعض لأنهم مستقلين
    await Future.wait([
      SecureStorageService.instance.init(), //* important data (token)
      PrefServices.instance.init(), //* any simple data not important
      appInjections(),
    ]);

    await Hive.initFlutter(); //* save heavy data

    // افتح البوكسات هنا فقط
    await Hive.openBox("myBox");
  }

  // -------------------- Notifications --------------------

  static Future<void> _initNotifications() async {
    final notification = NotificationsServices();

    await notification.initFcm();
    await notification.initLocalNotification();
  }

  // -------------------- Core --------------------

  static void _initCore() {
    Bloc.observer = MyBlocObserver(); //* observer changes in  my cubits
  }
}

