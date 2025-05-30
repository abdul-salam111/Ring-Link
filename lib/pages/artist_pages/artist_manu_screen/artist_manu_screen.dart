// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ring_link/utils/num_txt.dart';
import 'package:ring_link/widgets/customeApp_bar.dart';
import 'package:ring_link/widgets/manu_widget.dart';

class ArtistManuScreen extends StatelessWidget {
  const ArtistManuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          40.heightBox,
          CustomAppBar(
            title: 'Menu',
          ),
          ManuWidget(
            prefixIcon: Icon(Icons.person),
            title: 'Edit Profile',
            suffixIcon: Icon(Icons.arrow_forward),
            ontap: () {},
          ),
          ManuWidget(
            prefixIcon: Icon(Icons.event_available),
            title: 'My Bookings',
            suffixIcon: Icon(Icons.arrow_forward),
            ontap: () {},
          ),
          ManuWidget(
            prefixIcon: Icon(Icons.monetization_on_outlined),
            title: 'Transactions',
            suffixIcon: Icon(Icons.arrow_forward),
            ontap: () {},
          ),
          ManuWidget(
            prefixIcon: Icon(Icons.payment_sharp),
            title: 'add payment method',
            suffixIcon: Icon(Icons.arrow_forward),
            ontap: () {},
          ),
          ManuWidget(
            prefixIcon: Icon(Icons.history),
            title: 'Training History',
            suffixIcon: Icon(Icons.arrow_forward),
            ontap: () {},
          ),
          ManuWidget(
            prefixIcon: Icon(Icons.check_box_rounded),
            title: 'Availability',
            suffixIcon: Icon(Icons.arrow_forward),
            ontap: () {},
          ),
          ManuWidget(
            prefixIcon: Icon(Icons.settings),
            title: 'Settings & Preferences',
            suffixIcon: Icon(Icons.arrow_forward),
            ontap: () {},
          ),
          ManuWidget(
            prefixIcon: Icon(Icons.logout_sharp),
            title: ' Log Out',
            suffixIcon: Icon(Icons.arrow_forward),
            ontap: () {
              context.go('/artistProfileScreen');
            },
          ),
        ],
      ),
    );
  }
}
