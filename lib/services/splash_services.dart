// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ring_link/routes/routes.dart';
import 'package:ring_link/services/notification_services/fcm_services.dart';
import 'package:ring_link/services/storage.dart';

import '../routes/app_route_names.dart';
import 'notification_services/notifications_services.dart';
import 'services_manager.dart';

// import 'session_manager.dart';

class SplashServices {
  void isLoggedIn(BuildContext context) {
    checkLoginStatus(context);
  }

  NotificationsServices notificationsServices = NotificationsServices();
  Future<void> checkLoginStatus(BuildContext context) async {
    try {
      await SessionController().getUserfromSharedpref();

      final userTypeString = await storage.readValues(StorageKeys.userType);
      final chooseRoleDone =
          await storage.readValues(StorageKeys.chooseRoleDone);
      final onboardingDone =
          await storage.readValues(StorageKeys.onboardingCompleted);
      notificationsServices.notificationPermissionRequest(context);
      await notificationsServices.getToken();
      // FcmServices.firebaseInit();
      if (SessionController().islogin == true) {
        final isArtist = userTypeString == UserType.artist.name ? true : false;
        context.goNamed(AppRouteNames.navbar, extra: isArtist);
      } else if (onboardingDone != 'true' || onboardingDone == null) {
        context.goNamed(AppRouteNames.onBoarding);
      } else if (chooseRoleDone == null ||
          chooseRoleDone.isEmpty ||
          chooseRoleDone != 'true') {
        context.goNamed(AppRouteNames.chooserole);
      } else {
        context.goNamed(AppRouteNames.login);
      }
    } catch (e) {
      debugPrint('Error in checkLoginStatus: $e');

      context.goNamed(AppRouteNames.login);
    }
  }
}
