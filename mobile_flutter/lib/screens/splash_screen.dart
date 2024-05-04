import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: const Text("hello"),
        backgroundColor: Theme.of(context).primaryColor,
      ),*/
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/bike_logo.png'),
            Text(
              'biketrack',
              style: GoogleFonts.knewave(
                fontSize: 30,
                color: Colors.white,
              ),
            )
          ],
          ),
      ),
    );
  }
}