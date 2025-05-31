import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ring_link/models/artists/get_models/get_artist_details.dart';
import 'package:ring_link/models/trainers/get_models/get_trainer_details_model.dart';
import 'package:ring_link/pages/artist_pages/artist_details_screen/artist_details_screen.dart';
import 'package:ring_link/pages/artist_pages/artist_home_screen/artist_home_screen.dart';
import 'package:ring_link/pages/artist_pages/trainer_profile_screen_for_artist/trainer_profile_screen.dart';
import 'package:ring_link/pages/common_pages/choose_role_screen/choose_role_screen.dart';
import 'package:ring_link/pages/common_pages/email_vefication_screen/email_verification_screen.dart';
import 'package:ring_link/pages/common_pages/inbox_screen/inbox_screen.dart';
import 'package:ring_link/pages/common_pages/navbar/navbar.dart';
import 'package:ring_link/pages/common_pages/onboarding&Splash/onboarding_screen.dart';
import 'package:ring_link/pages/common_pages/onboarding&Splash/splash_screen.dart';
import 'package:ring_link/pages/common_pages/registration_screen/registration_screen.dart';
import 'package:ring_link/pages/trainer_pages/artist_profile_for_trainer/artist_profile_for_trainer.dart';
import 'package:ring_link/pages/trainer_pages/trainer_details_screen/trainer_details_screen.dart';
import 'package:ring_link/pages/trainer_pages/trainer_home_screen/trainer_home_screen.dart';
import 'package:ring_link/routes/app_route_names.dart';
import 'package:ring_link/routes/app_route_paths.dart';

import '../pages/common_pages/login_screen/login_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutePaths.splash,
  routes: [
    GoRoute(
      path: AppRoutePaths.onBoarding,
      name: AppRouteNames.onBoarding,
      builder: (context, state) => OnboardingScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.splash,
      name: AppRouteNames.splash,
      builder: (context, state) => SplashScreen(),
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
      builder: (context, state) {
        final bool isArtist = state.extra as bool;
        return NavBar(isArtist: isArtist);
      },
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
      builder: (context, state) {
        final GetTrainerDetailsModel getTrainerDetailsModel =
            state.extra as GetTrainerDetailsModel;
        return ArtistDetailsScreen(
            getTrainerDetailsModel: getTrainerDetailsModel);
      },
    ),
    GoRoute(
      path: AppRoutePaths.trainerProfileScreenForArtist,
      name: AppRouteNames.trainerProfileScreenForArtist,
      builder: (context, state) {
        final GetTrainerDetailsModel getTrainerDetailsModel =
            state.extra as GetTrainerDetailsModel;
        return TrainerProfileScreenForArtist(
            getTrainerDetailsModel: getTrainerDetailsModel);
      },
    ),
    GoRoute(
      path: AppRoutePaths.trainerDetails,
      name: AppRouteNames.trainerDetails,
      builder: (context, state) {
        final GetArtistDetails getArtistDetails =
            state.extra as GetArtistDetails;
        return TrainerDetailsScreen(getArtistDetails: getArtistDetails);
      },
    ),
    GoRoute(
      path: AppRoutePaths.inboxScreen,
      name: AppRouteNames.inboxScreen,
      builder: (context, state) => InboxScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.trainerHomeScreen,
      name: AppRouteNames.trainerHomeScreen,
      builder: (context, state) => TrainerHomeScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.artistProfileForTrainer,
      name: AppRouteNames.artistProfileForTrainer,
      builder: (context, state) {
        final GetArtistDetails getArtistDetails =
            state.extra as GetArtistDetails;
        return ArtistProfileForTrainer(getArtistDetails: getArtistDetails);
      },
    ),
  ],
);
