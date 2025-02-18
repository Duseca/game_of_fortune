// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    await requestNotificationPermission();
    //initializing settings for android
    InitializationSettings initializationSettings = InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"),
        iOS: DarwinInitializationSettings());

    //we are getting details variable from the payload parameter of the notificationsPlugin.show() method
    await localNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  requestNotificationPermission() async {
    // ignore: unused_local_variable
    NotificationSettings settings = await FirebaseMessaging.instance
        .requestPermission(
            alert: true,
            announcement: true,
            badge: true,
            carPlay: true,
            criticalAlert: true,
            provisional: true,
            sound: true);
  }

  Future<void> showNotification(RemoteMessage message) async {
    try {
      //getting a unique id
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      //creating notification details channel
      final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails("alert", "alert",
              importance: Importance.max, priority: Priority.max),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentBanner: true,
          ));
      await localNotificationsPlugin.show(
        id,
        message.notification?.title ?? '',
        message.notification?.body ?? '',
        notificationDetails,
        payload: jsonEncode(message.data),
      );
    } on Exception catch (e) {
      print(
          "This exception occured while getting notification: $e Push Notification Exception");
    }
  }

  initLocalNotifications() async {
    FirebaseMessaging.instance.getInitialMessage().then((message) async {});

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) async {});
  }

  Future<void> subscribeTopic() async {
    await FirebaseMessaging.instance.subscribeToTopic('all').then((value) {
      if (kDebugMode) {
        print('Subscribed to topic: all');
      }
    }).catchError((e) {
      if (kDebugMode) {
        print('Failed to subscribe to topic: $e');
      }
    });
  }
}
