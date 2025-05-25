import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ring_link/blocs/artist_blocs/trainer_profile_for_artist/trainer_profile_artist/bloc/trainer_profile_artist_bloc.dart';
import 'package:ring_link/utils/library.dart';
import 'package:ring_link/utils/num_txt.dart';
import 'package:ring_link/widgets/components.dart';

import '../../../widgets/custom_tab_bar.dart';

class TrainerProfileScreenForArtist extends StatefulWidget {
  const TrainerProfileScreenForArtist({super.key});

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
    addMarkerAtAddress("2nd Ave, Airline Society, Lahore, Pakistan");
  }

  Future<LatLng> getCoordinatesFromAddress(String address) async {
    List<Location> locations = await locationFromAddress(address);
    return LatLng(locations[0].latitude, locations[0].longitude);
  }

  final Set<Marker> _markers = {};
  final Completer<GoogleMapController> _controller = Completer();

  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(31.445753336074077, 74.26198493728958),
    zoom: 14.4746,
  );

  void addMarkerAtAddress(String address) async {
    LatLng position = await getCoordinatesFromAddress(address);

    // Add Marker
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId("marker_1"),
          position: position,
          infoWindow: InfoWindow(title: "Selected Address"),
        ),
      );
    });

    // Move Camera
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLng(position));
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
              Container(
                decoration: BoxDecoration(
                    color: Colors.blue.withAlpha((0.03 * 255).toInt()),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40))),
                child: Padding(
                  padding: screenPadding,
                  child: Column(
                    children: [
                      50.heightBox,
                      CustomAppBarSec(
                        title: 'Stephanie',
                      ),
                      20.heightBox,
                      Row(
                        crossAxisAlignment: crossAxisCenter,
                        children: [
                          CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                                "https://img.freepik.com/premium-photo/young-man-isolated-blue_1368-124991.jpg?semt=ais_hybrid&w=740"),
                            radius: 30,
                          ),
                          10.widthBox,
                          Column(
                            crossAxisAlignment: crossAxisStart,
                            children: [
                              5.heightBox,
                              Text(
                                "Stephanie Nicol",
                                style: context.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              3.heightBox,
                              Text(
                                "Jiu-Jitsu",
                                style: context.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                          Spacer(),
                          Text(
                            "\$50/hr",
                            style: context.headlineSmall!
                                .copyWith(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      10.heightBox,
                      Row(
                        mainAxisAlignment: mainAxisSpaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/icons/setting.png",
                                height: (context.screenWidth <= 420) ? 20 : 30,
                                width: (context.screenWidth <= 420) ? 20 : 30,
                              ),
                              5.widthBox,
                              Text(
                                "10+ years",
                                style: context.bodyLarge!.copyWith(
                                    fontSize:
                                        (context.screenWidth <= 420) ? 14 : 16),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset(
                                "assets/icons/location.png",
                                height: (context.screenWidth <= 420) ? 14 : 20,
                                width: (context.screenWidth <= 420) ? 14 : 20,
                              ),
                              5.widthBox,
                              Text(
                                "Brazalian",
                                style: context.bodyLarge!.copyWith(
                                    fontSize:
                                        (context.screenWidth <= 420) ? 14 : 16),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Row(
                                children: List.generate(
                                    5,
                                    (index) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: (context.screenWidth <= 420)
                                              ? 14
                                              : 22,
                                        )),
                              ),
                              Text(
                                "5.0",
                                style: context.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffBCBABA)),
                              )
                            ],
                          )
                        ],
                      ),
                      20.heightBox,
                      Row(
                        mainAxisAlignment: mainAxisSpaceAround,
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: const Color(0xff212429),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: IconButton(
                                onPressed: () {
                                  context.pop();
                                },
                                icon: Icon(
                                  Iconsax.message_text,
                                  size: 20,
                                ),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: context.screenWidth * 0.5,
                            height: 45,
                            child: RoundButton(
                              text: "Book a Session",
                              onPressed: () {},
                              backgroundColor: AppColors.secondaryColor,
                            ),
                          ),
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: const Color(0xff212429),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: IconButton(
                                onPressed: () {
                                  context.pop();
                                },
                                icon: Icon(
                                  Iconsax.share,
                                  size: 20,
                                ),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      30.heightBox,
                    ],
                  ),
                ),
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
                            "Meet Stephanie Nico With over 6 years of experience in [MMA specialization], [Trainer Name] has trained fighters from beginners to pros, helping them sharpen their skills and build confidence inside the cage.",
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
                                  imageUrl:
                                      "https://img.freepik.com/premium-photo/young-man-isolated-blue_1368-124991.jpg?semt=ais_hybrid&w=740",
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
                                "\$50/hr",
                                style: context.headlineSmall!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              20.heightBox,
                              Text(
                                "Session Type",
                                style: context.bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              Wrap(
                                spacing: 5,
                                runSpacing: 5,
                                children: [
                                  _buildOutlinedButton("Individual Session"),
                                  _buildOutlinedButton("Group Training"),
                                  _buildOutlinedButton("Virtual Training"),
                                ],
                              ),
                              20.heightBox,
                              Text(
                                "Available Slots",
                                style: context.bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              5.heightBox,
                              Text(
                                "Sunady, Wednesday, 5 PM - 7 PM",
                                style: context.bodySmall!
                                    .copyWith(color: Colors.grey),
                                textAlign: TextAlign.center,
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
                                ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    itemCount: 10,
                                    itemBuilder: (index, cont) {
                                      return Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color:
                                                  AppColors.lightgreycardColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          padding: defaultPadding,
                                          child: Column(
                                            crossAxisAlignment: crossAxisStart,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    crossAxisCenter,
                                                children: [
                                                  CircleAvatar(
                                                    backgroundImage:
                                                        CachedNetworkImageProvider(
                                                            "https://img.freepik.com/premium-photo/young-man-isolated-blue_1368-124991.jpg?semt=ais_hybrid&w=740"),
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
                                                            children:
                                                                List.generate(5,
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
                                                            "Mar 5, 2025",
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
                                                "Great coach! Very patient and explains techniques well. Only wish the gym had more equipment.",
                                                style: context.bodySmall,
                                                textAlign: textAlignJustify,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    })
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

  Widget _buildOutlinedButton(String title) {
    return SizedBox(
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.lightGrey),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          title,
          style: context.bodySmall!.copyWith(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
