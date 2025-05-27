import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ring_link/routes/routes.dart';
import 'package:ring_link/services/storage.dart';
import 'package:ring_link/utils/num_txt.dart';
import 'package:ring_link/widgets/components.dart';

import '../../../utils/library.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
        onboardingBg,
      ))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Spacer(),
            appLogo(width: 100, height: 100),
            (context.screenHeight * 0.02).heightBox,
            Text(
              "Train Hard. Fight Smart. Rise To The Top.",
              style: context.headlineLarge,
              textAlign: textAlignCenter,
            ),
            (context.screenHeight * 0.03).heightBox,
            SizedBox(
              width: context.screenWidth * 0.9,
              child: Text(
                "Find trainers, book your sessions, and take your skills to the next level",
                textAlign: textAlignCenter,
              ),
            ),
            (context.screenHeight * 0.03).heightBox,
            SizedBox(
              width: context.screenWidth * 0.9,
              height: context.screenHeight * 0.06,
              child: RoundButton(
                text: "Get Started",
                onPressed: () async {
                  await storage.setValues(
                      StorageKeys.onboardingCompleted, true.toString());
                  context.goNamed(AppRouteNames.login);
                },
                fontsize: 16,
                backgroundColor: AppColors.buttonColor,
              ),
            ),
            (context.screenHeight * 0.05).heightBox,
          ],
        ),
      ),
    );
  }
}
