import 'package:flutter/material.dart';
import '../utils/library.dart';
import 'round_button.dart';

class DeletePopup extends StatelessWidget {
  final String icon;
  final String title;
  final String message;
  final VoidCallback onConfirm;

  const DeletePopup({
    super.key,
    required this.title,
    required this.message,
    required this.onConfirm,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: padding20,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              icon,
              height: context.screenHeight * 0.2,
              width: context.screenWidth * 0.3,
            ),
            Text(
              title,
              style: context.titleSmall!.copyWith(
                  fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red),
              textAlign: TextAlign.center,
            ),
            Text(
              message,
              style: context.bodySmall!.copyWith(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            Row(
              children: [
                Expanded(
                    child: SizedBox(
                  height: 40,
                  child: Center(
                    child: Text(
                      "Back",
                      style: context.bodySmall,
                    ),
                  ),
                )),
                Expanded(
                  child: RoundButton(
                    text: "Ok",
                    onPressed: onConfirm,
                    radius: 5,
                    backgroundColor: AppColors.errorColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
