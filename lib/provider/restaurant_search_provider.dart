import 'package:flutter/material.dart';

import '../data/api/api_service.dart';
import '../data/models/restaurant_search.dart';

enum ResultState { loading, noData, hasData, hasError }

class RestaurantSearchProvider extends ChangeNotifier {
  ApiService apiService;

  RestaurantSearchProvider({required this.apiService});

  late RestaurantSearchModel _restaurantSearch;
  ResultState _resultState = ResultState.noData;
  String _message = '';

  RestaurantSearchModel get restaurantSearch => _restaurantSearch;
  ResultState get resultState => _resultState;
  String get message => _message;

  Future fetchRestaurantSearch(String query) async {
    try {
      _resultState = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.getRestaurantSearch(query);

      if (restaurant.restaurants.isEmpty) {
        _resultState = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _resultState = ResultState.hasData;
        notifyListeners();
        return _restaurantSearch = restaurant;
      }
    } catch (e) {
      _resultState = ResultState.hasError;
      notifyListeners();
      throw _message = 'Error $e';
    }
  }
}
