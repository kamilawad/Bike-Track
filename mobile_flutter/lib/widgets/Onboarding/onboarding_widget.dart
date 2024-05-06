import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_flutter/data/model/onboardingModel.dart';

class OnboardingWidget extends StatelessWidget {
  
  final OnboardingModel model;

  const OnboardingWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(model.imagePath),
          fit: BoxFit.cover,
        ),
      ),
    
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              'biketrack',
              style: GoogleFonts.knewave(
                fontSize: 30,
                color: const Color(0xFFF05206),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                model.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
    
              const SizedBox(height: 10),
              Text(
                model.subTitle,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
    
              const SizedBox(height: 70),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).popAndPushNamed("/signup");
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width - 40, 50),
                ),
                child: const Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
    
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).popAndPushNamed("/login");
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width - 40, 50),
                  backgroundColor: Colors.white,
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFF05206),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ],
      ),
    );
  }
}