import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import 'local_notification.dart';

class FirebaseCustomNotification {
  static final messaging = FirebaseMessaging.instance;

  static NotificationSettings? settings;

  static Future<void> firebaseMessagingAppOpen() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      if (kDebugMode) {
        print('Notification data: ${message.data}');
      }
    });
  }

  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {}

  static Future<bool> requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission();
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  static Future<void> setUpFirebase() async {
    bool notificationStatus = await requestNotificationPermission();
    if (notificationStatus) {
      await CustomLocalNotification.setupLocalNotifications();
      FirebaseMessaging.onBackgroundMessage(
          FirebaseCustomNotification.firebaseMessagingBackgroundHandler);
      FirebaseMessaging.onMessage
          .listen(CustomLocalNotification.showFlutterNotification);
      FirebaseMessaging.onMessageOpenedApp
          .listen((CustomLocalNotification.onMessageOpenedApp));
      if ( Platform.isAndroid) {
        if (kDebugMode) {
          print(
          'FIREBASE TOKEN: ${await FirebaseMessaging.instance.getToken()}');
        }
      }
    }
  }
}
