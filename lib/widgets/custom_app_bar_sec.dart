import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Or use Navigator.pop(context); if not using GoRouter

class CustomAppBarSec extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;
  final VoidCallback? onMore;

  const CustomAppBarSec({
    Key? key,
    required this.title,
    this.onBack,
    this.onMore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _iconButton(
          icon: Icons.arrow_back,
          onPressed: onBack ?? () => context.pop(),
        ),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        _iconButton(
          icon: Icons.more_vert,
          onPressed: onMore ?? () => context.pop(),
        ),
      ],
    );
  }

  Widget _iconButton(
      {required IconData icon, required VoidCallback onPressed}) {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        color: const Color(0xff212429),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(icon, size: 20),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ),
    );
  }
}
