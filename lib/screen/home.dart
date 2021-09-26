import 'package:flutter/material.dart';
import 'package:restaurant_app/screen/list.dart';
import 'package:restaurant_app/values/strings.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StrList.listRestaurant),
        actions: [
          IconButton(
              icon: const Icon(Icons.star_border),
              onPressed: () {
                Navigator.of(context).pushNamed(RouteList.favorite);
              }),
          IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.of(context).pushNamed(RouteList.setting);
              }),
        ],
      ),
      body: const ListPage(),
    );
  }
}
