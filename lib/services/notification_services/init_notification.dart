import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> setupFCM() async {
  // Request notification permissions
  final messaging = FirebaseMessaging.instance;
  
  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  // Get token
  String? token = await messaging.getToken();
  print("FCM Token: $token");
  
  // Handle token refresh
  messaging.onTokenRefresh.listen((newToken) {
    print("New FCM Token: $newToken");
    // Send this new token to your server
  });

  // Set up foreground message handler
  FirebaseMessaging.onMessage.listen(handleForegroundMessage);

  // Set up background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Handle notification when app is in terminated state
  RemoteMessage? initialMessage = await messaging.getInitialMessage();
  if (initialMessage != null) {
    handleNotificationClick(initialMessage);
  }

  // Handle notification when app is in background
  FirebaseMessaging.onMessageOpenedApp.listen(handleNotificationClick);
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
  
  // You can show a notification here
  showNotification(message);
}

void handleForegroundMessage(RemoteMessage message) {
  print("Handling a foreground message: ${message.messageId}");
  
  // Show notification when app is in foreground
  if (message.notification != null) {
    showNotification(message);
  }
}

void handleNotificationClick(RemoteMessage message) {
  print("Notification clicked: ${message.messageId}");
  
  // Navigate to specific screen based on message data
  // Example:
  if (message.data['type'] == 'chat') {
    // Navigate to chat screen
  }
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> setupNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  
  final DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings(
    requestSoundPermission: false,
    requestBadgePermission: false,
    requestAlertPermission: false,
  );
  
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
  
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      // Handle notification click
    },
  );
}

Future<void> showNotification(RemoteMessage message) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'your_channel_id',
    'Your Channel Name',
    channelDescription: 'Your Channel Description',
    importance: Importance.max,
    priority: Priority.high,
    showWhen: false,
  );
  
  const DarwinNotificationDetails iOSPlatformChannelSpecifics =
      DarwinNotificationDetails();
  
  const NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iOSPlatformChannelSpecifics,
  );
  
  await flutterLocalNotificationsPlugin.show(
    0,
    message.notification?.title,
    message.notification?.body,
    platformChannelSpecifics,
    payload: jsonEncode(message.data),
  );
}



