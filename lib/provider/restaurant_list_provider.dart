import 'package:flutter/material.dart';

import '../data/api/api_service.dart';
import '../data/models/restaurant_list.dart';

enum ResultState { loading, noData, hasData, hasError }

class RestaurantListProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantListProvider({required this.apiService}) {
    _fetchAllRestaurantList();
  }

  late RestaurantListModel _restaurantList;
  late ResultState _resultState;
  String _message = '';

  RestaurantListModel get restaurantList => _restaurantList;
  ResultState get resultState => _resultState;
  String get message => _message;

  Future _fetchAllRestaurantList() async {
    try {
      _resultState = ResultState.loading;
      notifyListeners();
      final restaurantList = await apiService.getRestaurantList();

      if (restaurantList.restaurants.isEmpty) {
        _resultState = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _resultState = ResultState.hasData;
        notifyListeners();
        return _restaurantList = restaurantList;
      }
    } catch (e) {
      _resultState = ResultState.hasError;
      notifyListeners();
      throw _message = 'Error $e';
    }
  }
}
