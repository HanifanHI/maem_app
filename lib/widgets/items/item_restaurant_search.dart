import 'package:flutter/material.dart';
import 'package:maem_app/data/models/restaurant_search.dart';

import '/data/api/api_service.dart';
import '/pages/detail_page.dart';
import '/shared/style.dart';

class ItemRestaurantSearch extends StatelessWidget {
  final RestaurantSearch restSearch;

  final ApiService _apiService = ApiService();

  ItemRestaurantSearch({
    super.key,
    required this.restSearch,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          DetailPage.routeName,
          arguments: restSearch.id,
        );
      },
      child: Container(
        margin: const EdgeInsets.only(
          left: padding,
          right: padding,
          bottom: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: restSearch.id,
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  image: DecorationImage(
                    image: NetworkImage(
                      _apiService.getImagesLarge(restSearch.pictureId),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restSearch.name,
                      style: blackTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: semiBold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/icons/pin.png',
                          width: 16,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          restSearch.city,
                          style: blackTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: medium,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/star.png',
                      width: 16,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      restSearch.rating.toString(),
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
