import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ring_link/utils/library.dart';
import 'package:ring_link/utils/num_txt.dart';
import 'package:ring_link/widgets/components.dart';

class TrainerProfileHeaderCard extends StatelessWidget {
  final bool isTrainerProfile;
  final String profilePic;
  final String name;
  final String subtitle;
  final double rating;
  final String location;
  final String experience;
  final VoidCallback onShare;
  final VoidCallback onFeedback;
  final VoidCallback onpress;
  final String? price;
  final String screenTitle;
  final String mainButtonText;

  const TrainerProfileHeaderCard(
      {super.key,
      this.isTrainerProfile = false,
      required this.profilePic,
      required this.name,
      required this.subtitle,
      required this.onpress,
      this.price,
      required this.rating,
      required this.location,
      required this.experience,
      required this.onShare,
      required this.onFeedback,
      required this.screenTitle,
      required this.mainButtonText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.withAlpha((0.03 * 255).toInt()),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Padding(
        padding: screenPadding,
        child: Column(
          children: [
            50.heightBox,
            CustomAppBarSec(
              title: screenTitle,
            ),
            20.heightBox,
            Row(
              crossAxisAlignment: crossAxisCenter,
              children: [
                CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(profilePic),
                  radius: 30,
                ),
                10.widthBox,
                Column(
                  crossAxisAlignment: crossAxisStart,
                  children: [
                    5.heightBox,
                    Text(
                      name,
                      style: context.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    3.heightBox,
                    Text(
                      subtitle,
                      style: context.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                if (isTrainerProfile)
                  Text(
                    "\$$price",
                    style: context.headlineSmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  )
              ],
            ),
            10.heightBox,
            Row(
              mainAxisAlignment: !isTrainerProfile
                  ? mainAxisStart
                  : MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/icons/setting.png",
                      height: context.screenWidth <= 420 ? 20 : 30,
                      width: context.screenWidth <= 420 ? 20 : 30,
                    ),
                    5.widthBox,
                    Text(
                      experience,
                      style: context.bodyLarge!.copyWith(
                        fontSize: context.screenWidth <= 420 ? 14 : 16,
                      ),
                    ),
                  ],
                ),
                if (!isTrainerProfile) 20.widthBox,
                Row(
                  children: [
                    Image.asset(
                      "assets/icons/location.png",
                      height: context.screenWidth <= 420 ? 14 : 20,
                      width: context.screenWidth <= 420 ? 14 : 20,
                    ),
                    5.widthBox,
                    Text(
                      location,
                      style: context.bodyLarge!.copyWith(
                        fontSize: context.screenWidth <= 420 ? 14 : 16,
                      ),
                    ),
                  ],
                ),
                if (isTrainerProfile)
                  Row(
                    children: [
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: context.screenWidth <= 420 ? 14 : 22,
                          ),
                        ),
                      ),
                      Text(
                        "$rating",
                        style: context.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xffBCBABA),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            20.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      onPressed: onFeedback,
                      icon: const Icon(Iconsax.message_text, size: 20),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ),
                ),
                SizedBox(
                  width: context.screenWidth * 0.5,
                  height: 45,
                  child: RoundButton(
                    text: mainButtonText,
                    onPressed: onpress,
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
                      onPressed: onShare,
                      icon: const Icon(Iconsax.share, size: 20),
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
    );
  }
}
