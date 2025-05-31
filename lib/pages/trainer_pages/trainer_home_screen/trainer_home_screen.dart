import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ring_link/blocs/trainer_blocs/trainer_home_screen/bloc/trainer_home_screen_bloc.dart';
import 'package:ring_link/main.dart';
import 'package:ring_link/routes/routes.dart';
import 'package:ring_link/services/services_manager.dart';
import 'package:ring_link/utils/enums.dart';
import 'package:ring_link/utils/num_txt.dart';
import 'package:ring_link/widgets/components.dart';
import '../../../utils/library.dart';

class TrainerHomeScreen extends StatefulWidget {
  const TrainerHomeScreen({super.key});

  @override
  State<TrainerHomeScreen> createState() => _TrainerHomeScreenState();
}

class _TrainerHomeScreenState extends State<TrainerHomeScreen> {
  late TrainerHomeScreenBloc trainerHomeScreenBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    trainerHomeScreenBloc = TrainerHomeScreenBloc(getIt());
    trainerHomeScreenBloc.add(FetchAllArtistEvent());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.focusScope.unfocus();
      },
      child: Scaffold(
        body: BlocProvider(
          create: (context) => trainerHomeScreenBloc,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: screenPadding,
                child: Column(
                  children: [
                    10.heightBox,
                    WelcomeHeader(
                      subtitle: "Ready to level up your training",
                      imageUrl: SessionController()
                              .getTrainerDetailsModel
                              .trainerProfilePicture ??
                          "",
                      onNotificationTap: () {},
                    ),
                    20.heightBox,
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            onChanged: (value) {
                              trainerHomeScreenBloc
                                  .add(SearchArtistEvent(searchQuery: value));
                            },
                            decoration: InputDecoration(
                                prefixIcon: Icon(Iconsax.search_normal_1),
                                fillColor: AppColors.lightgreycardColor,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                        color: AppColors.lightgreycardColor)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                        color: AppColors.lightgreycardColor)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                        color: AppColors.lightgreycardColor)),
                                hintText: "Search Here",
                                hintStyle: context.bodySmall),
                          ),
                        ),
                        10.widthBox,
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: 55,
                            width: 55,
                            padding: defaultPadding,
                            decoration: BoxDecoration(
                                color: AppColors.lightgreycardColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(child: Icon(Iconsax.filter)),
                          ),
                        )
                      ],
                    ),
                    20.heightBox,
                    BlocBuilder<TrainerHomeScreenBloc, TrainerHomeScreenState>(
                      buildWhen: (previous, current) =>
                          previous.currentTabIndex != current.currentTabIndex,
                      builder: (context, state) {
                        return CustomTabBar(
                          tabs: const ["My Schedule", "View Clients"],
                          selectedIndex: state.currentTabIndex,
                          onTabSelected: (index) {
                            context.read<TrainerHomeScreenBloc>().add(
                                  ArtistHomeTabChanged(currentTabIndex: index),
                                );
                          },
                        );
                      },
                    ),
                    20.heightBox,
                    RecommendedHeader(
                      title: "Recommended Artists",
                      onSeeAllTap: () {},
                    ),
                    20.heightBox,
                    BlocBuilder<TrainerHomeScreenBloc, TrainerHomeScreenState>(
                      buildWhen: (previous, current) =>
                          previous.apiStatus != current.apiStatus ||
                          previous.allArtistData != current.allArtistData,
                      builder: (context, state) {
                        switch (state.apiStatus) {
                          case ApiStatus.initial:
                            return const Center(child: LoadingIndicator());
                          case ApiStatus.loading:
                            return const Center(child: LoadingIndicator());
                          case ApiStatus.error:
                            return Center(child: Text(state.message));
                          case ApiStatus.success:
                            final trainers = state.allArtistData;
                            if (trainers.isEmpty) {
                              return const Center(
                                  child: Text("No Artists found."));
                            }
                            return SizedBox(
                              height: context.screenWidth > 420
                                  ? context.screenHeight * 0.36
                                  : context.screenHeight * 0.38,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.allArtistData.length,
                                  itemBuilder: (context, index) {
                                    final artist = state.allArtistData[index];
                                    return GestureDetector(
                                      onTap: () {
                                        context.pushNamed(
                                            AppRouteNames.trainerDetails,
                                            extra: artist);
                                      },
                                      child: Hero(
                                        tag: artist.artistUserId ?? "",
                                        child: Container(
                                          margin: EdgeInsets.only(right: 15),
                                          width: context.screenWidth * 0.6,
                                          padding: padding14,
                                          decoration: BoxDecoration(
                                            color: AppColors.lightgreycardColor,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Column(
                                            crossAxisAlignment: crossAxisStart,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  height: context.screenHeight *
                                                      0.15,
                                                  width: double.infinity,
                                                  imageUrl: artist
                                                          .artistProfileImage ??
                                                      "https://img.freepik.com/premium-photo/young-man-isolated-blue_1368-124991.jpg?semt=ais_hybrid&w=740",
                                                ),
                                              ),
                                              15.heightBox,
                                              Text(artist.artistName ?? "",
                                                  style: context.bodyMedium!
                                                      .copyWith(
                                                    fontWeight: FontWeight.w600,
                                                  )),
                                              5.heightBox,
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.tag,
                                                    size: 16,
                                                    color: AppColors
                                                        .secondaryColor,
                                                  ),
                                                  Text(
                                                    artist.artistTagline ?? "",
                                                    style: context.screenWidth >
                                                            420
                                                        ? context.bodyMedium
                                                        : context.displayLarge,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                              10.heightBox,
                                              Row(
                                                mainAxisAlignment:
                                                    mainAxisSpaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Iconsax.location,
                                                        color: AppColors
                                                            .secondaryColor,
                                                        size: 18,
                                                      ),
                                                      5.widthBox,
                                                      Text(
                                                        "Pakistan",
                                                        style: context
                                                                    .screenWidth >
                                                                420
                                                            ? context.bodyMedium
                                                            : context
                                                                .displayLarge,
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Iconsax.profile_circle,
                                                        color: AppColors
                                                            .secondaryColor,
                                                        size: 18,
                                                      ),
                                                      5.widthBox,
                                                      Text(
                                                        artist.artistLevel ??
                                                            "",
                                                        style: context
                                                                    .screenWidth >
                                                                420
                                                            ? context.bodyMedium
                                                            : context
                                                                .displayLarge,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Spacer(),
                                              SizedBox(
                                                width: double.infinity,
                                                height:
                                                    context.screenWidth > 420
                                                        ? 45
                                                        : 35,
                                                child: RoundButton(
                                                  fontsize:
                                                      context.screenWidth > 420
                                                          ? 19
                                                          : 14,
                                                  radius: 15,
                                                  text: "Book Now",
                                                  onPressed: () {},
                                                  backgroundColor:
                                                      AppColors.secondaryColor,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            );
                        }
                      },
                    ),
                    30.heightBox,
                    RecommendedHeader(
                      title: "Upcoming Sessions",
                      onSeeAllTap: () {},
                    ),
                    20.heightBox,
                    SizedBox(
                      height: context.screenHeight * 0.12,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Container(
                            width: context.screenWidth * 0.9,
                            margin: const EdgeInsets.only(right: 13),
                            padding: defaultPadding,
                            decoration: BoxDecoration(
                              color: AppColors.lightgreycardColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    width: context.screenWidth * 0.25,
                                    height: context.screenHeight * 0.12,
                                    fit: BoxFit.cover,
                                    imageUrl:
                                        "https://img.freepik.com/free-photo/handsome-carefree-guy-dancing-hip-hop-having-fun_176420-21699.jpg?semt=ais_hybrid&w=740",
                                  ),
                                ),
                                10.widthBox,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Text("Dance Class",
                                              style: context.screenWidth > 420
                                                  ? context.headlineSmall!
                                                      .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    )
                                                  : context.bodyMedium!
                                                      .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    )),
                                          Spacer(),
                                          Container(
                                            width: context.screenWidth * 0.22,
                                            height: 25,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: AppColors.secondaryColor
                                                    .withAlpha(
                                                        (0.2 * 255).toInt())),
                                            child: Center(
                                              child: Text(
                                                "Confirmed",
                                                style: context.screenWidth > 420
                                                    ? context.bodySmall
                                                    : context.displayLarge,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      6.heightBox,
                                      Text(
                                        "Group Class",
                                        style: context.screenWidth > 420
                                            ? context.bodySmall
                                            : context.displayLarge,
                                      ),
                                      6.heightBox,
                                      Row(
                                        children: [
                                          Icon(Iconsax.calendar,
                                              color: AppColors.secondaryColor,
                                              size: 18),
                                          5.widthBox,
                                          Text(
                                            "26 July 2025  11:20Pm",
                                            style: context.screenWidth > 420
                                                ? context.bodySmall
                                                : context.displayLarge,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    20.heightBox,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
