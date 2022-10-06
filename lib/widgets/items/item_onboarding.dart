import 'package:flutter/material.dart';

import '/shared/style.dart';

class OnboardingItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subTitle;

  const OnboardingItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width,
          child: LayoutBuilder(
            builder: (context, constraint) => Image.asset(
              imageUrl,
              width: constraint.maxWidth,
              // fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          children: [
            Text(
              title,
              style: orangeTextStyle.copyWith(
                fontSize: 26,
                fontWeight: bold,
              ),
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              subTitle,
              style: greyTextStyle.copyWith(
                fontSize: 18,
                fontWeight: regular,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ],
    );
  }
}
