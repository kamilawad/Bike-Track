import 'package:flutter/material.dart';
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
                  child: const Center(
                    child: Text("page 1"),
                  ),
                ),
                Container(
                  child: const Center(
                    child: Text("page 2"),
                  ),
                ),
                Container(
                  child: const Center(
                    child: Text("page 3"),
                  ),
                ),
              ],
            ),

            Positioned(
              bottom: 50,
              left: 150,
              child: SmoothPageIndicator(controller: _controller, count: 3)
            )
          ],
        )
      ),
    );
  }
}