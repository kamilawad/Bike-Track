import 'package:flutter/material.dart';
import 'package:mobile_flutter/screens/Auth/login_screen.dart';
import 'package:mobile_flutter/screens/Auth/signup_screen.dart';
import 'package:mobile_flutter/screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bike Track',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        "/": (context) => const WelcomeScreen(),
        "/signup": (context) => const SignupScreen(),
        "/login": (context) => const LoginScreen(),
      }
    );
  }
}