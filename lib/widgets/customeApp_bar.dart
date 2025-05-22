import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ring_link/utils/context_ext.dart';
import 'package:ring_link/utils/paddings.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding20,
      child: SizedBox(
        height: 35,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Text(
                title,
                style: context.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  color: const Color(0xff212429),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: IconButton(
                    onPressed: onBack ?? () => context.pop(),
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 20,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
