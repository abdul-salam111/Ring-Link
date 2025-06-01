import 'package:flutter/material.dart';
import 'package:ring_link/utils/library.dart';
import 'package:ring_link/utils/num_txt.dart';
import 'package:ring_link/widgets/components.dart';

import '../../../widgets/notification_bottom_sheet.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          60.heightBox,
          Padding(
            padding: screenPadding,
            child: Center(
              child: CustomAppBarSec(title: 'Notifications',onMore: (){  showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) => const NotificationBottomSheet(),
                      );},),
            ),
          ),
          20.heightBox,
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18,vertical: 7),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: context.screenWidth * 0.085,
                        height: context.screenHeight * 0.04,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: const Color(0xff212429), width: 8),
                        ),
                        child: const Center(
                          child:
                              Icon(Icons.check, size: 13, color: Colors.black),
                        ),
                      ),
                      12.widthBox,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Payment Successful',
                                style: context.titleMedium),
                            const SizedBox(height: 4),
                            Text(
                              'Your payment of 50 for Coach John’s session on March 15, 7 PM was successful.',
                              style: context.bodyMedium!.copyWith(fontSize: 12),
                              softWrap: true,
                            ),
                            Text(
                              '7m ago',
                              style: context.bodySmall!.copyWith(fontSize: 12),
                            ),
                            10.heightBox,
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  height: 0,
                  color: AppColors.lightgreycardColor,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
