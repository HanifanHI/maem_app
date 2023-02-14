import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../models/add_new_review.dart';
import '../models/restaurant_search.dart';
import '../models/restaurant_list.dart';
import '../models/restaurant_detail.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<RestaurantListModel> getRestaurantList() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/list'));

      if (response.statusCode == 200) {
        return RestaurantListModel.fromJson(json.decode(response.body));
      } else {
        throw 'Failed to load data';
      }
    } on SocketException {
      throw 'No internet connection';
    } on HttpException {
      throw 'Couldn\'t find the post';
    } on FormatException {
      throw 'Bad response format';
    } catch (e) {
      throw '$e';
    }
  }

  Future<RestaurantDetailModel> getRestaurantDetail(String id) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/detail/$id'));

      if (response.statusCode == 200) {
        return RestaurantDetailModel.fromJson(json.decode(response.body));
      } else {
        throw 'Failed to load data';
      }
    } on SocketException {
      throw 'No internet connection';
    } on HttpException {
      throw 'Couldn\'t find the post';
    } on FormatException {
      throw 'Bad response format';
    } catch (e) {
      throw '$e';
    }
  }

  Future<RestaurantSearchModel> getRestaurantSearch(String query) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/search?q=$query'));

      if (response.statusCode == 200) {
        return RestaurantSearchModel.fromJson(json.decode(response.body));
      } else {
        throw 'Failed to load data';
      }
    } on SocketException {
      throw 'No internet connection';
    } on HttpException {
      throw 'Couldn\'t find the post';
    } on FormatException {
      throw 'Bad response format';
    } catch (e) {
      throw '$e';
    }
  }

  Future<AddNewReview> addNewReview(
      String id, String name, String review) async {
    try {
      final response = await http.post(Uri.parse('$_baseUrl/review'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "id": id,
            "name": name,
            "review": review,
          }));

      if (response.statusCode == 201) {
        return AddNewReview.fromJson(json.decode(response.body));
      } else {
        throw 'Failed to load data';
      }
    } on SocketException {
      throw 'No internet connection';
    } on HttpException {
      throw 'Couldn\'t find the post';
    } on FormatException {
      throw 'Bad response format';
    } catch (e) {
      throw '$e';
    }
  }

  String getImagesSmall(String id) {
    return '$_baseUrl/images/small/$id';
  }

  String getImagesMedium(String id) {
    return '$_baseUrl/images/medium/$id';
  }

  String getImagesLarge(String id) {
    return '$_baseUrl/images/large/$id';
  }
}
