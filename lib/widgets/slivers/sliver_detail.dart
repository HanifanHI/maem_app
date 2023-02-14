import 'package:flutter/material.dart';

import '/data/api/api_service.dart';
import '/data/models/restaurant_detail.dart';
import '/shared/style.dart';

class SliverDetail extends SliverPersistentHeaderDelegate {
  RestaurantDetail restDetail;

  SliverDetail({
    required this.restDetail,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      children: [
        Hero(
          tag: restDetail.id,
          child: Container(
            width: double.infinity,
            height: 350,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  ApiService().getImagesLarge(restDetail.pictureId),
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: maxExtent,
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsets.only(left: padding, bottom: padding),
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
            restDetail.name,
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
  double get maxExtent => 350;

  @override
  double get minExtent => 250;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
