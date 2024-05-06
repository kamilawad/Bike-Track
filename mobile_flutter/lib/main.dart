import 'package:flutter/material.dart';
import 'package:mobile_flutter/screens/Auth/login_screen.dart';
import 'package:mobile_flutter/screens/Auth/signup_screen.dart';
import 'package:mobile_flutter/screens/Home/home_screen.dart';
import 'package:mobile_flutter/screens/splash_screen.dart';
import 'package:mobile_flutter/screens/welcome_screen.dart';
import 'utils/theme_util.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bike Track',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: createMaterialColor(const Color(0xFFF05206)),
        //primaryColor: const Color(0xFFF05206),
        //colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF05206)),
        useMaterial3: false,
      ),
      routes: {
        "/": (context) => const SplashScreen(),
        "/welcome":(context) => const WelcomeScreen(),
        "/signup": (context) => const SignupScreen(),
        "/login": (context) => const LoginScreen(),
        "home": (context) => const HomeScreen(),
      }
    );
  }
}