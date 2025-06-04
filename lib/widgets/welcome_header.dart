import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:iconsax/iconsax.dart';

import 'package:ring_link/utils/num_txt.dart';

import '../utils/library.dart'; // adjust path as needed

class WelcomeHeader extends StatelessWidget {
  final String subtitle;
  final String imageUrl;
  final VoidCallback onNotificationTap;

  const WelcomeHeader({
    super.key,
    required this.subtitle,
    required this.imageUrl,
    required this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundImage: CachedNetworkImageProvider(imageUrl),
        ),
        10.widthBox,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome, Back!",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.white),
            ),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ],
        ),
        const Spacer(),
        Container(
          decoration: BoxDecoration(
            color: AppColors.lightgreycardColor,
            borderRadius: BorderRadius.circular(50),
          ),
          child: IconButton(
            onPressed: onNotificationTap,
            icon: const Icon(
              Iconsax.notification5,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
