import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              controller: _controller,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/onboarding2.png"),
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
                          const Text(
                            "Welcome to Biketrack",
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),

                          const SizedBox(height: 10),
                          const Text(
                            "Track your ride",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),

                          const SizedBox(height: 40),
                          SmoothPageIndicator(
                            controller: _controller,
                            count: 3,
                            effect: const ScrollingDotsEffect(
                              dotWidth: 12,
                              dotHeight: 12,
                              activeDotColor: Color(0xFFF05206),
                            ),
                          ),

                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(MediaQuery.of(context).size.width - 40, 50),
                            ),
                            child: const Text(
                              "Register",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {},
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
                ),
                
                const Center(
                  child: Text("page 2"),
                ),
                const Center(
                  child: Text("page 3"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}