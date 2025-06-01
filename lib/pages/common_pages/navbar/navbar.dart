import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:iconsax/iconsax.dart';
import 'package:ring_link/blocs/common_blocs/navbarBloc/bloc/navbar_bloc.dart';
import 'package:ring_link/pages/artist_pages/artist_home_screen/artist_home_screen.dart';
import 'package:ring_link/pages/artist_pages/artist_profile/artist_profile.dart';
import 'package:ring_link/pages/common_pages/booking_screen/booking_screen.dart';
import 'package:ring_link/pages/common_pages/inbox_screen/inbox_screen.dart';
import 'package:ring_link/pages/common_pages/search_screen/search_screen.dart';
import 'package:ring_link/pages/trainer_pages/trainer_home_screen/trainer_home_screen.dart';
import 'package:ring_link/pages/trainer_pages/trainer_profile_screen/trainer_profile.dart';

import 'package:ring_link/utils/colors.dart';
import 'package:ring_link/utils/library.dart';

class NavBar extends StatefulWidget {
  final bool isArtist;
  const NavBar({super.key, required this.isArtist});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late NavbarBloc navBarBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navBarBloc = NavbarBloc();
  }

  List<Widget> artistScreens = [
    ArtistHomeScreen(),
    SearchScreen(),
    BookingScreen(),
    InboxScreen(),
    ArtistProfile(),

  ];
  List<Widget> trainerScreens = [
    TrainerHomeScreen(),
    SearchScreen(),
    BookingScreen(),
    InboxScreen(),
    TrainerProfile()
   
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => navBarBloc,
      child: Scaffold(
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BlocBuilder<NavbarBloc, NavbarState>(
            buildWhen: (previous, current) =>
                previous.currentIndex != current.currentIndex,
            builder: (context, state) {
              return SizedBox(
                height: Platform.isIOS ? 100 : 70,
                child: BottomNavigationBar(
                  backgroundColor: AppColors.lightgreycardColor,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Iconsax.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Iconsax.search_favorite),
                      label: 'Search',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Iconsax.book),
                      label: 'Booking',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Iconsax.message),
                      label: 'Messages',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Iconsax.user),
                      label: 'Profile',
                    ),
                  ],
                  currentIndex: state.currentIndex,
                  onTap: (index) {
                    navBarBloc.add(NavbarIndexChanged(index));
                  },
                  unselectedFontSize: 14,
                  selectedFontSize: 14,
                  selectedItemColor: AppColors.primaryColor,
                  unselectedItemColor: Color(0xffBCBABA),
                  showUnselectedLabels: true,
                  type: BottomNavigationBarType.fixed,
                ),
              );
            },
          ),
        ),
        body: BlocBuilder<NavbarBloc, NavbarState>(
          builder: (context, state) {
            return widget.isArtist
                ? artistScreens.asMap().containsKey(state.currentIndex)
                    ? artistScreens[state.currentIndex]
                    : Center(child: Text("Invalid index"))
                : trainerScreens.asMap().containsKey(state.currentIndex)
                    ? trainerScreens[state.currentIndex]
                    : Center(child: Text("Invalid index"));
          },
        ),
      ),
    );
  }
}
