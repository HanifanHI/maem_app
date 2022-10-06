import 'package:flutter/material.dart';

import '/pages/cart_page.dart';
import '/pages/history_page.dart';
import '/pages/home_page.dart';
import '/pages/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  static const String routeName = '/main';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List _pages = [
    const HomePage(),
    const CartPage(),
    const HistoryPage(),
    const ProfilePage(),
  ];

  int _currentIndex = 0;

  void setPage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: _currentIndex == 0
                ? Image.asset(
                    'assets/icons/home.png',
                    width: 24,
                  )
                : Image.asset(
                    'assets/icons/home-outline.png',
                    width: 24,
                  ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 1
                ? Image.asset(
                    'assets/icons/shopping-cart.png',
                    width: 24,
                  )
                : Image.asset(
                    'assets/icons/shopping-cart-outline.png',
                    width: 24,
                  ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 2
                ? Image.asset(
                    'assets/icons/clipboard.png',
                    width: 24,
                  )
                : Image.asset(
                    'assets/icons/clipboard-outline.png',
                    width: 24,
                  ),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 3
                ? Image.asset(
                    'assets/icons/person.png',
                    width: 24,
                  )
                : Image.asset(
                    'assets/icons/person-outline.png',
                    width: 24,
                  ),
            label: 'Profile',
          ),
        ],
        onTap: setPage,
      ),
      body: _pages.elementAt(_currentIndex),
    );
  }
}
