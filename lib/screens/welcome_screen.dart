import 'package:flutter/material.dart';
import 'package:pvvd_app/components/components.dart';
import 'package:pvvd_app/screens/login_screen.dart';
import 'package:pvvd_app/screens/register_screen.dart';
import 'package:pvvd_app/utils/constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  static String id = 'welcome_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCasal,
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
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
                width: 321,
                height: 61,
                buttonColor: kGreyishTeal,
              ),
              const SizedBox(
                height: 22,
              ),
              CustomButton(
                buttonText: 'Register',
                onPressed: () {
                  Navigator.pushNamed(context, RegisterScreen.id);
                },
                width: 321,
                height: 61,
                buttonColor: kGreyishTeal,
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
