import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/restaurant_list_provider.dart';
import '../widgets/items/item_restaurant.dart';
import '../widgets/slivers/sliver_home.dart';
import '../shared/style.dart';
import '../pages/search_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String routeName = '/home';

  _buildAppBar(BuildContext context) {
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

  Widget _buildBody() {
    return Consumer<RestaurantListProvider>(
      builder: (context, value, _) => LayoutBuilder(
        builder: (context, constraint) {
          switch (value.resultState) {
            case ResultState.loading:
              return const Center(
                child: CircularProgressIndicator(
                  color: cOrangeColor,
                ),
              );
            case ResultState.hasData:
              return CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                    delegate: SliverHome(),
                    floating: true,
                  ),
                  constraint.maxWidth <= 700
                      ? SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) => ItemRestaurant(
                                rest: value.restaurantList.restaurants[index]),
                            childCount: value.restaurantList.restaurants.length,
                          ),
                        )
                      : constraint.maxWidth <= 1200
                          ? SliverGrid.count(
                              crossAxisCount: 2,
                              childAspectRatio: MediaQuery.of(context)
                                      .size
                                      .width /
                                  (MediaQuery.of(context).size.height / 1.5),
                              children: value.restaurantList.restaurants
                                  .map((e) => ItemRestaurant(rest: e))
                                  .toList(),
                            )
                          : SliverGrid.count(
                              crossAxisCount: 3,
                              childAspectRatio:
                                  MediaQuery.of(context).size.width /
                                      MediaQuery.of(context).size.height,
                              children: value.restaurantList.restaurants
                                  .map((e) => ItemRestaurant(rest: e))
                                  .toList(),
                            ),
                ],
              );
            case ResultState.noData:
              return Container(
                alignment: Alignment.center,
                child: Text(
                  value.message,
                  style: purpleTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: semiBold,
                    color: cRedColor.withOpacity(0.5),
                    letterSpacing: 0.4,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                ),
              );
            case ResultState.hasError:
              return Container(
                alignment: Alignment.center,
                child: Text(
                  value.message,
                  style: purpleTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: semiBold,
                    color: cRedColor.withOpacity(0.5),
                    letterSpacing: 0.4,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                ),
              );
            default:
              return const Center();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cWhiteColor,
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }
}
