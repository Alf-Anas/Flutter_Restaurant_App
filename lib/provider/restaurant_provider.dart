import 'package:flutter/material.dart';
import 'dart:async';
import 'package:restaurant_app/api/api_service.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/values/strings.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _searchRestaurant("");
  }

  String _message = '';
  late ListRestaurant _listRestaurant;
  late ResultState _state;

  String get message => _message;
  ListRestaurant get listRestaurant => _listRestaurant;
  ResultState get state => _state;

  set query(String query) {
    _searchRestaurant(query);
  }

  Future<dynamic> _searchRestaurant(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final listRestaurant = await apiService.listRestaurant(query);
      if (listRestaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = StrList.emptyData;
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _listRestaurant = listRestaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = '${StrList.error} $e';
    }
  }
}
