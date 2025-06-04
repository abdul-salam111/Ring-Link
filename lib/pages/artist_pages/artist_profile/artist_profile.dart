import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:iconsax/iconsax.dart';
import 'package:ring_link/pages/artist_pages/artist_profile/artist_profile_menu_screen.dart';
import 'package:ring_link/routes/routes.dart';

import 'package:ring_link/services/services_manager.dart';
import 'package:ring_link/utils/alignments.dart';
import 'package:ring_link/utils/context_ext.dart';
import 'package:ring_link/utils/num_txt.dart';
import 'package:ring_link/utils/paddings.dart';
import 'package:ring_link/widgets/profile_headere_section.dart';

import '../../../utils/images.dart';
import '../../../widgets/outlineWidgets.dart';

class ArtistProfile extends StatefulWidget {
  const ArtistProfile({super.key});

  @override
  State<ArtistProfile> createState() => _ArtistProfileState();
}

class _ArtistProfileState extends State<ArtistProfile> {
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
              profilePic:
                  SessionController().getArtistDetails.artistProfileImage ??
                      defaultImage,
              name: SessionController().getArtistDetails.artistName ?? "",
              subtitle:
                  SessionController().getArtistDetails.artistTagline ?? "",
              onpress: () {
                context.pushNamed(AppRouteNames.editArtistProfile);
              },
              rating: 0.0,
              location:
                  SessionController().getArtistDetails.artistAddress ?? "",
              experience:
                  SessionController().getArtistDetails.artistLevel ?? "",
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
                    SessionController().getArtistDetails.artistBio ?? "",
                    style: context.bodyMedium,
                    textAlign: textAlignJustify,
                  ),
                  20.heightBox,
                  Text(
                    "Training Goal",
                    style: context.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  10.heightBox,
                  Text(
                    SessionController().getArtistDetails.artistTrainingGoal ??
                        "",
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
                              .getArtistDetails
                              .artistPreferredTrainingStyle !=
                          null
                      ? Wrap(
                          spacing: 5,
                          runSpacing: 5,
                          children: List.generate(
                              SessionController()
                                      .getArtistDetails
                                      .artistPreferredTrainingStyle
                                      ?.length ??
                                  0, (index) {
                            return OutlinedButtonWidget(
                                title: SessionController()
                                        .getArtistDetails
                                        .artistPreferredTrainingStyle?[index] ??
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
