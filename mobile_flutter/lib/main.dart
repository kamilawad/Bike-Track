import 'package:flutter/material.dart';
import 'package:mobile_flutter/screens/auth/login_screen.dart';
import 'package:mobile_flutter/screens/auth/signup_screen.dart';
import 'package:mobile_flutter/screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        "/welcome": (context) => WelcomeScreen(),
        "/signup": (context) => SignupScreen(),
        "/login": (context) => LoginScreen(),
      }
    );
  }
}