import 'package:flutter/material.dart';

import '../utils/library.dart';



Widget appLogo({required double width, required double height}) {
  return Center(
      child: Image.asset(
    applogo,
    height: height,
    width: width,
  ));
}
