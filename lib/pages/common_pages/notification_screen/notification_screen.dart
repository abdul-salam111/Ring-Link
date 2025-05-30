import 'package:flutter/material.dart';
import 'package:ring_link/utils/library.dart';
import 'package:ring_link/utils/num_txt.dart';
import 'package:ring_link/widgets/components.dart';
import 'package:ring_link/widgets/notification_buttom_sheet.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          40.heightBox,
          Stack(
            children: [
              Center(
                child: CustomAppBar(title: 'Notifications'),
              ),
              Positioned(
                right: 16,
                top: 20,
                child: Container(
                  width: context.screenWidth * 0.08,
                  height: context.screenHeight * 0.04,
                  decoration: BoxDecoration(
                    color: const Color(0xff212429),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (context) => const NotificationBottomSheet(),
                        );
                      },
                      icon: const Icon(Icons.more_vert, size: 20),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.separated(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
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
                return Divider();
              },
            ),
          )
        ],
      ),
    );
  }
}
