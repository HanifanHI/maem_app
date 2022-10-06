import 'package:flutter/material.dart';

import '/models/restaurant.dart';
import '/shared/style.dart';

class SliverDetail extends SliverPersistentHeaderDelegate {
  RestaurantElement rest;

  SliverDetail({
    required this.rest,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      children: [
        Hero(
          tag: rest.id,
          child: Container(
            width: double.infinity,
            height: 400,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(rest.pictureId),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: maxExtent,
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsets.only(left: 20, bottom: 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.7),
                Colors.transparent,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Text(
            rest.name,
            style: whiteTextStyle.copyWith(
              fontSize: 30,
              fontWeight: bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => 400;

  @override
  double get minExtent => 250;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
