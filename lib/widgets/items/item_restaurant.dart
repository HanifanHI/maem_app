import 'package:flutter/material.dart';

import '/data/api/api_service.dart';
import '/data/models/restaurant_list.dart';
import '/pages/detail_page.dart';
import '/shared/style.dart';

class ItemRestaurant extends StatelessWidget {
  final RestaurantList rest;

  final ApiService _apiService = ApiService();

  ItemRestaurant({
    super.key,
    required this.rest,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          DetailPage.routeName,
          arguments: rest.id,
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
              tag: rest.id,
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  image: DecorationImage(
                    image: NetworkImage(
                      _apiService.getImagesLarge(rest.pictureId),
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
                      rest.name,
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
                          rest.city,
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
                      rest.rating.toString(),
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
