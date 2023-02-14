import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/items/item_restaurant_search.dart';
import '../provider/restaurant_search_provider.dart';
import '../widgets/slivers/sliver_seaarch.dart';
import '../shared/style.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  static const String routeName = '/search';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();

  _buildAppBar(BuildContext context) {
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

  Widget _buildBody() {
    return Consumer<RestaurantSearchProvider>(
      builder: (context, search, child) => CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: SliverSearch(
              controller: _controller,
              searchRestItem: (value) {
                if (value.isNotEmpty) {
                  search.fetchRestaurantSearch(value);
                }
              },
            ),
            floating: true,
          ),
          search.resultState == ResultState.loading
              ? const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: cOrangeColor,
                    ),
                  ),
                )
              : search.resultState == ResultState.hasData
                  ? SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return _controller.text.isEmpty
                              ? const SizedBox()
                              : ItemRestaurantSearch(
                                  restSearch: search
                                      .restaurantSearch.restaurants[index],
                                );
                        },
                        childCount: search.restaurantSearch.restaurants.length,
                      ),
                    )
                  : search.resultState == ResultState.noData
                      ? SliverToBoxAdapter(
                          child: Center(
                            child: Text(
                              search.message,
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
                          ),
                        )
                      : SliverToBoxAdapter(
                          child: Center(
                            child: Text(
                              search.message,
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
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }
}
