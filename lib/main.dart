import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../data/api/api_service.dart';
import '../provider/add_new_review_provider.dart';
import '../provider/restaurant_list_provider.dart';
import '../provider/restaurant_search_provider.dart';

import '../pages/add_review_page.dart';
import '../pages/main_page.dart';
import '../pages/cart_page.dart';
import '../pages/detail_page.dart';
import '../pages/history_page.dart';
import '../pages/login_page.dart';
import '../pages/onboarding_page.dart';
import '../pages/profile_page.dart';
import '../pages/search_page.dart';
import '../pages/splash_page.dart';
import '../pages/home_page.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RestaurantListProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              RestaurantSearchProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (context) => AddNewReviewProvider(apiService: ApiService()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: SplashPage.routeName,
        routes: {
          SplashPage.routeName: (context) => const SplashPage(),
          OnboardingPage.routeName: (context) => const OnboardingPage(),
          LoginPage.routeName: (context) => const LoginPage(),
          HomePage.routeName: (context) => const HomePage(),
          DetailPage.routeName: (context) => const DetailPage(),
          SearchPage.routeName: (context) => const SearchPage(),
          CartPage.routeName: (context) => const CartPage(),
          HistoryPage.routeName: (context) => const HistoryPage(),
          ProfilePage.routeName: (context) => const ProfilePage(),
          MainPage.routeName: (context) => const MainPage(),
          AddNewReviewPage.routeName: (context) => const AddNewReviewPage(),
        },
      ),
    );
  }
}
