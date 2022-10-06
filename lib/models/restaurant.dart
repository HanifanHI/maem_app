import 'dart:convert';

Restaurant restaurantFromJson(String str) =>
    Restaurant.fromJson(json.decode(str));

String restaurantToJson(Restaurant data) => json.encode(data.toJson());

class Restaurant {
  final List<RestaurantElement> restaurants;

  Restaurant({
    required this.restaurants,
  });

  factory Restaurant.fromJson(Map<String, dynamic> restaurants) => Restaurant(
        restaurants: List<RestaurantElement>.from(
          restaurants['restaurants'].map((e) => RestaurantElement.fromJson(e)),
        ),
      );

  Map<String, dynamic> toJson() => {
        'restaurants': List<dynamic>.from(restaurants.map((e) => e.toJson())),
      };
}

class RestaurantElement {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final Menus menus;

  RestaurantElement({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  factory RestaurantElement.fromJson(Map<String, dynamic> restaurant) =>
      RestaurantElement(
        id: restaurant['id'],
        name: restaurant['name'],
        description: restaurant['description'],
        pictureId: restaurant['pictureId'],
        city: restaurant['city'],
        rating: restaurant['rating'].toDouble(),
        menus: Menus.fromJson(restaurant['menus']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'pictureId': pictureId,
        'city': city,
        'rating': rating,
        'menus': menus.toJson(),
      };
}

class Menus {
  final List<FoodAndDrink> foods;
  final List<FoodAndDrink> drinks;

  Menus({
    required this.foods,
    required this.drinks,
  });

  factory Menus.fromJson(Map<String, dynamic> menus) => Menus(
        foods: List<FoodAndDrink>.from(
            menus['foods'].map((e) => FoodAndDrink.fromJson(e))),
        drinks: List<FoodAndDrink>.from(
            menus['drinks'].map((e) => FoodAndDrink.fromJson(e))),
      );

  Map<String, dynamic> toJson() => {
        'foods': List<dynamic>.from(foods.map((e) => e.toJson())),
        'drinks': List<dynamic>.from(drinks.map((e) => e.toJson())),
      };
}

class FoodAndDrink {
  final String name;

  FoodAndDrink({required this.name});

  factory FoodAndDrink.fromJson(Map<String, dynamic> food) =>
      FoodAndDrink(name: food['name']);

  Map<String, dynamic> toJson() => {'name': name};
}
