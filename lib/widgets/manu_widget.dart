import 'package:flutter/material.dart';
import 'package:ring_link/utils/colors.dart';
import 'package:ring_link/utils/context_ext.dart';
import 'package:ring_link/utils/num_txt.dart';
import 'package:ring_link/utils/paddings.dart';

class ManuWidget extends StatelessWidget {
  final Widget prefixIcon;
  final String title;
  final Widget suffixIcon;
  final VoidCallback ontap;
  const ManuWidget({
    super.key,
    required this.prefixIcon,
    required this.title,
    required this.suffixIcon,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: padding14,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: context.screenHeight * 0.06,
        decoration: BoxDecoration(
            border: Border.all(width: 0.2, color: AppColors.halfwhiteColor),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            prefixIcon,
            30.widthBox,
            Text(
              title,
              style: context.bodyMedium,
            ),
            Spacer(),
            suffixIcon
          ],
        ),
      ),
    );
  }
}
