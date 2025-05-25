import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ring_link/blocs/trainer_blocs/artist_profile_for_trainer/bloc/artist_profile_trainer_bloc.dart';
import 'package:ring_link/utils/library.dart';
import 'package:ring_link/utils/num_txt.dart';
import '../../../widgets/components.dart';
import '../../../widgets/outlineWidgets.dart';

class ArtistProfileForTrainer extends StatefulWidget {
  const ArtistProfileForTrainer({super.key});

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
                profilePic:
                    "https://img.freepik.com/premium-photo/young-man-isolated-blue_1368-124991.jpg?semt=ais_hybrid&w=740",
                name: "Stephanie Nicol",
                subtitle: "Jiu-Jitsu",
                rating: 5.0,
                location: "Brazilian",
                experience: "10+ years",
                screenTitle: "Stephanie",
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
                                    "Meet Stephanie Nico With over 6 years of experience in [MMA specialization], [Trainer Name] has trained fighters from beginners to pros, helping them sharpen their skills and build confidence inside the cage.",
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
                                    "Improving my wrestling for upcoming amateur fights",
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
                                  Wrap(
                                    spacing: 5,
                                    runSpacing: 5,
                                    children: [
                                      OutlinedButtonWidget(
                                          title: "Individual Session"),
                                      OutlinedButtonWidget(
                                          title: "Group Training"),
                                      OutlinedButtonWidget(
                                          title: "Virtual Training"),
                                    ],
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
                                  ListView.builder(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: 5,
                                      itemBuilder: (index, cont) {
                                        return Container(
                                          padding: defaultPadding,
                                          margin: defaultPadding,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: AppColors.lightGrey)),
                                          child: Row(
                                            children: [
                                              Container(
                                                padding: defaultPadding,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
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
                                                  Text(
                                                    "Striking Drills with Coach Mike",
                                                    style: context.bodyMedium!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                  ),
                                                  Text(
                                                    "(One to One)",
                                                    style: context.bodyMedium!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                  Text(
                                                    "10 Mar, 2025",
                                                    style: context.bodyMedium!
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
