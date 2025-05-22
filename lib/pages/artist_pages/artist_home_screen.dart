import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ring_link/utils/library.dart';
import 'package:ring_link/utils/num_txt.dart';

class ArtistHomeScreen extends StatelessWidget {
  const ArtistHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.focusScope.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: screenPadding,
            child: Column(
              children: [
                10.heightBox,
                Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundImage: NetworkImage(
                          "https://img.freepik.com/premium-photo/young-man-isolated-blue_1368-124991.jpg?semt=ais_hybrid&w=740"),
                    ),
                    10.widthBox,
                    Column(
                      mainAxisAlignment: mainAxisCenter,
                      crossAxisAlignment: crossAxisStart,
                      children: [
                        Text(
                          "Welcome, Back!",
                          style: context.bodyLarge,
                        ),
                        Text(
                          "Ready to level up your training",
                          style: context.displayLarge,
                        )
                      ],
                    ),
                    Spacer(),
                    Container(
                        decoration: BoxDecoration(
                            color: AppColors.lightgreycardColor,
                            borderRadius: BorderRadius.circular(50)),
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Iconsax.notification5,
                              color: Colors.white,
                            )))
                  ],
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
                    Container(
                      height: 55,
                      width: 55,
                      padding: defaultPadding,
                      decoration: BoxDecoration(
                          color: AppColors.lightgreycardColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(child: Icon(Iconsax.filter)),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
