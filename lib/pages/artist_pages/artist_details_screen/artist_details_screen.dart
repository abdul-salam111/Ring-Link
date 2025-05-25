import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ring_link/utils/library.dart';
import 'package:ring_link/utils/num_txt.dart';
import 'package:ring_link/widgets/components.dart';

class ArtistDetailsScreen extends StatelessWidget {
  const ArtistDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        CachedNetworkImage(
            height: context.screenHeight * 0.6,
            width: double.infinity,
            fit: BoxFit.cover,
            imageUrl:
                "https://img.freepik.com/premium-photo/young-man-isolated-blue_1368-124991.jpg?semt=ais_hybrid&w=740"),
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
                    padding: padding5,
                    width: context.screenWidth * 0.3,
                    alignment: topLeft,
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
                          "Jiu, Jitsu",
                          style: context.bodyLarge!.copyWith(
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
                        "Stephanie Nicol",
                        style: context.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "\$50/Hr",
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
                  15.heightBox,
                  Text(
                    "Short Bio",
                    style: context.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  10.heightBox,
                  Text(
                    "Meet Stephanie Nico With over 6 years of experience in [MMA specialization], [Trainer Name] has trained fighters from beginners to pros, helping them sharpen their skills and build confidence inside the cage.",
                    style: context.bodyMedium,
                    textAlign: textAlignJustify,
                    maxLines: 2,
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
                  20.heightBox,
                  Row(
                    mainAxisAlignment: mainAxisSpaceBetween,
                    children: [
                      SizedBox(
                        width: context.screenWidth * 0.4,
                        height: 45,
                        child: RoundButton(
                          text: "View Profile",
                          onPressed: () {},
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
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }
}
