import 'package:flutter/material.dart';

import 'package:ring_link/utils/library.dart';
import 'package:ring_link/utils/num_txt.dart';
import 'package:ring_link/widgets/components.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: crossAxisStart,
          children: [
            CustomAppBar(title: "Email Verification"),
            20.heightBox,
            Padding(
              padding: symmetricHorizontal20,
              child: Column(
                crossAxisAlignment: crossAxisStart,
                children: [
                  Text(
                    "Check your email",
                    style: context.bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  10.heightBox,
                  Text(
                    "We just sent a temporary identification code to {email}",
                    style: context.bodySmall!
                        .copyWith(color: AppColors.textColorSecondary),
                  ),
                  30.heightBox,
                  Text(
                    "Enter Identification Code",
                    style: context.bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
