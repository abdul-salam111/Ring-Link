import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ring_link/routes/routes.dart';
import 'package:ring_link/utils/library.dart';
import 'package:ring_link/utils/num_txt.dart';

import '../../../widgets/components.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: screenPadding,
        child: Column(
          children: [
            50.heightBox,
            CustomAppBarSec(
              title: 'Inbox',
            ),
            12.heightBox,
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: 17,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        context.pushNamed(AppRouteNames.messagesScreen);
                      },
                      child: Container(
                        decoration: BoxDecoration(),
                        child: Column(children: [
                          Row(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    height: 47,
                                    width: 47,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUbxBmNuEWRnSeavusNsXAJQY-tSNCA7Qr_A&s',
                                            ),
                                            fit: BoxFit.cover)),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    right: 2,
                                    child: Container(
                                      width: 14,
                                      height: 14,
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: Colors.white, width: 2.5),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Column(
                                        crossAxisAlignment: crossAxisStart,
                                        children: [
                                          Text("Charis Glasser",
                                              style: context.titleMedium!
                                                  .copyWith(fontSize: 14)),
                                          4.heightBox,
                                          Text("Hello are you home!",
                                              style: context.bodySmall!
                                                  .copyWith(
                                                      color: Colors.grey,
                                                      fontSize: 13)),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: crossAxisEnd,
                                mainAxisAlignment: mainAxisCenter,
                                children: [
                                  Text("5 min",
                                      style: context.bodySmall!
                                          .copyWith(fontSize: 13)),
                                  5.heightBox,
                                  Icon(
                                    Icons.done_all,
                                    size: 20,
                                    color: Colors.green,
                                  )
                                ],
                              )
                            ],
                          ),
                          10.heightBox,
                          Divider(
                            color: Colors.grey.shade800,
                          ),
                        ]),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
