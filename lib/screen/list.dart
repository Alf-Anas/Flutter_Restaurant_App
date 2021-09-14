import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/model/local_restaurant.dart';
import 'package:restaurant_app/screen/detail.dart';

class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth <= 600) {
          return const RestaurantList();
        } else if (constraints.maxWidth <= 1200) {
          return const RestaurantGrid(gridCount: 4);
        } else {
          return const RestaurantGrid(gridCount: 6);
        }
      },
    );
  }
}

class RestaurantList extends StatefulWidget {
  const RestaurantList({Key? key}) : super(key: key);

  @override
  State<RestaurantList> createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  List<Restaurant> _restaurantList = [];

  _RestaurantListState() {
    listRestaurant().then((val) => setState(() {
          _restaurantList = val;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final Restaurant restaurant = _restaurantList[index];
        return InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DetailPage(restaurant: restaurant);
            }));
          },
          child: Card(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Hero(
                    tag: 'tag_${restaurant.id}',
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 48.0,
                      child: Image.network(restaurant.pictureId),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              restaurant.name,
                              style: const TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                            Text(restaurant.rating.toString(),
                                style: const TextStyle(fontSize: 12.0)),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(restaurant.description.substring(0, 100) + '...'),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
      itemCount: _restaurantList.length,
    );
  }
}

class RestaurantGrid extends StatefulWidget {
  final int gridCount;

  const RestaurantGrid({Key? key, required this.gridCount}) : super(key: key);

  @override
  State<RestaurantGrid> createState() => _RestaurantGridState();
}

class _RestaurantGridState extends State<RestaurantGrid> {
  List<Restaurant> _restaurantList = [];

  _RestaurantGridState() {
    listRestaurant().then((val) => setState(() {
          _restaurantList = val;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      isAlwaysShown: true,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: widget.gridCount,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: _restaurantList.map((restaurant) {
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DetailPage(restaurant: restaurant);
                }));
              },
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Image.network(
                        restaurant.pictureId,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        restaurant.name + " : " + restaurant.rating.toString(),
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                      child: Text(
                        restaurant.description.substring(0, 100) + '...',
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
