import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:iconsax/iconsax.dart';
import 'package:ring_link/routes/routes.dart';
import 'package:ring_link/services/services_manager.dart';
import 'package:ring_link/services/storage.dart';

import 'package:ring_link/utils/library.dart';
import 'package:ring_link/utils/num_txt.dart';

import 'package:ring_link/widgets/menu_widget.dart';

class TrainerMenuDrawer extends StatelessWidget {
  const TrainerMenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xff121315),
      child: Padding(
        padding: const EdgeInsets.only(left: 14),
        child: Column(
          children: [
            50.heightBox,
            Container(
              margin: padding14,
              decoration: BoxDecoration(),
              child: Row(
                children: [
                  CircleAvatar(
                      radius: 35,
                      backgroundImage: CachedNetworkImageProvider(
                        SessionController()
                                .getTrainerDetailsModel
                                .trainerProfilePicture ??
                            defaultImage,
                      )),
                  10.widthBox,
                  Column(
                    crossAxisAlignment: crossAxisStart,
                    children: [
                      Text(
                        SessionController().getTrainerDetailsModel.trainerUsername ?? "",
                        style: context.bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        SessionController().getTrainerDetailsModel.userType ?? "",
                        style: context.bodyMedium!
                            .copyWith(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            40.heightBox,
            ManuWidget(
              prefixIcon: Icon(Iconsax.user),
              title: 'Edit Profile',
              suffixIcon: Icon(Icons.arrow_forward),
              ontap: () {
                Navigator.pop(context);
                // your navigation or logic here
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Divider(
                height: 0,
              ),
            ),
            ManuWidget(
              prefixIcon: Icon(Iconsax.book),
              title: 'My Bookings',
              suffixIcon: Icon(Icons.arrow_forward),
              ontap: () {
                Navigator.pop(context);
                // your navigation or logic here
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Divider(
                height: 0,
              ),
            ),
            ManuWidget(
              prefixIcon: Icon(Icons.card_membership),
              title: 'Transactions',
              suffixIcon: Icon(Icons.arrow_forward),
              ontap: () {
                Navigator.pop(context);
                // your navigation or logic here
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Divider(
                height: 0,
              ),
            ),
            ManuWidget(
              prefixIcon: Icon(Iconsax.setting),
              title: 'Settings & Preferences',
              suffixIcon: Icon(Icons.arrow_forward),
              ontap: () {
                Navigator.pop(context);
                // your navigation or logic here
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Divider(
                height: 0,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () async {
                await firebaseAuth.signOut();
                await storage.clearValues(StorageKeys.loggedIn);
                await storage.clearValues(StorageKeys.userId);
                await storage.clearValues(StorageKeys.userType);
                await storage.clearValues(StorageKeys.artistDetails);
                await storage.clearValues(StorageKeys.trainerDetails);
                context.pushReplacementNamed(AppRouteNames.login);
              },
              child: Container(
                height: 60,
                padding: defaultPadding,
                decoration: BoxDecoration(
                  color: AppColors.buttonColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(Iconsax.logout),
                    ),
                    Center(
                      child: Text(
                        "Logout",
                        style: context.bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            40.heightBox,
          ],
        ),
      ),
    );
  }
}
