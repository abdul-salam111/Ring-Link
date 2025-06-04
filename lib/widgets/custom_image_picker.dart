// image_picker_widget.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

import '../blocs/common_blocs/image_picker/image_picker_cubit.dart';

void showPicker(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (_) => SafeArea(
      child: Wrap(
        children: [
          ListTile(
            leading: Icon(Iconsax.camera5),
            title: const Text('Take Photo'),
            onTap: () {
              Navigator.pop(context);
              context.read<ImagePickerCubit>().pickImage(ImageSource.camera);
            },
          ),
          ListTile(
            leading: const Icon(Iconsax.gallery),
            title: const Text('Choose from Gallery'),
            onTap: () {
              Navigator.pop(context);
              context.read<ImagePickerCubit>().pickImage(ImageSource.gallery);
            },
          ),
        ],
      ),
    ),
  );
}
