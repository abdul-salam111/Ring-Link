import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ring_link/pages/artist_pages/artist_details_screen/artist_details_screen.dart';
import 'package:ring_link/pages/artist_pages/artist_home_screen/artist_home_screen.dart';
import 'package:ring_link/pages/artist_pages/artist_manu_screen/artist_manu_screen.dart';
import 'package:ring_link/pages/artist_pages/artist_profile_screen/artist_profile_screen.dart';
import 'package:ring_link/pages/artist_pages/trainer_profile_screen_for_artist/trainer_profile_screen.dart';
import 'package:ring_link/pages/common_pages/choose_role_screen/choose_role_screen.dart';
import 'package:ring_link/pages/common_pages/email_vefication_screen/email_verification_screen.dart';
import 'package:ring_link/pages/common_pages/inbox_screen/inbox_screen.dart';
import 'package:ring_link/pages/common_pages/navbar/navbar.dart';
import 'package:ring_link/pages/common_pages/notification_screen/notification_screen.dart';
import 'package:ring_link/pages/common_pages/onboarding&Splash/onboarding_screen.dart';
import 'package:ring_link/pages/common_pages/registration_screen/registration_screen.dart';
import 'package:ring_link/pages/common_pages/single_chat_screen/single_chat_screen.dart';
import 'package:ring_link/routes/app_route_names.dart';
import 'package:ring_link/routes/app_route_paths.dart';

import '../pages/common_pages/login_screen/login_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutePaths.notificationScreen,
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
    GoRoute(
      path: AppRoutePaths.registeration,
      name: AppRouteNames.registeration,
      builder: (context, state) => RegistrationScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.emailverification,
      name: AppRouteNames.emailverification,
      builder: (context, state) => EmailVerificationScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.chooserole,
      name: AppRouteNames.chooserole,
      builder: (context, state) => ChooseRoleScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.artistHomeScreen,
      name: AppRouteNames.artistHomeScreen,
      builder: (context, state) => ArtistHomeScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.navbar,
      name: AppRouteNames.navbar,
      builder: (context, state) => NavBar(),
    ),
    GoRoute(
      path: AppRoutePaths.trainerFilter,
      name: AppRouteNames.trainerFilter,
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const TrainerFilter(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
            )),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    ),
    GoRoute(
      path: AppRoutePaths.artistDetails,
      name: AppRouteNames.artistDetails,
      builder: (context, state) => ArtistDetailsScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.trainerProfileScreenForArtist,
      name: AppRouteNames.trainerProfileScreenForArtist,
      builder: (context, state) => TrainerProfileScreenForArtist(),
    ),
    GoRoute(
      path: AppRoutePaths.inboxScreen,
      name: AppRouteNames.inboxScreen,
      builder: (context, state) => InboxScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.singleChatScreen,
      name: AppRouteNames.singleChatScreen,
      builder: (context, state) => SingleChatScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.notificationScreen,
      name: AppRouteNames.notificationScreen,
      builder: (context, state) => NotificationScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.artistProfileScreen,
      name: AppRouteNames.artistProfileScreen,
      builder: (context, state) => ArtistProfileScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.artistManuScreen,
      name: AppRouteNames.artistManuScreen,
      builder: (context, state) => ArtistManuScreen(),
    ),
  ],
);
