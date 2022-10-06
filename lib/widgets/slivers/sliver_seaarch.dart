import 'package:flutter/material.dart';

import '/shared/style.dart';

class SliverSearch extends SliverPersistentHeaderDelegate {
  TextEditingController controller;
  void Function(String)? searchRestItem;

  SliverSearch({
    required this.controller,
    required this.searchRestItem,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      width: double.infinity,
      height: minExtent,
      padding: const EdgeInsets.all(padding),
      color: cWhiteColor,
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cGreyLightColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Image.asset(
              'assets/icons/search-grey.png',
              width: 24,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: cGreyLightColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      onChanged: searchRestItem,
                      textInputAction: TextInputAction.search,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Cari restaurant',
                        hintStyle: greyTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: regular,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.only(right: 16),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.clear();
                      searchRestItem!('');
                    },
                    child: Image.asset(
                      'assets/icons/close.png',
                      width: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 110;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
