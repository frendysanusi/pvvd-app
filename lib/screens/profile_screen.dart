import 'package:flutter/material.dart';
import 'package:pvvd_app/components/components.dart';
import 'package:pvvd_app/utils/constants.dart';

class ProfileScreen extends StatelessWidget{
  const ProfileScreen({super.key});
  static String id = 'profile_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const BackButton(
          color: Colors.white,
        ),
        title: Image.asset(
            'assets/images/logo_pvvd.png',
            width: 40,
            height: 40,
            fit: BoxFit.fill,
          ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
            height: 141,
          ),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/logo_pvvd.png',
              width: 40,
              height: 40,
              fit: BoxFit.contain,
            ),
          )],
        ),
      )
    );
  }
}