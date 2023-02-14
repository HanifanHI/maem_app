import 'package:flutter/material.dart';

import '../data/api/api_service.dart';
import '../data/models/add_new_review.dart';

enum ResultState { loading, noData, hasData, hasError }

class AddNewReviewProvider extends ChangeNotifier {
  ApiService apiService;

  AddNewReviewProvider({required this.apiService});

  late AddNewReview _addNewReview;
  ResultState _resultState = ResultState.noData;
  String _message = '';

  AddNewReview get addNewReview => _addNewReview;
  ResultState get resultState => _resultState;
  String get message => _message;

  Future postAddNewReview(String id, String name, String review) async {
    try {
      _resultState = ResultState.loading;
      notifyListeners();
      final newReview = await apiService.addNewReview(id, name, review);

      if (newReview.customerReviews.isEmpty) {
        _resultState = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _resultState = ResultState.hasData;
        notifyListeners();
        return _addNewReview = newReview;
      }
    } catch (e) {
      _resultState = ResultState.hasError;
      notifyListeners();
      throw _message = 'Error $e';
    }
  }
}
