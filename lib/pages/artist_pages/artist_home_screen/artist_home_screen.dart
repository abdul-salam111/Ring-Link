import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ring_link/blocs/artist_blocs/artist_home_bloc/bloc/artist_home_bloc.dart';
import 'package:ring_link/main.dart';
import 'package:ring_link/services/services_manager.dart';

import 'package:ring_link/utils/enums.dart';
import 'package:ring_link/utils/library.dart';
import 'package:ring_link/utils/num_txt.dart';
import 'package:ring_link/widgets/components.dart';
import '../../../routes/routes.dart';

class ArtistHomeScreen extends StatefulWidget {
  const ArtistHomeScreen({super.key});

  @override
  State<ArtistHomeScreen> createState() => _ArtistHomeScreenState();
}

class _ArtistHomeScreenState extends State<ArtistHomeScreen> {
  late ArtistHomeBloc artistHomeBloc;
  @override
  void initState() {
    super.initState();
    artistHomeBloc = ArtistHomeBloc(getIt());
    artistHomeBloc.add(FetchAllTrainerEvent());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.focusScope.unfocus();
      },
      child: BlocProvider(
        create: (context) => artistHomeBloc,
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: screenPadding,
                child: Column(
                  children: [
                    10.heightBox,
                    WelcomeHeader(
                      subtitle: "Ready to level up your training",
                      imageUrl: SessionController()
                              .getArtistDetails
                              .artistProfileImage ??
                          "",
                      onNotificationTap: () {},
                    ),
                    20.heightBox,
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            onChanged: (value) {
                              artistHomeBloc
                                  .add(SearchTrainerEvent(searchQuery: value));
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
                          onTap: () {
                            context.pushNamed(
                              AppRouteNames.trainerFilter,
                            );
                          },
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
                    BlocBuilder<ArtistHomeBloc, ArtistHomeState>(
                      buildWhen: (previous, current) =>
                          previous.currentTabIndex != current.currentTabIndex,
                      builder: (context, state) {
                        return CustomTabBar(
                          tabs: const ["Find a Trainer", "Book a Session"],
                          selectedIndex: state.currentTabIndex,
                          onTabSelected: (index) {
                            context.read<ArtistHomeBloc>().add(
                                  ArtistHomeTabChanged(currentTabIndex: index),
                                );
                          },
                        );
                      },
                    ),
                    20.heightBox,
                    RecommendedHeader(
                      title: "Recommended Trainers",
                      onSeeAllTap: () {},
                    ),
                    20.heightBox,
                    BlocBuilder<ArtistHomeBloc, ArtistHomeState>(
                      buildWhen: (previous, current) =>
                          previous.apiStatus != current.apiStatus ||
                          previous.allTrainersData != current.allTrainersData,
                      builder: (context, state) {
                        switch (state.apiStatus) {
                          case ApiStatus.initial:
                            return const Center(child: LoadingIndicator());
                          case ApiStatus.loading:
                            return const Center(child: LoadingIndicator());
                          case ApiStatus.error:
                            return Center(child: Text(state.message));
                          case ApiStatus.success:
                            final trainers = state.allTrainersData;
                            if (trainers.isEmpty) {
                              return const Center(
                                  child: Text("No trainers found."));
                            }
                            return SizedBox(
                              height: context.screenWidth > 420
                                  ? context.screenHeight * 0.36
                                  : context.screenHeight * 0.38,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: trainers.length,
                                itemBuilder: (context, index) {
                                  final trainer = trainers[index];

                                  return GestureDetector(
                                    onTap: () {
                                      context.pushNamed(
                                          AppRouteNames.artistDetails,
                                          extra: state.allTrainersData[index]);
                                    },
                                    child: Hero(
                                      tag: trainer.trainerId ?? "",
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(right: 15),
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
                                                imageUrl: trainer
                                                        .trainerProfilePicture ??
                                                    "https://t4.ftcdn.net/jpg/02/15/84/43/360_F_215844325_ttX9YiIIyeaR7Ne6EaLLjMAmy4GvPC69.jpg",
                                                fit: BoxFit.cover,
                                                height:
                                                    context.screenHeight * 0.15,
                                                width: double.infinity,
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Container(
                                                  color: Colors.grey[300],
                                                  height: 100,
                                                  width: double.infinity,
                                                  child: const Icon(
                                                    Icons.error,
                                                    color: Colors.redAccent,
                                                    size: 40,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            15.heightBox,
                                            Text(
                                              trainer.trainerUsername ?? "",
                                              style:
                                                  context.bodyMedium!.copyWith(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            5.heightBox,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(Icons.tag,
                                                        color: AppColors
                                                            .secondaryColor,
                                                        size: 18),
                                                    5.widthBox,
                                                    Text(
                                                      trainer.trainerTagline ??
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
                                                Row(
                                                  children: [
                                                    const Icon(Iconsax.location,
                                                        color: AppColors
                                                            .secondaryColor,
                                                        size: 18),
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
                                              ],
                                            ),
                                            5.heightBox,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Row(
                                                        children: List.generate(
                                                            double.parse(trainer
                                                                        .trainerRating ??
                                                                    "0.0")
                                                                .toInt(),
                                                            (index) {
                                                      return Icon(Icons.star,
                                                          color: AppColors
                                                              .secondaryColor,
                                                          size: 18);
                                                    })),
                                                    5.widthBox,
                                                    Text(
                                                      "${trainer.trainerRating}",
                                                      style: context
                                                                  .screenWidth >
                                                              420
                                                          ? context.bodyMedium
                                                          : context
                                                              .displayLarge,
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  "\$${trainer.trainerPrice}",
                                                  style: context.bodyMedium!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                )
                                              ],
                                            ),
                                            Spacer(),
                                            SizedBox(
                                              width: double.infinity,
                                              height: context.screenWidth > 420
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
                                },
                              ),
                            );
                        }
                      },
                    ),
                    30.heightBox,
                    Row(
                      mainAxisAlignment: mainAxisSpaceBetween,
                      children: [
                        Text("Upcoming Sessions",
                            style: context.headlineSmall!.copyWith(
                              fontWeight: FontWeight.w600,
                            )),
                        Text("See All",
                            style: context.bodyLarge!.copyWith(
                              fontWeight: FontWeight.normal,
                            )),
                      ],
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
                                      Text("Dance Class",
                                          style: context.screenWidth > 420
                                              ? context.headlineSmall!.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                )
                                              : context.bodyMedium!.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                )),
                                      6.heightBox,
                                      Row(
                                        children: [
                                          Text(
                                            "Coaching",
                                            style: context.screenWidth > 420
                                                ? context.bodySmall
                                                : context.displayLarge,
                                          ),
                                          const Spacer(),
                                          Row(
                                            children: [
                                              Icon(Iconsax.location,
                                                  color:
                                                      AppColors.secondaryColor,
                                                  size: 18),
                                              5.widthBox,
                                              Text(
                                                "Pakistan",
                                                style: context.screenWidth > 420
                                                    ? context.bodySmall
                                                    : context.displayLarge,
                                              ),
                                            ],
                                          ),
                                        ],
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

class TrainerFilter extends StatefulWidget {
  const TrainerFilter({super.key});

  @override
  State<TrainerFilter> createState() => _TrainerFilterState();
}

class _TrainerFilterState extends State<TrainerFilter> {
  late ArtistHomeBloc artistHomeBloc;
  @override
  void initState() {
    super.initState();
    artistHomeBloc = ArtistHomeBloc(getIt());
  }

  final expertiesLevels = {"Beginner", "Intermediate", "Advanced"};

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => artistHomeBloc,
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.95,
        maxChildSize: 1.0,
        minChildSize: 0.5,
        builder: (context, scrollController) {
          return GestureDetector(
            onTap: () {
              context.focusScope.unfocus();
            },
            child: Container(
              padding: defaultPadding,
              decoration: BoxDecoration(
                color: AppColors.scaffoldBackgroundColorDark,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: padding14,
                      child: SizedBox(
                        height: 35,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Center(
                              child: Text(
                                "Your Perfect Trainer",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: const Color(0xff212429),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      size: 20,
                                    ),
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    20.heightBox,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        crossAxisAlignment: crossAxisStart,
                        children: [
                          Text(
                            "Location",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.white),
                          ),
                          15.heightBox,
                          BlocBuilder<ArtistHomeBloc, ArtistHomeState>(
                              buildWhen: (previous, current) =>
                                  previous.selectedLocation !=
                                  current.selectedLocation,
                              builder: (context, state) {
                                return Material(
                                  child: DropdownButtonFormField<String>(
                                    style: context.bodyMedium!
                                        .copyWith(color: Colors.white),
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(Iconsax.location),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 15),
                                        hintText: 'Choose an option',
                                        hintStyle: context.bodyMedium!
                                            .copyWith(color: Colors.white),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            borderSide: BorderSide(
                                                color: AppColors.lightGrey)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            borderSide: BorderSide(
                                                color: AppColors.lightGrey)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            borderSide: BorderSide(
                                                color:
                                                    AppColors.primaryColor))),
                                    items: state.locations.map((option) {
                                      return DropdownMenuItem(
                                        value: option,
                                        child: Text(option),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      if (value != null) {
                                        context
                                            .read<ArtistHomeBloc>()
                                            .add(SelectLocation(value));
                                      }
                                    },
                                  ),
                                );
                              }),
                          20.heightBox,
                          Text(
                            "Experience Level",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.white),
                          ),
                          10.heightBox,
                          BlocBuilder<ArtistHomeBloc, ArtistHomeState>(
                            buildWhen: (previous, current) =>
                                previous.selectedLevel != current.selectedLevel,
                            builder: (context, state) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: expertiesLevels.map((entry) {
                                  final isSelected =
                                      state.selectedLevel == entry;
                                  return GestureDetector(
                                    onTap: () => context
                                        .read<ArtistHomeBloc>()
                                        .add(SelectLevel(entry)),
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                color: Colors.white24),
                                            color: Colors.transparent,
                                          ),
                                          width: 24,
                                          height: 24,
                                          child: isSelected
                                              ? Center(
                                                  child: Icon(Icons.check,
                                                      color: Colors.white60,
                                                      size: 18),
                                                )
                                              : null,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          entry,
                                          style: context.bodyMedium!.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              );
                            },
                          ),
                          20.heightBox,
                          Text(
                            "Price Range",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.white),
                          ),
                          10.heightBox,
                          BlocBuilder<ArtistHomeBloc, ArtistHomeState>(
                            buildWhen: (previous, current) =>
                                previous.selectedRange != current.selectedRange,
                            builder: (context, state) {
                              return Column(
                                children: [
                                  Material(
                                      child: RangeSlider(
                                    activeColor: AppColors.secondaryColor,
                                    inactiveColor: AppColors.lightgreycardColor,
                                    min: 10,
                                    max: 500,
                                    onChanged: (val) {
                                      context
                                          .read<ArtistHomeBloc>()
                                          .add(SelectPriceRange(val));
                                    },
                                    values: state.selectedRange,
                                  )),
                                  Row(
                                    mainAxisAlignment: mainAxisSpaceAround,
                                    children: [
                                      Text('\$0', style: context.bodySmall),
                                      Text('\$100', style: context.bodySmall),
                                      Text('\$200', style: context.bodySmall),
                                      Text('\$300', style: context.bodySmall),
                                      Text('\$400', style: context.bodySmall),
                                      Text('\$500', style: context.bodySmall),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                          20.heightBox,
                          Text(
                            "Minimum Rating",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.white),
                          ),
                          10.heightBox,
                          BlocBuilder<ArtistHomeBloc, ArtistHomeState>(
                              buildWhen: (previous, current) =>
                                  previous.minimumRating !=
                                  current.minimumRating,
                              builder: (context, state) {
                                return Material(
                                  child: DropdownButtonFormField<String>(
                                    style: context.bodyMedium!
                                        .copyWith(color: Colors.white),
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(Iconsax.star5),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 15),
                                        hintText: 'Select minimum rating',
                                        hintStyle: context.bodyMedium!
                                            .copyWith(color: Colors.white),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            borderSide: BorderSide(
                                                color: AppColors.lightGrey)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            borderSide: BorderSide(
                                                color: AppColors.lightGrey)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            borderSide: BorderSide(
                                                color:
                                                    AppColors.primaryColor))),
                                    items: ["1.0", "2.0", "3.0", "4.0", "5.0"]
                                        .map((option) {
                                      return DropdownMenuItem(
                                        value: option,
                                        child: Text(option),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      if (value != null) {
                                        context.read<ArtistHomeBloc>().add(
                                            SelectMinimumRating(
                                                double.parse(value)));
                                      }
                                    },
                                  ),
                                );
                              }),
                          20.heightBox,
                          Text(
                            "Availability",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.white),
                          ),
                          10.heightBox,
                          BlocBuilder<ArtistHomeBloc, ArtistHomeState>(
                              buildWhen: (previous, current) =>
                                  previous.avialibility != current.avialibility,
                              builder: (context, state) {
                                return Material(
                                  child: DropdownButtonFormField<String>(
                                    style: context.bodyMedium!
                                        .copyWith(color: Colors.white),
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(Iconsax.user),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 15),
                                        hintText: 'Select Availbility',
                                        hintStyle: context.bodyMedium!
                                            .copyWith(color: Colors.white),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            borderSide: BorderSide(
                                                color: AppColors.lightGrey)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            borderSide: BorderSide(
                                                color: AppColors.lightGrey)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            borderSide: BorderSide(
                                                color:
                                                    AppColors.primaryColor))),
                                    items: ["Morining", "Afternoon", "Evening"]
                                        .map((option) {
                                      return DropdownMenuItem(
                                        value: option,
                                        child: Text(option),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      if (value != null) {
                                        context
                                            .read<ArtistHomeBloc>()
                                            .add(SelectAvailability(value));
                                      }
                                    },
                                  ),
                                );
                              }),
                          20.heightBox,
                          Row(
                            mainAxisAlignment: mainAxisSpaceBetween,
                            children: [
                              Text(
                                "Virtual Training Available",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: Colors.white),
                              ),
                              BlocBuilder<ArtistHomeBloc, ArtistHomeState>(
                                builder: (context, state) {
                                  return Material(
                                    child: Switch(
                                        value: state.virtualTraining,
                                        onChanged: (val) {
                                          context
                                              .read<ArtistHomeBloc>()
                                              .add(SelectVirtualTraining(val));
                                        }),
                                  );
                                },
                              )
                            ],
                          ),
                          20.heightBox,
                          Text(
                            "Session Type",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.white),
                          ),
                          10.heightBox,
                          BlocBuilder<ArtistHomeBloc, ArtistHomeState>(
                              buildWhen: (previous, current) =>
                                  previous.avialibility != current.avialibility,
                              builder: (context, state) {
                                return Material(
                                  child: DropdownButtonFormField<String>(
                                    style: context.bodyMedium!
                                        .copyWith(color: Colors.white),
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(Iconsax.user),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 15),
                                        hintText: 'Select Availbility',
                                        hintStyle: context.bodyMedium!
                                            .copyWith(color: Colors.white),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            borderSide: BorderSide(
                                                color: AppColors.lightGrey)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            borderSide: BorderSide(
                                                color: AppColors.lightGrey)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            borderSide: BorderSide(
                                                color:
                                                    AppColors.primaryColor))),
                                    items: ["Morining", "Afternoon", "Evening"]
                                        .map((option) {
                                      return DropdownMenuItem(
                                        value: option,
                                        child: Text(option),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      if (value != null) {
                                        context
                                            .read<ArtistHomeBloc>()
                                            .add(SelectAvailability(value));
                                      }
                                    },
                                  ),
                                );
                              }),
                          20.heightBox,
                          Row(
                            mainAxisAlignment: mainAxisSpaceBetween,
                            children: [
                              SizedBox(
                                width: context.screenWidth * 0.4,
                                height: 45,
                                child: RoundButton(
                                  text: "Reset",
                                  onPressed: () {},
                                  backgroundColor: AppColors.lightgreycardColor,
                                ),
                              ),
                              SizedBox(
                                width: context.screenWidth * 0.4,
                                height: 45,
                                child: RoundButton(
                                  text: "Apply",
                                  onPressed: () {},
                                  backgroundColor: AppColors.secondaryColor,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
