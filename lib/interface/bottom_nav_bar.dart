// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rxconnect/constants/theme.dart';
import 'package:rxconnect/pages/home_page.dart';
import 'package:rxconnect/pages/medication_page.dart';
// import 'package:rxconnect/pages/profile_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;

  final screens = [
    const HomePage(),
    const MedicationPage(),
    // const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: rblack.withOpacity(0.3),
              width: 0.15,
            ),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: rwhite,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          iconSize: 18,
          currentIndex: currentIndex,
          selectedLabelStyle: const TextStyle(
            color: rgreen,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            height: 1.5,
          ),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          unselectedItemColor: rblack.withOpacity(0.3),
          selectedItemColor: rgreen,
          unselectedLabelStyle: TextStyle(
            color: rblack.withOpacity(0.3),
            fontSize: 12,
            fontWeight: FontWeight.w600,
            height: 1.5,
          ),
          onTap: (index) => setState(() => currentIndex = index),
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.network(
                'https://www.svgrepo.com/show/524643/home-angle-2.svg',
                color: rblack.withOpacity(0.4),
              ),
              activeIcon: SvgPicture.network(
                'https://www.svgrepo.com/show/524643/home-angle-2.svg',
                color: rgreen,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.network(
                'https://www.svgrepo.com/show/376659/script-prescription-line.svg',
                color: rblack.withOpacity(0.4),
              ),
              activeIcon: SvgPicture.network(
                'https://www.svgrepo.com/show/376659/script-prescription-line.svg',
                color: rgreen,
              ),
              label: 'Medications',
            ),
            // BottomNavigationBarItem(
            //   icon: SvgPicture.network(
            //     'https://www.svgrepo.com/show/498298/profile.svg',
            //     color: rblack.withOpacity(0.4),
            //   ),
            //   activeIcon: SvgPicture.network(
            //     'https://www.svgrepo.com/show/498298/profile.svg',
            //     color: rgreen,
            //   ),
            //   label: 'Profile',
            // ),
          ],
        ),
      ),
    );
  }
}
