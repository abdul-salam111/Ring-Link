import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ring_link/config/theme/theme.dart';
import 'package:ring_link/firebase_options.dart';
import 'package:ring_link/routes/app_routes.dart';

import 'repositories/common_repositories/auth_repository.dart';

final getIt = GetIt.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  serviceslocator();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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

void serviceslocator() {
  // auth repo
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository());
}
