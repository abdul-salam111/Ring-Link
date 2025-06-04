import 'dart:io';

import 'package:app_settings/app_settings.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:ring_link/routes/routes.dart';
import 'package:ring_link/services/storage.dart';

import 'package:ring_link/utils/flutter_toast.dart';

class NotificationsServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //for notifications permission
  void notificationPermissionRequest(context) async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      CustomToast.show(
        message: "Please, allow notification permissions",
        gravity: ToastGravity.BOTTOM,
      );
      print("full granted");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("provisinoal granted");
    } else {
      print("not allowed");
      CustomToast.show(
        message: "Please, allow notification permissions",
        gravity: ToastGravity.BOTTOM,
      );
      Future.delayed(Duration(seconds: 2), () {
        AppSettings.openAppSettings(type: AppSettingsType.notification);
      });
    }
  }

  Future<String> getToken() async {
    final messaging = FirebaseMessaging.instance;

    String? currentToken = await messaging.getToken();
    if (currentToken == null) throw Exception("FCM token is null");

    print("🎯 Current FCM Token: $currentToken");

    final oldToken = await storage.readValues(StorageKeys.deviceToken);

    if (oldToken != currentToken) {
      print("🔁 Token updated locally");
      await storage.setValues(StorageKeys.deviceToken, currentToken);
    }

    messaging.onTokenRefresh.listen((newToken) async {
      final savedToken = await storage.readValues(StorageKeys.deviceToken);
      if (savedToken != newToken) {
        await storage.setValues(StorageKeys.deviceToken, newToken);
      }
    });

    return currentToken;
  }

  void initLocalNotification(
      BuildContext context, RemoteMessage message) async {
    var androidInitSettings =
        const AndroidInitializationSettings("@mipmap/ic_launcher");
    var iosInitSettings = const DarwinInitializationSettings();
    var initializationSetting = InitializationSettings(
      android: androidInitSettings,
      iOS: iosInitSettings,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSetting,
        onDidReceiveBackgroundNotificationResponse: (payload) {});
  }

//foreground message when app in running mode
  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (Platform.isIOS) {
        iosForgroundMessage();
      }
      if (Platform.isAndroid) {
        initLocalNotification(context, message);
        handleMessage(context, message);
      }
    });
  }

  Future iosForgroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

//background and terminated
  Future<void> setupInteractiveMessage(BuildContext context) async {
    //background state
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handleMessage(context, message);
    });

    //terminated state
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? remoteMessage) {
      if (remoteMessage != null && remoteMessage.data.isNotEmpty) {
        handleMessage(context, remoteMessage);
      }
    });
  }

  //handle message //naviagtion or anything else
  Future<void> handleMessage(
      BuildContext context, RemoteMessage messsage) async {
    context.pushNamed(AppRouteNames.messagesScreen);
  }

  //function to show notifications
  Future<void> showNotifications(RemoteMessage message) async {
    AndroidNotificationChannel androidNotificationChannel =
        AndroidNotificationChannel(
      message.notification!.android!.channelId.toString(),
      message.notification!.android!.channelId.toString(),
      importance: Importance.high,
      showBadge: true,
      playSound: true,
    );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(androidNotificationChannel.id, androidNotificationChannel.name);
  }
}
