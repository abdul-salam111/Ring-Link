// ignore_for_file: must_be_immutable, camel_case_types

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ring_link/utils/library.dart';
import 'package:ring_link/utils/num_txt.dart';
import 'package:ring_link/widgets/custom_app_bar_sec.dart';

class ArtistProfileScreen extends StatelessWidget {
  const ArtistProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 50, horizontal: 10),
              decoration: BoxDecoration(
                  color: Color(0xff151820),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40))),
              height: context.screenHeight * 0.43,
              width: double.infinity,
              child: Column(
                children: [
                  CustomAppBarSec(
                    title: 'My Profile',
                  ),
                  Padding(
                    padding: padding24,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 37,
                          child: ClipOval(
                            child: SizedBox(
                              height: context.screenHeight * 0.085,
                              width: context.screenWidth * 0.19,
                              child: CachedNetworkImage(
                                  imageUrl:
                                      'https://img.freepik.com/free-photo/fighter-close-up-portrait-before-fight_158595-4875.jpg?uid=R192399862&ga=GA1.1.71047897.1748551397&semt=ais_hybrid&w=740',
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        Padding(
                          padding: padding14,
                          child: Column(
                            crossAxisAlignment: crossAxisStart,
                            children: [
                              Text(
                                'Stephanie Nicol',
                                style: context.titleMedium,
                              ),
                              Text(
                                'Lightweight',
                                style: context.bodySmall,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.person,
                              size: 17,
                            ),
                            5.widthBox,
                            Text(
                              'Beginner',
                              style: context.bodySmall,
                            ),
                          ],
                        ),
                        30.widthBox,
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 17,
                            ),
                            5.widthBox,
                            Text(
                              'Brazilian',
                              style: context.bodySmall,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  40.heightBox,
                  Container(
                    width: context.screenWidth * 0.394,
                    height: context.screenHeight * 0.055,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(40)),
                    child: Row(
                      mainAxisAlignment: mainAxisCenter,
                      children: [
                        Icon(Icons.edit),
                        10.widthBox,
                        Text(
                          'Edit Profile',
                          style: context.bodySmall,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            30.heightBox,
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: mainAxisSpaceBetween,
                      children: [
                        Text(
                          'Short Bio',
                          style: context.titleMedium,
                        ),
                        Icon(Icons.edit),
                      ],
                    ),
                    10.heightBox,
                    Text(
                      'Dedicated MMA fighter with 3 years of experience in Muay Thai and BJJ. Passionate about refining my takedown defense and striking accuracy.',
                      style: context.bodySmall!.copyWith(fontSize: 12),
                    ),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: mainAxisSpaceBetween,
                      children: [
                        Text(
                          'Training Goals',
                          style: context.titleMedium,
                        ),
                        Icon(Icons.edit),
                      ],
                    ),
                    10.heightBox,
                    Text(
                      'Improving my wrestling for upcoming amateur fights',
                      style: context.bodySmall!.copyWith(fontSize: 12),
                    ),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: mainAxisSpaceBetween,
                      children: [
                        Text(
                          ' Preferred Training Type',
                          style: context.titleMedium,
                        ),
                        Icon(Icons.edit),
                      ],
                    ),
                    20.heightBox,
                    Row(
                      children: [
                        training_widget(
                          title: '1-on-1 Sessions',
                        ),
                        10.widthBox,
                        training_widget(
                          title: ' Sparring Partner',
                        )
                      ],
                    ),
                    10.heightBox,
                    Row(
                      children: [
                        training_widget(
                          title: 'Virtual Coaching',
                        ),
                        10.widthBox,
                        training_widget(
                          title: 'Group Training',
                        )
                      ],
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

class training_widget extends StatelessWidget {
  String title;
  training_widget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth * 0.35,
      height: context.screenHeight * 0.05,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 0.4),
          borderRadius: BorderRadius.circular(14)),
      child: Center(
          child: Text(
        title,
        style: context.bodyMedium!.copyWith(fontSize: 12),
      )),
    );
  }
}
