import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/restaurant.dart';

import 'pages/main_page.dart';
import 'pages/cart_page.dart';
import 'pages/detail_page.dart';
import 'pages/history_page.dart';
import 'pages/login_page.dart';
import 'pages/onboarding_page.dart';
import 'pages/profile_page.dart';
import 'pages/search_page.dart';
import 'pages/splash_page.dart';
import 'pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runApp(const MaemApp());
    },
  );
}

class MaemApp extends StatelessWidget {
  const MaemApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashPage.routeName,
      routes: {
        SplashPage.routeName: (context) => const SplashPage(),
        OnboardingPage.routeName: (context) => const OnboardingPage(),
        LoginPage.routeName: (context) => const LoginPage(),
        HomePage.routeName: (context) => const HomePage(),
        DetailPage.routeName: (context) => DetailPage(
            rest: ModalRoute.of(context)?.settings.arguments
                as RestaurantElement),
        SearchPage.routeName: (context) => const SearchPage(),
        CartPage.routeName: (context) => const CartPage(),
        HistoryPage.routeName: (context) => const HistoryPage(),
        ProfilePage.routeName: (context) => const ProfilePage(),
        MainPage.routeName: (context) => const MainPage(),
      },
    );
  }
}
