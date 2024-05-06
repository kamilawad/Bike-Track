import 'package:flutter/material.dart';
import 'package:mobile_flutter/data/static/onboardingdata.dart';
import 'package:mobile_flutter/widgets/Onboarding/onboarding_widget.dart';
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
                OnboardingWidget(model: onboarding[0]),
                OnboardingWidget(model: onboarding[1]),
                OnboardingWidget(model: onboarding[2]),
              ],
            ),
            
            Positioned(
              bottom: 180,
              left: 0,
              right: 0,
              child: Center(
                child: SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: const ScrollingDotsEffect(
                    dotWidth: 9,
                    dotHeight: 9,
                    activeDotColor: Color(0xFFF05206),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}