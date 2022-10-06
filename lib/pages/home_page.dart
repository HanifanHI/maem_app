import 'package:flutter/material.dart';

import '/widgets/items/item_restaurant.dart';
import '/widgets/slivers/sliver_home.dart';
import '/models/restaurant.dart';
import '/shared/style.dart';
import '/pages/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<RestaurantElement> _parseRest(String? json) {
    if (json == null) {
      return [];
    }
    Restaurant data = restaurantFromJson(json);
    return data.restaurants.toList();
  }

  _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(60 + MediaQuery.of(context).padding.top),
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(
          left: padding,
          right: padding,
          top: MediaQuery.of(context).padding.top,
        ),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [cRedColor, cOrangeColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/icon-logo-white.png',
              width: 110,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  SearchPage.routeName,
                );
              },
              child: Image.asset(
                'assets/icons/search-white.png',
                width: 35,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cWhiteColor,
      appBar: _buildAppBar(),
      body: LayoutBuilder(
        builder: (context, constraint) {
          return FutureBuilder<String>(
            future: DefaultAssetBundle.of(context)
                .loadString('assets/json/restaurant.json'),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<RestaurantElement> rest = _parseRest(snapshot.data);
                return CustomScrollView(
                  slivers: [
                    SliverPersistentHeader(
                      delegate: SliverHome(),
                      floating: true,
                    ),
                    constraint.maxWidth <= 700
                        ? SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) =>
                                  ItemRestaurant(rest: rest[index]),
                              childCount: rest.length,
                            ),
                          )
                        : constraint.maxWidth <= 1200
                            ? SliverGrid.count(
                                crossAxisCount: 2,
                                childAspectRatio: MediaQuery.of(context)
                                        .size
                                        .width /
                                    (MediaQuery.of(context).size.height / 1.5),
                                children: rest
                                    .map((e) => ItemRestaurant(rest: e))
                                    .toList(),
                              )
                            : SliverGrid.count(
                                crossAxisCount: 3,
                                childAspectRatio:
                                    MediaQuery.of(context).size.width /
                                        MediaQuery.of(context).size.height,
                                children: rest
                                    .map((e) => ItemRestaurant(rest: e))
                                    .toList(),
                              ),
                  ],
                );
              } else {
                return Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Mohon Maaf\nTerjadi Kesalahan\nData Tidak Dapat Ditampilkan',
                    style: purpleTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: semiBold,
                      color: cRedColor.withOpacity(0.5),
                      letterSpacing: 0.4,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
