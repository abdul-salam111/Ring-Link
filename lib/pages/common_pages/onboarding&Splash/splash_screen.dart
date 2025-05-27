import 'package:flutter/material.dart';

import 'package:ring_link/services/splash_services.dart';

import 'package:ring_link/utils/library.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      splashServices.isLoggedIn(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Center(
          child: Image.asset(
            applogo,
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }
}
