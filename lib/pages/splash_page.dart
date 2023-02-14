import 'dart:async';
import 'package:flutter/material.dart';

import '../pages/onboarding_page.dart';
import '../shared/style.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static const String routeName = '/splash';

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(
        context,
        OnboardingPage.routeName,
        (route) => false,
      );
    });
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [cRedColor, cOrangeColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: Image.asset(
              'assets/icons/icon-logo-white.png',
              width: 200,
            ),
          ),
        ],
      ),
    );
  }
}
