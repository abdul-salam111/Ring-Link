import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ring_link/blocs/common_blocs/image_picker/image_picker_cubit.dart';
import 'package:ring_link/services/services_manager.dart';
import 'package:ring_link/utils/library.dart';
import 'package:ring_link/utils/num_txt.dart';
import 'package:ring_link/widgets/components.dart';
import 'package:ring_link/widgets/custom_image_picker.dart';

class ArtistEditProfile extends StatefulWidget {
  const ArtistEditProfile({super.key});

  @override
  State<ArtistEditProfile> createState() => _ArtistEditProfileState();
}

class _ArtistEditProfileState extends State<ArtistEditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: screenPadding,
        child: Column(
          children: [
            50.heightBox,
            CustomAppBarSec(title: "Edit Profile"),
            20.heightBox,
            BlocProvider(
              create: (context) => ImagePickerCubit(),
              child: BlocBuilder<ImagePickerCubit, File?>(
                builder: (context, file) {
                  return GestureDetector(
                    onTap: () {
                      showPicker(context);
                    },
                    child: Stack(
                      alignment: bottomRight,
                      children: [
                        CircleAvatar(
                            radius: 55,
                            backgroundImage: CachedNetworkImageProvider(
                                SessionController()
                                        .getArtistDetails
                                        .artistProfileImage ?? file?.path??
                                    defaultImage)),
                        Positioned(
                            right: 10,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 12,
                              child: Icon(
                                Iconsax.camera5,
                                color: AppColors.lightgreycardColor,
                                size: 18,
                              ),
                            ))
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
