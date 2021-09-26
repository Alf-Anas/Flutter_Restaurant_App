class ListRestaurant {
  ListRestaurant({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  bool error;
  int founded;
  List<Restaurant> restaurants;

  factory ListRestaurant.fromJson(Map<String, dynamic> json) => ListRestaurant(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<Restaurant>.from(
            (json["restaurants"] as List).map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "articles": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}

class Restaurant {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: "https://restaurant-api.dicoding.dev/images/medium/" +
            json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId.replaceFirst(
            'https://restaurant-api.dicoding.dev/images/medium/', ''),
        "city": city,
        "rating": rating.toDouble(),
      };
}

class Menus {
  List<String> foods;
  List<String> drinks;

  Menus({
    required this.foods,
    required this.drinks,
  });
}

class RestaurantDetail {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  String address;
  double rating;
  List<String> categories;
  Menus menus;

  RestaurantDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.address,
    required this.rating,
    required this.categories,
    required this.menus,
  });

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) =>
      RestaurantDetail(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: "https://restaurant-api.dicoding.dev/images/medium/" +
            json["pictureId"],
        city: json["city"],
        address: json["address"],
        rating: json["rating"].toDouble(),
        categories: getItem(json["categories"]),
        menus: getMenus(json['menus']),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId.replaceFirst(
            'https://restaurant-api.dicoding.dev/images/medium/', ''),
        "city": city,
        "rating": rating.toDouble(),
        "categories": [],
        "menus": Menus(foods: [], drinks: []),
      };

  factory RestaurantDetail.fromRestaurant(Restaurant restaurant) =>
      RestaurantDetail(
        id: restaurant.id,
        name: restaurant.name,
        description: restaurant.description,
        pictureId: restaurant.pictureId,
        city: restaurant.city,
        address: "",
        rating: restaurant.rating,
        categories: [],
        menus: Menus(foods: [], drinks: []),
      );
}

Menus getMenus(var menus) {
  Menus myMenus =
      Menus(foods: getItem(menus['foods']), drinks: getItem(menus['drinks']));
  return myMenus;
}

List<String> getItem(var items) {
  List<String> _items = [];
  for (var item in items) {
    _items.add(item['name']);
  }
  return _items;
}
