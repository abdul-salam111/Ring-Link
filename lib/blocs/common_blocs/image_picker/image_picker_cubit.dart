// image_picker_cubit.dart

import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class ImagePickerCubit extends Cubit<File?> {
  final ImagePicker _picker = ImagePicker();

  ImagePickerCubit() : super(null);

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        emit(File(pickedFile.path));
      }
    } catch (e) {
      debugPrint("Image picking error: $e");
    }
  }

  void clearImage() {
    emit(null);
  }
}


 