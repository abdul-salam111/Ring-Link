import 'package:flutter/material.dart';

import 'package:iconsax/iconsax.dart';
import 'package:ring_link/pages/artist_pages/artist_profile/artist_profile_menu_screen.dart';

import 'package:ring_link/services/services_manager.dart';
import 'package:ring_link/utils/alignments.dart';
import 'package:ring_link/utils/context_ext.dart';
import 'package:ring_link/utils/num_txt.dart';
import 'package:ring_link/utils/paddings.dart';
import 'package:ring_link/widgets/profile_headere_section.dart';

import '../../../widgets/outlineWidgets.dart';

class TrainerProfile extends StatefulWidget {
  const TrainerProfile({super.key});

  @override
  State<TrainerProfile> createState() => _ArtistProfileState();
}

class _ArtistProfileState extends State<TrainerProfile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: ArtistMenuDrawer(),
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: crossAxisStart,
          children: [
            TrainerProfileHeaderCard(
              onMoreBtnPress: () => _scaffoldKey.currentState!.openEndDrawer(),
              isProfileScreen: true,
              isShowFeedbackButtton: false,
              onmoreIcon: Iconsax.menu_1,
              isShowShareButtton: false,
              onShare: () {},
              onFeedback: () {},
              screenTitle: "My Profile",
              mainButtonText: "Edit Profile",
              profilePic: SessionController()
                      .getTrainerDetailsModel
                      .trainerProfilePicture ??
                  "",
              name:
                  SessionController().getTrainerDetailsModel.trainerUsername ??
                      "",
              subtitle:
                  SessionController().getTrainerDetailsModel.trainerTagline ??
                      "",
              onpress: () {},
              rating: double.parse(
                  SessionController().getTrainerDetailsModel.trainerRating ??
                      "0.0"),
              location: "",
              experience: SessionController()
                      .getTrainerDetailsModel
                      .trainerExpereince ??
                  "",
            ),
            20.heightBox,
            Padding(
              padding: screenPadding,
              child: Column(
                crossAxisAlignment: crossAxisStart,
                children: [
                  Text(
                    "Short Bio",
                    style: context.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  10.heightBox,
                  Text(
                    SessionController().getTrainerDetailsModel.trainerBio ?? "",
                    style: context.bodyMedium,
                    textAlign: textAlignJustify,
                  ),
                  20.heightBox,
                  Text(
                    "Preferred Training Type",
                    style: context.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  10.heightBox,
                  SessionController()
                              .getTrainerDetailsModel
                              .trainerSessionType !=
                          null
                      ? Wrap(
                          spacing: 5,
                          runSpacing: 5,
                          children: List.generate(
                              SessionController()
                                      .getTrainerDetailsModel
                                      .trainerSessionType
                                      ?.length ??
                                  0, (index) {
                            return OutlinedButtonWidget(
                                title: SessionController()
                                        .getTrainerDetailsModel
                                        .trainerSessionType?[index] ??
                                    "");
                          }),
                        )
                      : Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              "No Session Type Selected",
                              style: context.bodySmall,
                            ),
                          ),
                        ),
                  20.heightBox,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
