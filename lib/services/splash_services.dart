// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ring_link/routes/routes.dart';
import 'package:ring_link/services/storage.dart';

import '../routes/app_route_names.dart';
import 'services_manager.dart';

// import 'session_manager.dart';

class SplashServices {
  void isLoggedIn(BuildContext context) {
    checkLoginStatus(context);
  }

  Future<void> checkLoginStatus(BuildContext context) async {
    await SessionController().getUserfromSharedpref();
    Timer(Duration(seconds: 2), () async {
      final onboardingDone =
          await storage.readValues(StorageKeys.onboardingCompleted);
      if (SessionController().islogin == true) {
        context.goNamed(AppRouteNames.navbar);
      } else if (onboardingDone != 'true' || onboardingDone == null) {
        context.goNamed(AppRouteNames.onBoarding);
      } else {
        context.goNamed(AppRouteNames.login);
      }
    });
  }
}
