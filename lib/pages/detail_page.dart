import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import '../data/api/api_service.dart';
import '../provider/restaurant_detail_provider.dart';
import '../widgets/slivers/sliver_detail.dart';
import '../shared/style.dart';
import '../pages/add_review_page.dart';
import '../pages/main_page.dart';

class DetailPage extends StatelessWidget {
  static const String routeName = '/detail';

  const DetailPage({super.key});

  Widget _buildAppBar(BuildContext context) {
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
              Navigator.pushNamed(
                context,
                MainPage.routeName,
              );
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
            onTap: () {},
            child: Container(
              width: 40,
              height: 40,
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: cWhiteColor,
              ),
              child: Image.asset(
                'assets/icons/heart-outline.png',
                width: 24,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBody(String id) {
    return SingleChildScrollView(
      child: Consumer<RestaurantDetailProvider>(
        builder: (context, value, _) => Container(
          padding: const EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/icons/pin.png',
                          width: 18,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              value.restaurantDetail.restaurant.address,
                              style: blackTextStyle.copyWith(
                                fontSize: 18,
                                fontWeight: medium,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              value.restaurantDetail.restaurant.city,
                              style: blackTextStyle.copyWith(
                                fontSize: 18,
                                fontWeight: medium,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
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
                        value.restaurantDetail.restaurant.rating.toString(),
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
                value.restaurantDetail.restaurant.description,
                trimLines: 4,
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: regular,
                  letterSpacing: 0.2,
                  height: 1.3,
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
                'Categories',
                style: blackTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: semiBold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: value.restaurantDetail.restaurant.categories.map(
                    (e) {
                      return Container(
                        alignment: Alignment.center,
                        padding:
                            const EdgeInsets.symmetric(horizontal: padding),
                        margin: const EdgeInsets.only(right: 10),
                        height: 35,
                        decoration: BoxDecoration(
                          color: cPurpleColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          e.name,
                          style: whiteTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: regular,
                            letterSpacing: 0.2,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    },
                  ).toList(),
                ),
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
                  fontSize: 18,
                  fontWeight: medium,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: value.restaurantDetail.restaurant.menus.foods.map(
                  (e) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 30,
                          height: 20,
                          child: Text(
                            '${(value.restaurantDetail.restaurant.menus.foods.indexOf(e) + 1).toString()}.',
                            style: blackTextStyle.copyWith(
                              fontSize: 16,
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
                              fontSize: 16,
                              fontWeight: regular,
                              letterSpacing: 0.2,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    );
                  },
                ).toList(),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Drinks :',
                style: blackTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: medium,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: value.restaurantDetail.restaurant.menus.drinks.map(
                  (e) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 30,
                          height: 20,
                          child: Text(
                            '${(value.restaurantDetail.restaurant.menus.drinks.indexOf(e) + 1).toString()}.',
                            style: blackTextStyle.copyWith(
                              fontSize: 16,
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
                              fontSize: 16,
                              fontWeight: regular,
                              letterSpacing: 0.2,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    );
                  },
                ).toList(),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Reviews',
                style: blackTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: semiBold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: value.restaurantDetail.restaurant.customerReviews.map(
                  (e) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${e.name} :',
                            style: blackTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: medium,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          ReadMoreText(
                            e.review,
                            trimLines: 2,
                            style: blackTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: regular,
                              letterSpacing: 0.2,
                              height: 1.3,
                            ),
                            colorClickableText: cOrangeColor,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: 'Lihat Lebih Banyak',
                            trimExpandedText: ' Lebih Sedikit',
                          ),
                          Text(
                            e.date,
                            style: greyTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: regular,
                              letterSpacing: 0.2,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  },
                ).toList(),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AddNewReviewPage.routeName,
                    arguments: id,
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    color: cOrangeColor,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    'Add New Review',
                    style: whiteTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;

    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (context) => RestaurantDetailProvider(
        apiService: ApiService(),
        id: id,
      ),
      child: Scaffold(
        body: Consumer<RestaurantDetailProvider>(
          builder: (context, rest, child) {
            switch (rest.resultState) {
              case ResultState.loading:
                return const Center(
                  child: CircularProgressIndicator(
                    color: cOrangeColor,
                  ),
                );
              case ResultState.hasData:
                return Stack(
                  children: [
                    NestedScrollView(
                      headerSliverBuilder: (context, innerBoxIsScrolled) {
                        return [
                          SliverPersistentHeader(
                            delegate: SliverDetail(
                                restDetail: rest.restaurantDetail.restaurant),
                            pinned: true,
                          ),
                        ];
                      },
                      body: _buildBody(id),
                    ),
                    _buildAppBar(context),
                  ],
                );
              case ResultState.noData:
                return Container(
                  alignment: Alignment.center,
                  child: Text(
                    rest.message,
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
                    rest.message,
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
      ),
    );
  }
}
