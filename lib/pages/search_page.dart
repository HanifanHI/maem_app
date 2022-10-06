import 'package:flutter/material.dart';

import '/widgets/items/item_restaurant.dart';
import '/widgets/slivers/sliver_seaarch.dart';
import '/models/restaurant.dart';
import '/shared/style.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  static const String routeName = '/search';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<RestaurantElement> _search = [];
  List<RestaurantElement> _rest = [];

  final TextEditingController _controller = TextEditingController();

  List<RestaurantElement> _parseRest(String? json) {
    if (json == null) {
      return [];
    }
    Restaurant data = restaurantFromJson(json);
    _rest = data.restaurants.toList();
    return _rest;
  }

  _searchRestItem(String text) {
    _search.clear();
    if (text.isEmpty) {
      setState(() {});
      return _rest;
    }

    for (var e in _rest) {
      if (e.id.contains(text) ||
          e.name.toLowerCase().contains(text.toLowerCase())) {
        _search.add(e);
      }
    }
    setState(() {});
  }

  _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(75),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: padding),
            alignment: Alignment.bottomCenter,
            color: cWhiteColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        'assets/icons/arrow-left.png',
                        width: 24,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Search',
                      style: blackTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: semiBold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    gradient: const LinearGradient(
                      colors: [cRedColor, cOrangeColor],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                      delegate: SliverSearch(
                        controller: _controller,
                        searchRestItem: _searchRestItem,
                      ),
                      floating: true,
                    ),
                    constraint.maxWidth <= 700
                        ? SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return _search.isNotEmpty ||
                                        _controller.text.isNotEmpty
                                    ? ItemRestaurant(rest: _search[index])
                                    : ItemRestaurant(rest: rest[index]);
                              },
                              childCount: _search.isNotEmpty ||
                                      _controller.text.isNotEmpty
                                  ? _search.length
                                  : rest.length,
                            ),
                          )
                        : constraint.maxWidth <= 1200
                            ? SliverGrid.count(
                                crossAxisCount: 2,
                                childAspectRatio: MediaQuery.of(context)
                                        .size
                                        .width /
                                    (MediaQuery.of(context).size.height / 1.5),
                                children: _search.isNotEmpty ||
                                        _controller.text.isNotEmpty
                                    ? _search
                                        .map((e) => ItemRestaurant(rest: e))
                                        .toList()
                                    : rest
                                        .map((e) => ItemRestaurant(rest: e))
                                        .toList(),
                              )
                            : SliverGrid.count(
                                crossAxisCount: 3,
                                childAspectRatio:
                                    MediaQuery.of(context).size.width /
                                        MediaQuery.of(context).size.height,
                                children: _search.isNotEmpty ||
                                        _controller.text.isNotEmpty
                                    ? _search
                                        .map((e) => ItemRestaurant(rest: e))
                                        .toList()
                                    : rest
                                        .map((e) => ItemRestaurant(rest: e))
                                        .toList(),
                              )
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
