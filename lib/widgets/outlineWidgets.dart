import 'package:flutter/material.dart';

class OutlinedButtonWidget extends StatelessWidget {
  final String title;

  const OutlinedButtonWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          side:
              const BorderSide(color: Color(0xFFBDBDBD)), // AppColors.lightGrey
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
