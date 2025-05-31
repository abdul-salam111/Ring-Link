import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ring_link/blocs/trainer_blocs/artist_profile_for_trainer/bloc/artist_profile_trainer_bloc.dart';
import 'package:ring_link/models/artists/get_models/get_artist_details.dart';
import 'package:ring_link/utils/date_ext.dart';
import 'package:ring_link/utils/library.dart';
import 'package:ring_link/utils/num_txt.dart';
import '../../../widgets/components.dart';
import '../../../widgets/outlineWidgets.dart';

class ArtistProfileForTrainer extends StatefulWidget {
  final GetArtistDetails getArtistDetails;
  const ArtistProfileForTrainer({super.key, required this.getArtistDetails});

  @override
  State<ArtistProfileForTrainer> createState() =>
      _ArtistProfileForTrainerState();
}

class _ArtistProfileForTrainerState extends State<ArtistProfileForTrainer> {
  late ArtistProfileTrainerBloc artistProfileTrainerBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    artistProfileTrainerBloc = ArtistProfileTrainerBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => artistProfileTrainerBloc,
        child: SingleChildScrollView(
          child: Column(
            children: [
              10.heightBox,
              TrainerProfileHeaderCard(
                mainButtonText: "Send Training Offer",
                onpress: () {},
                isTrainerProfile: false,
                profilePic: widget.getArtistDetails.artistProfileImage ?? "",
                name: widget.getArtistDetails.artistName ?? "",
                subtitle: widget.getArtistDetails.artistTagline ?? "",
                rating: 5.0,
                location: "Brazilian",
                experience: widget.getArtistDetails.artistLevel ??
                    "", //in artist case this represents level of artist
                screenTitle: widget.getArtistDetails.artistName ?? "",
                onShare: () {},
                onFeedback: () {},
              ),
              20.heightBox,
              Padding(
                padding: screenPadding,
                child: Column(
                  crossAxisAlignment: crossAxisStart,
                  children: [
                    BlocBuilder<ArtistProfileTrainerBloc,
                        ArtistProfileTrainerState>(
                      buildWhen: (previous, current) =>
                          previous.currentTabIndex != current.currentTabIndex,
                      builder: (context, state) {
                        return CustomTabBar(
                          tabs: const ["About", "Training History"],
                          selectedIndex: state.currentTabIndex,
                          onTabSelected: (index) {
                            context.read<ArtistProfileTrainerBloc>().add(
                                  ArtistProfileTabChanged(
                                      currentTabIndex: index),
                                );
                          },
                        );
                      },
                    ),
                    20.heightBox,
                    BlocBuilder<ArtistProfileTrainerBloc,
                        ArtistProfileTrainerState>(
                      builder: (context, state) {
                        return state.currentTabIndex == 0
                            ? Column(
                                crossAxisAlignment: crossAxisStart,
                                children: [
                                  Text(
                                    "Short Bio",
                                    style: context.bodyLarge!.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  10.heightBox,
                                  Text(
                                    widget.getArtistDetails.artistBio ?? "",
                                    style: context.bodyMedium,
                                    textAlign: textAlignJustify,
                                  ),
                                  20.heightBox,
                                  Text(
                                    "Training Goals",
                                    style: context.bodyLarge!.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  10.heightBox,
                                  Text(
                                    widget.getArtistDetails
                                            .artistTrainingGoal ??
                                        "",
                                    style: context.bodyMedium,
                                    textAlign: textAlignJustify,
                                  ),
                                  20.heightBox,
                                  Text(
                                    "Preferred Training Type",
                                    style: context.bodyLarge!.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  5.heightBox,
                                  widget.getArtistDetails
                                              .artistPreferredTrainingStyle !=
                                          null
                                      ? Wrap(
                                          spacing: 5,
                                          runSpacing: 5,
                                          children: List.generate(
                                              widget
                                                  .getArtistDetails
                                                  .artistPreferredTrainingStyle!
                                                  .length, (index) {
                                            return OutlinedButtonWidget(
                                                title: widget.getArtistDetails
                                                        .artistPreferredTrainingStyle![
                                                    index]);
                                          }),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Text(
                                              "Not selected yet!",
                                              style: context.bodyMedium!
                                                  .copyWith(
                                                      color: Colors.white),
                                            ),
                                          ),
                                        ),
                                ],
                              )
                            : SizedBox.shrink();
                      },
                    ),
                    BlocBuilder<ArtistProfileTrainerBloc,
                        ArtistProfileTrainerState>(
                      builder: (context, state) {
                        return state.currentTabIndex == 1
                            ? Column(
                                children: [
                                  RecommendedHeader(
                                    title: "Training History",
                                    onSeeAllTap: () {},
                                  ),
                                  widget.getArtistDetails.trainingHistory !=
                                          null
                                      ? ListView.builder(
                                          shrinkWrap: true,
                                          padding: EdgeInsets.zero,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: widget.getArtistDetails
                                              .trainingHistory!.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              padding: defaultPadding,
                                              margin: defaultPadding,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color:
                                                          AppColors.lightGrey)),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    padding: defaultPadding,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                            color: AppColors
                                                                .lightGrey)),
                                                    child: CachedNetworkImage(
                                                        width: 50,
                                                        height: 50,
                                                        imageUrl:
                                                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8locnHjRQZMRz5NOvSxo0v9CnTWvMIJKfyw&s"),
                                                  ),
                                                  10.widthBox,
                                                  Column(
                                                    crossAxisAlignment:
                                                        crossAxisStart,
                                                    children: [
                                                      SizedBox(
                                                        width: context
                                                                    .screenWidth >
                                                                420
                                                            ? context
                                                                    .screenWidth *
                                                                0.8
                                                            : context
                                                                    .screenWidth *
                                                                0.6,
                                                        child: Text(
                                                          widget
                                                                  .getArtistDetails
                                                                  .trainingHistory![
                                                                      index]
                                                                  .trainingTitle ??
                                                              "",
                                                          style: context
                                                              .bodySmall!
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                        ),
                                                      ),
                                                      Text(
                                                        widget
                                                                .getArtistDetails
                                                                .trainingHistory![
                                                                    index]
                                                                .trainingType ??
                                                            "",
                                                        style: context
                                                            .bodyMedium!
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                      Text(
                                                        widget
                                                            .getArtistDetails
                                                            .trainingHistory![
                                                                index]
                                                            .trainingDate!
                                                            .toSimpleDate(),
                                                        style: context
                                                            .bodyMedium!
                                                            .copyWith(
                                                                color: AppColors
                                                                    .lightGrey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            );
                                          })
                                      : Center(
                                          child: Column(
                                            children: [
                                              (context.screenHeight * 0.2)
                                                  .heightBox,
                                              Text(
                                                "No training history available",
                                                style: context.bodyMedium!
                                                    .copyWith(
                                                        color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        )
                                ],
                              )
                            : SizedBox.shrink();
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
