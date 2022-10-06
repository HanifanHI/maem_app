import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '/widgets/slivers/sliver_detail.dart';
import '/models/restaurant.dart';
import '/shared/style.dart';

class DetailPage extends StatefulWidget {
  final RestaurantElement rest;
  const DetailPage({
    super.key,
    required this.rest,
  });

  static const String routeName = '/detail';

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _isFav = false;

  Widget _buildAppBar() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(horizontal: padding),
      width: double.infinity,
      height: 60 + MediaQuery.of(context).padding.top,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 40,
              height: 40,
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: cWhiteColor,
              ),
              child: Image.asset(
                'assets/icons/arrow-left.png',
                width: 24,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _isFav = !_isFav;
              });
            },
            child: Container(
              width: 40,
              height: 40,
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: cWhiteColor,
              ),
              child: _isFav
                  ? Image.asset(
                      'assets/icons/heart.png',
                      width: 24,
                    )
                  : Image.asset(
                      'assets/icons/heart-outline.png',
                      width: 24,
                    ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/pin.png',
                        width: 18,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        widget.rest.city,
                        style: blackTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: medium,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/star.png',
                      width: 18,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      widget.rest.rating.toString(),
                      style: blackTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: medium,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Description',
              style: blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ReadMoreText(
              widget.rest.description,
              trimLines: 4,
              style: blackTextStyle.copyWith(
                fontSize: 14,
                fontWeight: regular,
                letterSpacing: 0.2,
                height: 1.5,
              ),
              colorClickableText: cOrangeColor,
              trimMode: TrimMode.Line,
              trimCollapsedText: 'Lihat Lebih Banyak',
              trimExpandedText: ' Lebih Sedikit',
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Menus',
              style: blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Foods :',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.rest.menus.foods.map((e) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 30,
                      height: 20,
                      child: Text(
                        '${(widget.rest.menus.foods.indexOf(e) + 1).toString()}.',
                        style: blackTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: regular,
                          letterSpacing: 0.2,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        e.name,
                        style: blackTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: regular,
                          letterSpacing: 0.2,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Drinks :',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.rest.menus.drinks.map((e) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 30,
                      height: 20,
                      child: Text(
                        '${(widget.rest.menus.drinks.indexOf(e) + 1).toString()}.',
                        style: blackTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: regular,
                          letterSpacing: 0.2,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        e.name,
                        style: blackTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: regular,
                          letterSpacing: 0.2,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverPersistentHeader(
                  delegate: SliverDetail(rest: widget.rest),
                  pinned: true,
                ),
              ];
            },
            body: _buildBody(),
          ),
          _buildAppBar(),
        ],
      ),
    );
  }
}
