import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:ring_link/utils/library.dart';

import '../../utils/custom_snakbar.dart';

class NotificationsServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  void notificationPermissionRequest() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
    } else {
      CustomSnackbar.show(
        Get.context!,
        title: 'Notification Permission Denied',
        message: 'Please, allow notifications to recieve updates!',
        textColor: AppColors.scaffoldBackgroundColorDark,
        backgroundColor: Colors.white,
        
      );
    }
  }
}
