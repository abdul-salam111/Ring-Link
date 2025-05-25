import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ring_link/blocs/trainer_blocs/trainer_home_screen/bloc/trainer_home_screen_bloc.dart';

import 'package:ring_link/utils/num_txt.dart';

import 'package:ring_link/widgets/components.dart';

import '../../utils/library.dart';

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
    trainerHomeScreenBloc = TrainerHomeScreenBloc();
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
                      imageUrl:
                          "https://img.freepik.com/premium-photo/young-man-isolated-blue_1368-124991.jpg?semt=ais_hybrid&w=740",
                      onNotificationTap: () {},
                    ),
                    20.heightBox,
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
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
                    SectionHeaderWithAction(
                      title: "Recommended Artists",
                      onSeeAllTap: () {},
                    ),
                    20.heightBox,
                    SizedBox(
                      height: context.screenHeight * 0.36,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(right: 15),
                              width: context.screenWidth * 0.6,
                              padding: padding14,
                              decoration: BoxDecoration(
                                color: AppColors.lightgreycardColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                crossAxisAlignment: crossAxisStart,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "https://img.freepik.com/premium-photo/young-man-isolated-blue_1368-124991.jpg?semt=ais_hybrid&w=740",
                                    ),
                                  ),
                                  15.heightBox,
                                  Text("Stephanie Nicol",
                                      style: context.headlineSmall!.copyWith(
                                        fontWeight: FontWeight.w600,
                                      )),
                                  5.heightBox,
                                  Row(
                                    children: [
                                      Icon(
                                        Iconsax.location,
                                        color: AppColors.secondaryColor,
                                        size: 18,
                                      ),
                                      5.widthBox,
                                      Text("Pakistan"),
                                    ],
                                  ),
                                  5.heightBox,
                                  Row(
                                    mainAxisAlignment: mainAxisSpaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Iconsax.profile_circle,
                                            color: AppColors.secondaryColor,
                                            size: 18,
                                          ),
                                          5.widthBox,
                                          Text("Begginer"),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Iconsax.flash,
                                            color: AppColors.secondaryColor,
                                            size: 18,
                                          ),
                                          5.widthBox,
                                          Text("Strength"),
                                        ],
                                      ),
                                    ],
                                  ),
                                  10.heightBox,
                                  SizedBox(
                                    width: double.infinity,
                                    height: 40,
                                    child: RoundButton(
                                      fontsize: 19,
                                      radius: 15,
                                      text: "View Profile",
                                      onPressed: () {},
                                      backgroundColor: AppColors.secondaryColor,
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
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
