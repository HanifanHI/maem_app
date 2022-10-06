import 'package:flutter/material.dart';

import '/shared/style.dart';

class SliverHome extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: cWhiteColor,
      padding: const EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Daftar Restaurant',
            style: blackTextStyle.copyWith(
              fontSize: 24,
              fontWeight: bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            'Rekomendasi restoran untuk kamu',
            style: greyTextStyle.copyWith(
              fontSize: 16,
              fontWeight: regular,
              letterSpacing: 0.2,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                width: 90,
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  gradient: const LinearGradient(
                    colors: [
                      cRedColor,
                      cOrangeColor,
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Container(
                width: 10,
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: cOrangeColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 110;

  @override
  double get minExtent => 110;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
