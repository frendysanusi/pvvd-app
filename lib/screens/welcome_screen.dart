import 'package:flutter/material.dart';
import 'package:pvvd_app/components/components.dart';
import 'package:pvvd_app/utils/constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  static String id = 'welcome_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 141,
              ),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/logo_pvvd.png',
                  width: 247,
                  height: 242,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(
                height: 162,
              ),
              CustomButton(
                buttonText: 'Login',
                onPressed: () {},
                width: 321,
                height: 61,
                buttonColor: kSecondary,
              ),
              const SizedBox(
                height: 22,
              ),
              CustomButton(
                buttonText: 'Register',
                onPressed: () {},
                width: 321,
                height: 61,
                buttonColor: kSecondary,
              ),
              const SizedBox(
                height: 123,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
