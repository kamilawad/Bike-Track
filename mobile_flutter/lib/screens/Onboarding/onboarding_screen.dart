import 'dart:async';

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
  final PageController _controller = PageController(initialPage: 0);
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_currentPage == onboarding.length - 1) {
        _controller.jumpToPage(0);
        _currentPage = 0;
      } else {
        _controller.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        _currentPage++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
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
                  count: onboarding.length,
                  effect: const ScrollingDotsEffect(
                    dotWidth: 9,
                    dotHeight: 9,
                    activeDotColor: Color(0xFFF05206),
                  ),
                  onDotClicked: (index) {
                    _controller.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                    _currentPage = index;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}