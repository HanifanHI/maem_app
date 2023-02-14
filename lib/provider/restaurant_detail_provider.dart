import 'package:flutter/material.dart';

import '../data/api/api_service.dart';
import '../data/models/restaurant_detail.dart';

enum ResultState { loading, noData, hasData, hasError }

class RestaurantDetailProvider extends ChangeNotifier {
  ApiService apiService;
  String id;

  late RestaurantDetailModel _restaurantDetail;
  late ResultState _resultState;
  String _message = '';

  RestaurantDetailProvider({required this.apiService, required this.id}) {
    _fetchAllRestaurantDetail(id);
  }

  RestaurantDetailModel get restaurantDetail => _restaurantDetail;
  ResultState get resultState => _resultState;
  String get message => _message;

  Future<dynamic> _fetchAllRestaurantDetail(String id) async {
    try {
      _resultState = ResultState.loading;
      notifyListeners();
      final restaurantDetail = await apiService.getRestaurantDetail(id);

      if (restaurantDetail.restaurant.id.isEmpty) {
        _resultState = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _resultState = ResultState.hasData;
        notifyListeners();
        return _restaurantDetail = restaurantDetail;
      }
    } catch (e) {
      _resultState = ResultState.hasError;
      notifyListeners();
      throw _message = 'Error $e';
    }
  }
}
