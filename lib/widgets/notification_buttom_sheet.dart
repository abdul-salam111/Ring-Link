import 'package:flutter/material.dart';
import 'package:ring_link/utils/context_ext.dart';

class NotificationBottomSheet extends StatelessWidget {
  const NotificationBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF121212),
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: context.screenWidth * 0.15,
            height: context.screenHeight * 0.003,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white38,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          ListTile(
            leading:
                const Icon(Icons.mark_email_read_outlined, color: Colors.white),
            title: Text(
              "Mark All As Read",
              style: context.titleMedium,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
