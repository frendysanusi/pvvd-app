import 'package:flutter/material.dart';
import 'package:pvvd_app/screens/profile_screen.dart';
import 'package:pvvd_app/screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: const TextTheme(
            bodyText1: TextStyle(),
            bodyText2: TextStyle()
          ).apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        ProfileScreen.id: (context) => const ProfileScreen(),
      },
      // initialRoute: WelcomeScreen.id,
      // routes: {WelcomeScreen.id: (context) => const WelcomeScreen()},
    );
  }
}
