import 'package:flutter/material.dart';
import 'package:ring_link/utils/library.dart';
import 'package:ring_link/utils/num_txt.dart';
import 'package:ring_link/widgets/components.dart';

class ChooseRoleScreen extends StatelessWidget {
  const ChooseRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          40.heightBox,
          CustomAppBar(title: "Choose Your Role "),
          Padding(
            padding: symmetricHorizontal20,
            child: Column(
              crossAxisAlignment: crossAxisStart,
              children: [
                Text(
                  "Choose Your Path",
                  style: context.bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                10.heightBox,
                Text(
                  "Are you a trainer looking to grow your client base or an artist seeking top-tier coaching?",
                  style: context.bodySmall!
                      .copyWith(color: AppColors.textColorSecondary),
                ),
                30.heightBox,
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: padding12,
                        decoration: BoxDecoration(
                            color: Color(0xff1C1F23),
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          crossAxisAlignment: crossAxisStart,
                          children: [
                            Container(
                              padding: padding5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: AppColors.lightGrey)),
                              child: Image.asset(
                                "assets/icons/artist.png",
                                width: 30,
                                height: 30,
                              ),
                            ),
                            10.heightBox,
                            Text(
                              "MMA Artist",
                              style: context.bodyMedium,
                            ),
                            Text(
                              "Find expert trainers, sparring partners, and training spaces",
                              style: context.bodySmall!.copyWith(
                                  fontSize: 12, color: AppColors.lightGrey),
                            ),
                          ],
                        ),
                      ),
                    ),
                    10.widthBox,
                    Expanded(
                      child: Container(
                        padding: padding12,
                        decoration: BoxDecoration(
                            color: Color(0xff1C1F23),
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          crossAxisAlignment: crossAxisStart,
                          children: [
                            Container(
                              padding: padding5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: AppColors.lightGrey)),
                              child: Image.asset(
                                "assets/icons/trainer.png",
                                width: 30,
                                height: 30,
                              ),
                            ),
                            10.heightBox,
                            Text(
                              "MMA Trainer",
                              style: context.bodyMedium,
                            ),
                            5.heightBox,
                            Text(
                              "Build your client base and showcase your expertise",
                              style: context.bodySmall!.copyWith(
                                  fontSize: 12, color: AppColors.lightGrey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Spacer(),
          SizedBox(
            width: context.screenWidth * 0.9,
            height: context.screenHeight * 0.06,
            child: RoundButton(
              text: "Continue",
              onPressed: () {},
              fontsize: 16,
              backgroundColor: AppColors.buttonColor,
            ),
          ),
          20.heightBox,
        ],
      ),
    );
  }
}
