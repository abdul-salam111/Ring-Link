import 'package:go_router/go_router.dart';
import 'package:ring_link/pages/onboarding&Splash/onboarding_screen.dart';
import 'package:ring_link/routes/app_route_names.dart';
import 'package:ring_link/routes/app_route_paths.dart';

import '../pages/login_screen/login_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutePaths.login,
  routes: [
    GoRoute(
      path: AppRoutePaths.onBoarding,
      name: AppRouteNames.onBoarding,
      builder: (context, state) => OnboardingScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.login,
      name: AppRouteNames.login,
      builder: (context, state) => LoginScreen(),
    ),
    // GoRoute(
    //   path: AppRoutePaths.register,
    //   name: AppRouteNames.register,
    //   builder: (context, state) => SignUpScreen(),
    // ),
    // GoRoute(
    //   path: AppRoutePaths.navbar,
    //   name: AppRouteNames.navbar,
    //   builder: (context, state) => Navbar(),
    // ),
  ],
);
