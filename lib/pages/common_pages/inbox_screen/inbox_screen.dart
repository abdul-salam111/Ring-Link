import 'package:flutter/material.dart';
import 'package:ring_link/utils/num_txt.dart';
import 'package:ring_link/utils/paddings.dart';

import '../../../widgets/components.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: screenPadding,
        child: Column(
          children: [
            40.heightBox,
            CustomAppBarSec(
              title: 'Inbox',
            ),
          ],
        ),
      ),
    );
  }
}
