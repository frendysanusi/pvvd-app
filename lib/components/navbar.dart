import 'package:flutter/material.dart';
import 'package:pvvd_app/screens/landing_screen.dart';
import 'package:pvvd_app/screens/presence_screen.dart';
import 'package:pvvd_app/screens/profile_screen.dart';
import 'package:pvvd_app/screens/user_presence_data_screen.dart';
import 'package:pvvd_app/utils/constants.dart';

final List<String> _pages = <String>[
  LandingScreen.id,
  PresenceScreen.id,
  UserPresenceDataScreen.id,
  ProfileScreen.id,
];

class Navbar extends StatelessWidget {
  const Navbar({super.key, required this.currentIndex});
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: kSilverSand,
      elevation: 100,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      unselectedItemColor: const Color(0xFF3C3C43).withOpacity(0.6),
      selectedItemColor: kCasal,
      unselectedLabelStyle: kBR7,
      selectedLabelStyle: kBR7,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.qr_code_scanner_rounded),
          label: 'Presensi',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'Data Kehadiran',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profil',
        ),
      ],
      currentIndex: currentIndex,
      onTap: (int index) {
        Navigator.pushNamed(context, _pages[index]);
      },
    );
  }
}
