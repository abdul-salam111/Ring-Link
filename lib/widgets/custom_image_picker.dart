// image_picker_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:image_picker/image_picker.dart';
import 'package:ring_link/blocs/artist_blocs/artist_edit_profile/bloc/artist_edit_profile_bloc.dart';

import '../blocs/common_blocs/image_picker/image_picker_cubit.dart';

void showPicker(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (_) {
      return SafeArea(
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Photo Library'),
              onTap: () async {
                final cubit = context.read<ImagePickerCubit>();
                await cubit.pickImage(ImageSource.gallery);
                final pickedFile = cubit.state;
                if (pickedFile != null) {
                  context
                      .read<ArtistEditProfileBloc>()
                      .add(UpdateArtistProfilePicture(pickedFile.path));
                }
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Camera'),
              onTap: () async {
                final cubit = context.read<ImagePickerCubit>();
                await cubit.pickImage(ImageSource.camera);
                final pickedFile = cubit.state;
                if (pickedFile != null) {
                  context
                      .read<ArtistEditProfileBloc>()
                      .add(UpdateArtistProfilePicture(pickedFile.path));
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
  );
}
