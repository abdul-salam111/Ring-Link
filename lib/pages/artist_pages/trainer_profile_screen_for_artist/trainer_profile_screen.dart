import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ring_link/blocs/artist_blocs/trainer_profile_for_artist/trainer_profile_artist/bloc/trainer_profile_artist_bloc.dart';
import 'package:ring_link/utils/date_ext.dart';
import 'package:ring_link/utils/library.dart';
import 'package:ring_link/utils/num_txt.dart';
import 'package:ring_link/widgets/components.dart';
import 'package:ring_link/widgets/outlineWidgets.dart';

import '../../../models/trainers/get_models/get_trainer_details_model.dart';

class TrainerProfileScreenForArtist extends StatefulWidget {
  final GetTrainerDetailsModel? getTrainerDetailsModel;
  const TrainerProfileScreenForArtist({super.key, this.getTrainerDetailsModel});

  @override
  State<TrainerProfileScreenForArtist> createState() =>
      _TrainerProfileScreenForArtistState();
}

class _TrainerProfileScreenForArtistState
    extends State<TrainerProfileScreenForArtist> {
  late TrainerProfileArtistBloc trainerProfileArtistBloc;

  @override
  void initState() {
    super.initState();
    trainerProfileArtistBloc = TrainerProfileArtistBloc();
    if (widget.getTrainerDetailsModel?.trainerLocation != null) {
      final geoPoint = widget.getTrainerDetailsModel!.trainerLocation!;
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
      body: BlocProvider(
        create: (context) => trainerProfileArtistBloc,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: crossAxisStart,
            children: [
              TrainerProfileHeaderCard(
                onMoreBtnPress: (){},
                mainButtonText: "Book a Session",
                price: widget.getTrainerDetailsModel!.trainerPrice.toString(),
                onpress: () {},
                isTrainerProfile: true,
                profilePic:
                    widget.getTrainerDetailsModel?.trainerProfilePicture ?? "",
                name: widget.getTrainerDetailsModel?.trainerUsername ?? "",
                subtitle: widget.getTrainerDetailsModel?.trainerTagline ?? "",
                rating: double.parse(
                    widget.getTrainerDetailsModel?.trainerRating ?? "0.0"),
                location: "Brazilian",
                experience: widget.getTrainerDetailsModel?.trainerExpereince ??
                    "0 Years",
                screenTitle:
                    widget.getTrainerDetailsModel?.trainerUsername ?? "",
                onShare: () {},
                onFeedback: () {},
                
              ),
              20.heightBox,
              Padding(
                padding: screenPadding,
                child: BlocBuilder<TrainerProfileArtistBloc,
                    TrainerProfileArtistState>(
                  buildWhen: (previous, current) =>
                      previous.currentTabIndex != current.currentTabIndex,
                  builder: (context, state) {
                    return CustomTabBar(
                      tabs: const ["About", "Pricing", "Reviews"],
                      selectedIndex: state.currentTabIndex,
                      onTabSelected: (index) {
                        context.read<TrainerProfileArtistBloc>().add(
                              ChangeTrainerProfileTab(currentTabIndex: index),
                            );
                      },
                    );
                  },
                ),
              ),
              BlocBuilder<TrainerProfileArtistBloc, TrainerProfileArtistState>(
                builder: (context, state) {
                  if (state.currentTabIndex == 0) {
                    return Padding(
                      padding: screenPadding,
                      child: Column(
                        crossAxisAlignment: crossAxisStart,
                        children: [
                          20.heightBox,
                          Text(
                            "Short Bio",
                            style: context.bodyLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          10.heightBox,
                          Text(
                            widget.getTrainerDetailsModel?.trainerBio ?? "",
                            style: context.bodyMedium,
                            textAlign: textAlignJustify,
                          ),
                          20.heightBox,
                          Text(
                            "Credentials",
                            style: context.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          20.heightBox,
                          Row(
                            crossAxisAlignment: crossAxisStart,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: widget.getTrainerDetailsModel
                                          ?.trainerProfilePicture ??
                                     defaultImage,
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              10.widthBox,
                              Column(
                                crossAxisAlignment: crossAxisStart,
                                children: [
                                  Text(
                                    "Certified UFC Coach",
                                    style: context.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  5.heightBox,
                                  Text(
                                    "Black Belt in BJJ",
                                    style: context.bodySmall!.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                  5.heightBox,
                                  Text(
                                    "10+ years Coaching",
                                    style: context.bodySmall!.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
              BlocBuilder<TrainerProfileArtistBloc, TrainerProfileArtistState>(
                builder: (context, state) {
                  return state.currentTabIndex == 1
                      ? Padding(
                          padding: screenPadding,
                          child: Column(
                            crossAxisAlignment: crossAxisStart,
                            children: [
                              20.heightBox,
                              Text(
                                "Hourly Rate",
                                style: context.bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              10.heightBox,
                              Text(
                                "\$${widget.getTrainerDetailsModel?.trainerPrice}",
                                style: context.headlineSmall!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              20.heightBox,
                              Text(
                                "Session Type",
                                style: context.bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              widget.getTrainerDetailsModel!.trainerSessionType!
                                      .isNotEmpty
                                  ? Wrap(
                                      spacing: 5,
                                      runSpacing: 5,
                                      children: List.generate(
                                          widget
                                                  .getTrainerDetailsModel
                                                  ?.trainerSessionType!
                                                  .length ??
                                              0, (index) {
                                        return OutlinedButtonWidget(
                                            title: widget.getTrainerDetailsModel
                                                        ?.trainerSessionType?[
                                                    index] ??
                                                "");
                                      }),
                                    )
                                  : Center(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          "No Session Type Available",
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
                              widget.getTrainerDetailsModel!
                                      .trainerAvailableSlots!.isNotEmpty
                                  ? Text(
                                      widget.getTrainerDetailsModel
                                              ?.trainerAvailableSlots?.first ??
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
                              // In your Pricing tab section where the map is:
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 200,
                                  child: IgnorePointer(
                                    // Add this widget
                                    ignoring:
                                        false, // Set to true if you want to disable all gestures
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
              BlocBuilder<TrainerProfileArtistBloc, TrainerProfileArtistState>(
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
                                widget.getTrainerDetailsModel!.trainerReviews!
                                        .isNotEmpty
                                    ? ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        itemCount: widget.getTrainerDetailsModel
                                            ?.trainerReviews?.length,
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
                                                                    double.parse(widget.getTrainerDetailsModel?.trainerReviews?[index].rating ??
                                                                            "0.0")
                                                                        .toInt(),
                                                                    (index) {
                                                                  return Icon(
                                                                    Icons.star,
                                                                    color: Colors
                                                                        .amber,
                                                                    size: 15,
                                                                  );
                                                                }),
                                                              ),
                                                              5.widthBox,
                                                              Text(
                                                                "${widget.getTrainerDetailsModel?.trainerReviews?[index].createdAt?.toSimpleDate()}",
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
                                                    "${widget.getTrainerDetailsModel?.trainerReviews?[index].reviewText}",
                                                    style: context.bodySmall,
                                                    textAlign: textAlignJustify,
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
                                                .copyWith(color: Colors.white),
                                          ),
                                        ),
                                      )
                              ],
                            ),
                          ),
                        )
                      : SizedBox.shrink();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
