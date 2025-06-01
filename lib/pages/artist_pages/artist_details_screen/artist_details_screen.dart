import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ring_link/models/trainers/get_models/get_trainer_details_model.dart';
import 'package:ring_link/routes/routes.dart';
import 'package:ring_link/utils/library.dart';
import 'package:ring_link/utils/num_txt.dart';
import 'package:ring_link/widgets/components.dart';

class ArtistDetailsScreen extends StatelessWidget {
  final GetTrainerDetailsModel? getTrainerDetailsModel;
  const ArtistDetailsScreen({super.key, this.getTrainerDetailsModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Hero(
          tag: getTrainerDetailsModel?.trainerId ?? "",
          child: CachedNetworkImage(
              height: context.screenHeight * 0.6,
              width: double.infinity,
              fit: BoxFit.cover,
              imageUrl: getTrainerDetailsModel?.trainerProfilePicture ??
                  defaultImage),
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
                          getTrainerDetailsModel?.trainerTagline ?? "",
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
                        getTrainerDetailsModel?.trainerUsername ?? "",
                        style: context.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "\$${getTrainerDetailsModel?.trainerPrice ?? ""}",
                        style: context.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.white),
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
                            getTrainerDetailsModel?.trainerExpereince ?? "",
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
                                double.parse(
                                        getTrainerDetailsModel?.trainerRating ??
                                            "0.0")
                                    .toInt(),
                                (index) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: (context.screenWidth <= 420)
                                          ? 14
                                          : 22,
                                    )),
                          ),
                          Text(
                            "${getTrainerDetailsModel?.trainerRating}",
                            style: context.bodyMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Color(0xffBCBABA)),
                          )
                        ],
                      )
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
                    "${getTrainerDetailsModel?.trainerBio}",
                    style: context.bodyMedium,
                    textAlign: textAlignJustify,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
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
                            "${getTrainerDetailsModel?.trainerExpereince} Experience",
                            style: context.bodySmall!.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
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
                                AppRouteNames.trainerProfileScreenForArtist,
                                extra: getTrainerDetailsModel);
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
                getTrainerDetailsModel?.trainerUsername ?? "",
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
