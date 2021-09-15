import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:restaurant_app/values/strings.dart';

class Menus {
  List<String> foods;
  List<String> drinks;

  Menus({
    required this.foods,
    required this.drinks,
  });
}

class Restaurant {
  int no;
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;
  Menus menus;

  Restaurant({
    required this.no,
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });
}

Future loadJson() async {
  Future<String> data = rootBundle.loadString(AssetsList.jsonRestaurant);
  return json.decode(await data);
}

List<String> getItem(var items) {
  List<String> _items = [];
  for (var item in items) {
    _items.add(item['name']);
  }
  return _items;
}

Menus getMenus(var menus) {
  Menus myMenus =
      Menus(foods: getItem(menus['foods']), drinks: getItem(menus['drinks']));
  return myMenus;
}

Future<List<Restaurant>> listRestaurant() async {
  var jsonResult = await loadJson();
  var jsonArray = jsonResult['restaurants'];

  List<Restaurant> _restaurantList = [];

  for (var restaurant in jsonArray) {
    Restaurant _restaurant = Restaurant(
        no: _restaurantList.length,
        id: restaurant['id'],
        name: restaurant['name'],
        description: restaurant['description'],
        pictureId: restaurant['pictureId'],
        city: restaurant['city'],
        rating: restaurant['rating'].toDouble(),
        menus: getMenus(restaurant['menus']));
    _restaurantList.add(_restaurant);
  }

  return _restaurantList;
}
