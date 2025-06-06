import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ring_link/blocs/trainer_blocs/trainer_profile_bloc/bloc/trainer_profile_bloc.dart';
import 'package:ring_link/pages/trainer_pages/trainer_profile_screen/trainer_profile_menu_screen.dart';
import 'package:ring_link/services/services_manager.dart';
import 'package:ring_link/utils/date_ext.dart';
import 'package:ring_link/utils/num_txt.dart';
import 'package:ring_link/widgets/custom_tab_bar.dart';
import 'package:ring_link/widgets/profile_headere_section.dart';

import '../../../utils/library.dart';
import '../../../widgets/outlineWidgets.dart';

class TrainerProfile extends StatefulWidget {
  const TrainerProfile({super.key});

  @override
  State<TrainerProfile> createState() => _ArtistProfileState();
}

class _ArtistProfileState extends State<TrainerProfile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TrainerProfileBloc trainerProfileBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    trainerProfileBloc = TrainerProfileBloc();
    if (SessionController().getTrainerDetailsModel.trainerLocation != null) {
      final geoPoint =
          SessionController().getTrainerDetailsModel.trainerLocation!;
      final LatLng position = LatLng(geoPoint.latitude, geoPoint.longitude);
      addMarkerAtPosition(position);
    }
  }

  final Set<Marker> _markers = {};
  final Completer<GoogleMapController> _controller = Completer();

  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(31.445753336074077, 74.26198493728958),
    zoom: 14.4746,
  );

  void addMarkerAtPosition(LatLng position) async {
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          markerId: const MarkerId("trainer_location"),
          position: position,
          infoWindow: const InfoWindow(title: "Trainer Location"),
        ),
      );
    });

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(position, 15));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: TrainerMenuDrawer(),
      key: _scaffoldKey,
      body: BlocProvider(
        create: (context) => trainerProfileBloc,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: crossAxisStart,
            children: [
              TrainerProfileHeaderCard(
                isTrainerProfile: true,
                onMoreBtnPress: () =>
                    _scaffoldKey.currentState!.openEndDrawer(),
                isProfileScreen: true,
                isShowFeedbackButtton: false,
                onmoreIcon: Iconsax.menu_1,
                isShowShareButtton: false,
                price:
                    SessionController().getTrainerDetailsModel.trainerPrice ??
                        "0.0",
                onShare: () {},
                onFeedback: () {},
                screenTitle: "My Profile",
                mainButtonText: "Edit Profile",
                profilePic: SessionController()
                        .getTrainerDetailsModel
                        .trainerProfilePicture ??
                    defaultImage,
                name: SessionController()
                        .getTrainerDetailsModel
                        .trainerUsername ??
                    "",
                subtitle:
                    SessionController().getTrainerDetailsModel.trainerTagline ??
                        "",
                onpress: () {},
                rating: double.parse(
                    SessionController().getTrainerDetailsModel.trainerRating ??
                        "0.0"),
                location:
                    SessionController().getTrainerDetailsModel.trainerAddress ??
                        "",
                experience: SessionController()
                        .getTrainerDetailsModel
                        .trainerExpereince ??
                    "",
              ),
              10.heightBox,
              Padding(
                padding: screenPadding,
                child: BlocBuilder<TrainerProfileBloc, TrainerProfileState>(
                  buildWhen: (previous, current) =>
                      previous.currentTabIndex != current.currentTabIndex,
                  builder: (context, state) {
                    return CustomTabBar(
                      tabs: const ["About", "Pricing", "Reviews"],
                      selectedIndex: state.currentTabIndex,
                      onTabSelected: (index) {
                        context.read<TrainerProfileBloc>().add(
                              ChangeTrainerProfileTab(currentTabIndex: index),
                            );
                      },
                    );
                  },
                ),
              ),
              10.heightBox,
              BlocBuilder<TrainerProfileBloc, TrainerProfileState>(
                buildWhen: (previous, current) =>
                    previous.currentTabIndex != current.currentTabIndex,
                builder: (context, state) {
                  return state.currentTabIndex == 0
                      ? Padding(
                          padding: screenPadding,
                          child: Column(
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
                                SessionController()
                                        .getTrainerDetailsModel
                                        .trainerBio ??
                                    "",
                                style: context.bodyMedium,
                                textAlign: textAlignJustify,
                              ),
                              20.heightBox,
                            ],
                          ),
                        )
                      : SizedBox.shrink();
                },
              ),
              BlocBuilder<TrainerProfileBloc, TrainerProfileState>(
                buildWhen: (previous, current) =>
                    previous.currentTabIndex != current.currentTabIndex,
                builder: (context, state) {
                  return state.currentTabIndex == 1
                      ? Padding(
                          padding: screenPadding,
                          child: Column(
                            crossAxisAlignment: crossAxisStart,
                            children: [
                              10.heightBox,
                              Text(
                                "Hourly Rate",
                                style: context.bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              10.heightBox,
                              Text(
                                "\$${SessionController().getTrainerDetailsModel.trainerPrice}",
                                style: context.headlineSmall!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              20.heightBox,
                              Text(
                                "Preferred Training Type",
                                style: context.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
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
                                                        .trainerSessionType?[
                                                    index] ??
                                                "");
                                      }),
                                    )
                                  : Center(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          "No Session Type Selected",
                                          style: context.bodySmall,
                                        ),
                                      ),
                                    ),
                              20.heightBox,
                              Text(
                                "Available Slots",
                                style: context.bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              5.heightBox,
                              SessionController()
                                      .getTrainerDetailsModel
                                      .trainerAvailableSlots!
                                      .isNotEmpty
                                  ? Text(
                                      SessionController()
                                              .getTrainerDetailsModel
                                              .trainerAvailableSlots
                                              ?.first ??
                                          "",
                                      style: context.bodySmall!
                                          .copyWith(color: Colors.grey),
                                      textAlign: TextAlign.center,
                                    )
                                  : Center(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          "Not Available",
                                          style: context.bodySmall,
                                        ),
                                      ),
                                    ),
                              20.heightBox,
                              Text(
                                "Training Location",
                                style: context.bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              5.heightBox,
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 200,
                                  child: IgnorePointer(
                                    ignoring: false,
                                    child: GoogleMap(
                                      gestureRecognizers: <Factory<
                                          OneSequenceGestureRecognizer>>{
                                        Factory<OneSequenceGestureRecognizer>(
                                          () => EagerGestureRecognizer(),
                                        ),
                                      }.toSet(),
                                      key: const ValueKey('google_map_key'),
                                      markers: _markers,
                                      mapType: MapType.normal,
                                      initialCameraPosition: _kGooglePlex,
                                      onMapCreated:
                                          (GoogleMapController controller) {
                                        _controller.complete(controller);
                                      },
                                      zoomGesturesEnabled: true,
                                      scrollGesturesEnabled: true,
                                      rotateGesturesEnabled: true,
                                      tiltGesturesEnabled: true,
                                      myLocationEnabled: true,
                                      myLocationButtonEnabled: true,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : SizedBox.shrink();
                },
              ),
              BlocBuilder<TrainerProfileBloc, TrainerProfileState>(
                  buildWhen: (previous, current) =>
                      previous.currentTabIndex != current.currentTabIndex,
                  builder: (context, state) {
                    return state.currentTabIndex == 2
                        ? Padding(
                            padding: screenPadding,
                            child: Align(
                              alignment: topLeft,
                              child: Column(
                                crossAxisAlignment: crossAxisStart,
                                children: [
                                  20.heightBox,
                                  Row(
                                    mainAxisAlignment: mainAxisSpaceBetween,
                                    children: [
                                      Text(
                                        "Recent Reviews",
                                        style: context.bodyLarge!.copyWith(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "See More",
                                        style: context.bodyMedium!.copyWith(
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                  SessionController()
                                          .getTrainerDetailsModel
                                          .trainerReviews!
                                          .isNotEmpty
                                      ? ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          itemCount: SessionController()
                                              .getTrainerDetailsModel
                                              .trainerReviews
                                              ?.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColors
                                                        .lightgreycardColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                padding: defaultPadding,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      crossAxisStart,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          crossAxisCenter,
                                                      children: [
                                                        CircleAvatar(
                                                          backgroundImage:
                                                              CachedNetworkImageProvider(
                                                                  defaultImage),
                                                        ),
                                                        10.widthBox,
                                                        Column(
                                                          crossAxisAlignment:
                                                              crossAxisStart,
                                                          children: [
                                                            Text(
                                                              "Abdul Salam",
                                                              style: context
                                                                  .bodySmall!
                                                                  .copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                            ),
                                                            Row(
                                                              children: [
                                                                Row(
                                                                  children: List.generate(
                                                                      double.parse(SessionController().getTrainerDetailsModel.trainerReviews?[index].rating ??
                                                                              "0.0")
                                                                          .toInt(),
                                                                      (index) {
                                                                    return Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: Colors
                                                                          .amber,
                                                                      size: 15,
                                                                    );
                                                                  }),
                                                                ),
                                                                5.widthBox,
                                                                Text(
                                                                  "${SessionController().getTrainerDetailsModel.trainerReviews?[index].createdAt?.toSimpleDate()}",
                                                                  style: context
                                                                      .bodySmall,
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    10.heightBox,
                                                    Text(
                                                      "${SessionController().getTrainerDetailsModel.trainerReviews?[index].reviewText}",
                                                      style: context.bodySmall,
                                                      textAlign:
                                                          textAlignJustify,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          })
                                      : Center(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 30),
                                            child: Text(
                                              "No reviews given yet!",
                                              style: context.bodySmall!
                                                  .copyWith(
                                                      color: Colors.white),
                                            ),
                                          ),
                                        )
                                ],
                              ),
                            ),
                          )
                        : SizedBox.shrink();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
