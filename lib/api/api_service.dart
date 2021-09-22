import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/values/strings.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<ListRestaurant> listRestaurant(String query) async {
    final response = await http
        .get(Uri.parse(_baseUrl + "search?q=" + query))
        .timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      return ListRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception(StrList.failedListRestaurant);
    }
  }

  Future<RestaurantDetail> restaurantDetail(String id) async {
    try {
      final response = await http
          .get(Uri.parse(_baseUrl + "detail/" + id))
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        return RestaurantDetail.fromJson(
            json.decode(response.body)['restaurant']);
      } else {
        throw Exception(StrList.failedDetailRestaurant);
      }
    } catch (err) {
      throw Exception(StrList.failedDetailRestaurant);
    }
  }
}
