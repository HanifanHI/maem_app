import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../widgets/items/item_onboarding.dart';
import '../pages/login_page.dart';
import '../shared/style.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  static const String routeName = '/onboarding';

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int _currentIndex = 0;
  final CarouselController _controller = CarouselController();

  Widget _buildOnboarding() {
    return Expanded(
      child: CarouselSlider(
        carouselController: _controller,
        items: const [
          OnboardingItem(
            imageUrl: 'assets/images/onboarding1.png',
            title: 'Best Place To Eat',
            subTitle:
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
          ),
          OnboardingItem(
            imageUrl: 'assets/images/onboarding2.png',
            title: 'Order Food Easily',
            subTitle:
                'Lorem Ipsum has been the industry\'s standard dummy text ever since',
          ),
          OnboardingItem(
            imageUrl: 'assets/images/onboarding3.png',
            title: 'Fast Food Delivery',
            subTitle:
                'It has survived not only five centuries, but also the leap into electronic',
          ),
        ],
        options: CarouselOptions(
          height: double.infinity,
          viewportFraction: 1,
          enableInfiniteScroll: false,
          initialPage: _currentIndex,
          onPageChanged: (index, _) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }

  Widget _buildCarousel(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) => Container(
        margin: const EdgeInsets.only(bottom: 30),
        width: double.infinity,
        height: 45,
        child: Row(
          mainAxisAlignment: constraint.maxWidth <= 700
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                _controller.animateToPage(2);
              },
              child: Text(
                'SKIP',
                style: blackTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: regular,
                ),
              ),
            ),
            SizedBox(
              width: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color:
                          _currentIndex == 0 ? cPurpleColor : cIndicatorColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color:
                          _currentIndex == 1 ? cPurpleColor : cIndicatorColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color:
                          _currentIndex == 2 ? cPurpleColor : cIndicatorColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                if (_currentIndex == 2) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    LoginPage.routeName,
                    (route) => false,
                  );
                } else {
                  _controller.nextPage();
                }
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: cOrangeColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    'assets/icons/arrow-right.png',
                    width: 24,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cWhiteColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: padding),
        child: Column(
          children: [
            _buildOnboarding(),
            _buildCarousel(context),
          ],
        ),
      ),
    );
  }
}
