import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ring_link/blocs/artist_blocs/artist_edit_profile/bloc/artist_edit_profile_bloc.dart';
import 'package:ring_link/blocs/common_blocs/image_picker/image_picker_cubit.dart';
import 'package:ring_link/main.dart';
import 'package:ring_link/services/services_manager.dart';
import 'package:ring_link/utils/enums.dart';
import 'package:ring_link/utils/library.dart';
import 'package:ring_link/utils/num_txt.dart';
import 'package:ring_link/widgets/components.dart';
import 'package:ring_link/widgets/custom_image_picker.dart';
import 'package:ring_link/widgets/outlineWidgets.dart';

class ArtistEditProfile extends StatefulWidget {
  const ArtistEditProfile({super.key});

  @override
  State<ArtistEditProfile> createState() => _ArtistEditProfileState();
}

class _ArtistEditProfileState extends State<ArtistEditProfile> {
  late ArtistEditProfileBloc artistEditProfileBloc;
  final expertiesLevels = {"Beginner", "Intermediate", "Advanced"};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    artistEditProfileBloc = ArtistEditProfileBloc(getIt());
    artistEditProfileBloc.add(LoadMyProfileDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.focusScope.unfocus();
      },
      child: Scaffold(
        body: BlocProvider(
          create: (context) => artistEditProfileBloc,
          child: SingleChildScrollView(
            child: Padding(
              padding: screenPadding,
              child: Column(
                crossAxisAlignment: crossAxisStart,
                children: [
                  50.heightBox,
                  CustomAppBarSec(title: "Edit Profile"),
                  20.heightBox,
                  Center(
                    child: BlocProvider(
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
                                file?.path != null
                                    ? CircleAvatar(
                                        radius: 55,
                                        backgroundImage: FileImage(file!))
                                    : SessionController()
                                                .getArtistDetails
                                                .artistProfileImage !=
                                            null
                                        ? CircleAvatar(
                                            radius: 55,
                                            backgroundImage:
                                                CachedNetworkImageProvider(
                                                    SessionController()
                                                            .getArtistDetails
                                                            .artistProfileImage ??
                                                        defaultImage))
                                        : CircleAvatar(
                                            radius: 55,
                                            backgroundImage:
                                                CachedNetworkImageProvider(
                                                    SessionController()
                                                            .getArtistDetails
                                                            .artistProfileImage ??
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
                    ),
                  ),
                  10.heightBox,
                  Center(
                    child: Text(
                      SessionController().getArtistDetails.artistName ?? "",
                      style: context.bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Center(
                    child: Text(
                      SessionController().getArtistDetails.artistEmail ?? "",
                      style: context.displayLarge,
                    ),
                  ),
                  20.heightBox,
                  BlocBuilder<ArtistEditProfileBloc, ArtistEditProfileState>(
                    buildWhen: (previous, current) =>
                        previous.artistName != current.artistName,
                    builder: (context, state) {
                      return CustomTextFormField(
                        borderRadius: 10,
                        onChanged: (username) {
                          artistEditProfileBloc.add(UpdateArtistName(username));
                        },
                        prefixIcon: Iconsax.user,
                        hintText: state.artistName.isNotEmpty
                            ? state.artistName
                            : "Enter your Username here...",
                        borderColor: AppColors.lightGrey,
                      );
                    },
                  ),
                  20.heightBox,
                  BlocBuilder<ArtistEditProfileBloc, ArtistEditProfileState>(
                    buildWhen: (previous, current) =>
                        previous.artistTagline != current.artistTagline,
                    builder: (context, state) {
                      return CustomTextFormField(
                        borderRadius: 10,
                        onChanged: (usertagline) {
                          artistEditProfileBloc
                              .add(UpdateArtistTagline(usertagline));
                        },
                        prefixIcon: Iconsax.tag,
                        hintText: state.artistTagline.isNotEmpty
                            ? state.artistTagline
                            : "Enter your tagline here...",
                        borderColor: AppColors.lightGrey,
                      );
                    },
                  ),
                  20.heightBox,
                  BlocBuilder<ArtistEditProfileBloc, ArtistEditProfileState>(
                    buildWhen: (previous, current) =>
                        previous.artistBio != current.artistBio,
                    builder: (context, state) {
                      return CustomTextFormField(
                        borderRadius: 10,
                        maxLines: 3,
                        onChanged: (artistBio) {
                          artistEditProfileBloc.add(UpdateArtistBio(artistBio));
                        },
                        hintText: state.artistBio.isNotEmpty
                            ? state.artistBio
                            : "Enter your bio here...",
                        borderColor: AppColors.lightGrey,
                      );
                    },
                  ),
                  20.heightBox,
                  Text(
                    "Experience Level",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white),
                  ),
                  10.heightBox,
                  BlocBuilder<ArtistEditProfileBloc, ArtistEditProfileState>(
                    buildWhen: (previous, current) =>
                        previous.selectedExperienceLevel !=
                        current.selectedExperienceLevel,
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: expertiesLevels.map((entry) {
                          final isSelected =
                              state.selectedExperienceLevel == entry;
                          return GestureDetector(
                            onTap: () => context
                                .read<ArtistEditProfileBloc>()
                                .add(SelectExperienceLevel(entry)),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.white24),
                                    color: Colors.transparent,
                                  ),
                                  width: 20,
                                  height: 20,
                                  child: isSelected
                                      ? Center(
                                          child: Icon(Icons.check,
                                              color: Colors.white60, size: 15),
                                        )
                                      : null,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  entry,
                                  style: context.bodyMedium!.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                                const SizedBox(width: 5),
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                  20.heightBox,
                  BlocBuilder<ArtistEditProfileBloc, ArtistEditProfileState>(
                    buildWhen: (previous, current) =>
                        previous.artistTrainingGoal !=
                        current.artistTrainingGoal,
                    builder: (context, state) {
                      return CustomTextFormField(
                        borderRadius: 10,
                        maxLines: 2,
                        onChanged: (goal) {
                          artistEditProfileBloc
                              .add(UpdateArtistTrainingGoal(goal));
                        },
                        hintText: state.artistTrainingGoal.isNotEmpty
                            ? state.artistTrainingGoal
                            : "What's your training goal...",
                        borderColor: AppColors.lightGrey,
                      );
                    },
                  ),
                  20.heightBox,
                  // Text(
                  //   "Training History",
                  //   style: Theme.of(context)
                  //       .textTheme
                  //       .bodyLarge!
                  //       .copyWith(color: Colors.white),
                  // ),
                  // BlocBuilder<ArtistEditProfileBloc, ArtistEditProfileState>(
                  //   buildWhen: (previous, current) =>
                  //       previous.artistTrainingHistory !=
                  //       current.artistTrainingHistory,
                  //   builder: (context, state) {
                  //     return state.artistTrainingHistory.isEmpty
                  //         ? Center(
                  //             child: Padding(
                  //                 padding: EdgeInsets.symmetric(vertical: 20),
                  //                 child: SizedBox(
                  //                     height: 40,
                  //                     width: context.screenWidth * 0.4,
                  //                     child: RoundButton(
                  //                       backgroundColor: AppColors.buttonColor,
                  //                       text: "Add History",
                  //                       onPressed: () {},
                  //                       radius: 5,
                  //                     ))),
                  //           )
                  //         : SizedBox(
                  //             height: context.screenHeight * 0.2,
                  //             child: ListView.builder(
                  //                 itemCount: state.artistTrainingHistory.length,
                  //                 itemBuilder: (context, index) {
                  //                   return ListTile(
                  //                     leading: Image.asset(applogo),
                  //                     title: Text(state
                  //                             .artistTrainingHistory[index]
                  //                             .trainingTitle ??
                  //                         ""),
                  //                   );
                  //                 }),
                  //           );
                  //   },
                  // )
                  Text(
                    "Preferred Training Type",
                    style: context.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),

                  BlocBuilder<ArtistEditProfileBloc, ArtistEditProfileState>(
                    builder: (context, state) {
                      if (state.artistPreferredSessionType.isEmpty) {
                        PopupMenuButton<String>(
                          padding: EdgeInsets.zero,
                          icon: Icon(Icons.add, color: Colors.white),
                          color: Colors.white, // Popup background color
                          onSelected: (value) {
                            context.read<ArtistEditProfileBloc>().add(
                                  UpdatePreferredSessionTypes(value),
                                );
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: "One to One",
                              child: Text(
                                "One to One",
                                style: context.bodyMedium!
                                    .copyWith(color: Colors.black),
                              ),
                            ),
                            PopupMenuItem(
                              value: "Group",
                              child: Text(
                                "Group",
                                style: context.bodyMedium!
                                    .copyWith(color: Colors.black),
                              ),
                            ),
                            PopupMenuItem(
                              value: "Virtual",
                              child: Text(
                                "Virtual",
                                style: context.bodyMedium!
                                    .copyWith(color: Colors.black),
                              ),
                            ),
                          ],
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Wrap(
                          spacing: 5,
                          runSpacing: 5,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            ...List.generate(
                                state.artistPreferredSessionType.length,
                                (index) {
                              return Stack(
                                alignment: topRight,
                                children: [
                                  OutlinedButtonWidget(
                                    title:
                                        state.artistPreferredSessionType[index],
                                  ),
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    child: Center(
                                      child: IconButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                            artistEditProfileBloc.add(
                                                RemoveFromPrefferedSessionTypeEvent(
                                                    state.artistPreferredSessionType[
                                                        index]));
                                          },
                                          icon: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 15,
                                          )),
                                    ),
                                  )
                                ],
                              );
                            }),
                            PopupMenuButton<String>(
                              padding: EdgeInsets.zero,
                              icon: Icon(Icons.add, color: Colors.white),
                              color: Colors.white, // Popup background color
                              onSelected: (value) {
                                context.read<ArtistEditProfileBloc>().add(
                                      UpdatePreferredSessionTypes(value),
                                    );
                              },
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  value: "One to One",
                                  child: Text(
                                    "One to One",
                                    style: context.bodyMedium!
                                        .copyWith(color: Colors.black),
                                  ),
                                ),
                                PopupMenuItem(
                                  value: "Group",
                                  child: Text(
                                    "Group",
                                    style: context.bodyMedium!
                                        .copyWith(color: Colors.black),
                                  ),
                                ),
                                PopupMenuItem(
                                  value: "Virtual",
                                  child: Text(
                                    "Virtual",
                                    style: context.bodyMedium!
                                        .copyWith(color: Colors.black),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  20.heightBox,
                  BlocListener<ArtistEditProfileBloc, ArtistEditProfileState>(
                    listener: (context, state) {
                      switch (state.apiStatus) {
                        case ApiStatus.success:
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text('Success'),
                              content:
                                  const Text('Profile updated successfully.'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                          break;

                        case ApiStatus.error:
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text('Error'),
                              content: Text(state.message),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                          break;

                        default:
                          break;
                      }
                    },
                    child: BlocBuilder<ArtistEditProfileBloc,
                        ArtistEditProfileState>(
                      builder: (context, state) {
                        return Center(
                          child: SizedBox(
                            width: context.screenWidth * 0.6,
                            height: 45,
                            child: RoundButton(
                              backgroundColor: AppColors.buttonColor,
                              isLoading: state.apiStatus == ApiStatus.loading,
                              text: "Update Profile",
                              onPressed: () {
                                context
                                    .read<ArtistEditProfileBloc>()
                                    .add(UpdateArtistProfile());
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  30.heightBox,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
