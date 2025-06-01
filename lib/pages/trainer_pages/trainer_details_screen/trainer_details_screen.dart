import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ring_link/models/artists/get_models/get_artist_details.dart';
import 'package:ring_link/routes/routes.dart';

import 'package:ring_link/utils/library.dart';
import 'package:ring_link/utils/num_txt.dart';
import 'package:ring_link/widgets/components.dart';

class TrainerDetailsScreen extends StatelessWidget {
  final GetArtistDetails? getArtistDetails;
  const TrainerDetailsScreen({super.key, this.getArtistDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Hero(
          tag: getArtistDetails?.artistUserId??"",
          child: CachedNetworkImage(
              height: context.screenHeight * 0.6,
              width: double.infinity,
              fit: BoxFit.cover,
              imageUrl: getArtistDetails?.artistProfileImage ??
                  "https://img.freepik.com/premium-photo/young-man-isolated-blue_1368-124991.jpg?semt=ais_hybrid&w=740"),
        ),
        Align(
          alignment: bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            height: context.screenHeight * 0.55,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Color(0xff121315),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: crossAxisStart,
                children: [
                  20.heightBox,
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                        color: Color(0xff1C1F23),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star,
                          size: 15,
                          color: AppColors.secondaryColor,
                        ),
                        2.widthBox,
                        Text(
                          getArtistDetails?.artistTagline ?? "",
                          style: context.screenWidth > 420
                              ? context.bodyLarge!.copyWith(
                                  color: AppColors.secondaryColor,
                                )
                              : context.bodyMedium!.copyWith(
                                  color: AppColors.secondaryColor,
                                ),
                        )
                      ],
                    ),
                  ),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: mainAxisSpaceBetween,
                    children: [
                      Text(
                        getArtistDetails?.artistName ?? "",
                        style: context.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
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
                            getArtistDetails?.artistLevel ?? "",
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
                            getArtistDetails?.artistAddress??"",
                            style: context.bodyLarge!.copyWith(
                                fontSize:
                                    (context.screenWidth <= 420) ? 14 : 16),
                          )
                        ],
                      ),
                    ],
                  ),
                  15.heightBox,
                  Text(
                    "Short Bio",
                    style: context.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  10.heightBox,
                  Text(
                    "${getArtistDetails?.artistBio}",
                    style: context.bodyMedium,
                    textAlign: textAlignJustify,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  20.heightBox,
                  Row(
                    mainAxisAlignment: mainAxisSpaceBetween,
                    children: [
                      SizedBox(
                        width: context.screenWidth * 0.4,
                        height: 45,
                        child: RoundButton(
                          text: "View Profile",
                          onPressed: () {
                            context.pushNamed(
                                AppRouteNames.artistProfileForTrainer,
                                extra: getArtistDetails);
                          },
                          backgroundColor: AppColors.lightgreycardColor,
                        ),
                      ),
                      SizedBox(
                        width: context.screenWidth * 0.4,
                        height: 45,
                        child: RoundButton(
                          text: "Book a Session",
                          onPressed: () {},
                          backgroundColor: AppColors.secondaryColor,
                        ),
                      )
                    ],
                  ),
                  20.heightBox,
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40, left: 14, right: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
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
                      context.pop();
                    },
                    icon: Icon(Icons.arrow_back, size: 20),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ),
              ),
              Text(
                getArtistDetails?.artistName ?? "",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Container(
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
                      context.pop();
                    },
                    icon: Icon(Icons.more_vert, size: 20),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
