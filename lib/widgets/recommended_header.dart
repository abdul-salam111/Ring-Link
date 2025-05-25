import 'package:flutter/material.dart';

class RecommendedHeader extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAllTap;

  const RecommendedHeader({
    super.key,
    required this.title,
    required this.onSeeAllTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        GestureDetector(
          onTap: onSeeAllTap,
          child: Text(
            "See All",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.normal, fontSize: 14),
          ),
        ),
      ],
    );
  }
}
