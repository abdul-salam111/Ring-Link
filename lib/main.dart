import 'package:flutter/material.dart';
import 'package:ring_link/config/theme/theme.dart';
import 'package:ring_link/routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.darkTheme,
      title: 'Ring Link',
      routerConfig: appRouter,
    );
  }
}
