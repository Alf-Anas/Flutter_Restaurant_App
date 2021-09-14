import 'package:flutter/material.dart';
import 'package:restaurant_app/model/local_restaurant.dart';
import 'package:restaurant_app/values/strings.dart';

class DetailPage extends StatelessWidget {
  final Restaurant restaurant;

  const DetailPage({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 800) {
            return DetailWebPage(restaurant: restaurant);
          } else {
            return DetailMobilePage(restaurant: restaurant);
          }
        },
      ),
    );
  }
}

class DetailWebPage extends StatefulWidget {
  final Restaurant restaurant;

  const DetailWebPage({Key? key, required this.restaurant}) : super(key: key);

  @override
  State<DetailWebPage> createState() => _DetailWebPageState();
}

class _DetailWebPageState extends State<DetailWebPage> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return FullScreenImage(path: widget.restaurant.pictureId);
                    }));
                  },
                  child: SizedBox(
                    height: 150,
                    child: Hero(
                      tag: 'tag_${widget.restaurant.id}',
                      child: Image.network(widget.restaurant.pictureId),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DataTable(
                  columns: const [
                    DataColumn(
                        label: Expanded(
                      child: Text(StrList.foods,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    )),
                    DataColumn(
                        label: Expanded(
                      child: Text(StrList.drinks,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    )),
                  ],
                  rows: getMenusRow(widget.restaurant.menus),
                ),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          widget.restaurant.name +
                              " *" +
                              widget.restaurant.rating.toString(),
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.restaurant.city,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Text(
                            widget.restaurant.description,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'Oxygen',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  getMenusRow(Menus menus) {
    List<DataRow> _dataRows = [];
    int rowMax = (menus.foods.length > menus.drinks.length)
        ? menus.foods.length
        : menus.drinks.length;
    for (int i = 0; i < rowMax; i++) {
      final row = DataRow(cells: [
        DataCell(Text(
          (i < menus.foods.length) ? menus.foods[i] : "",
          textAlign: TextAlign.center,
        )),
        DataCell(Text((i < menus.drinks.length) ? menus.drinks[i] : "",
            textAlign: TextAlign.center)),
      ]);
      _dataRows.add(row);
    }
    return _dataRows;
  }
}

class DetailMobilePage extends StatefulWidget {
  final Restaurant restaurant;

  const DetailMobilePage({Key? key, required this.restaurant})
      : super(key: key);

  @override
  State<DetailMobilePage> createState() => _DetailMobilePageState();
}

class _DetailMobilePageState extends State<DetailMobilePage> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return FullScreenImage(path: widget.restaurant.pictureId);
                }));
              },
              child: SizedBox(
                height: 150,
                child: Hero(
                  tag: 'tag_${widget.restaurant.id}',
                  child: Image.network(widget.restaurant.pictureId),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    widget.restaurant.name +
                        " *" +
                        widget.restaurant.rating.toString(),
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.restaurant.city,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 24),
                    child: Text(
                      widget.restaurant.description,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'Oxygen',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Text(
              StrList.menu,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            DataTable(
              columns: const [
                DataColumn(
                    label: Expanded(
                  child: Text(StrList.foods,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                )),
                DataColumn(
                    label: Expanded(
                  child: Text(StrList.drinks,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                )),
              ],
              rows: getMenusRow(widget.restaurant.menus),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  getMenusRow(Menus menus) {
    List<DataRow> _dataRows = [];
    int rowMax = (menus.foods.length > menus.drinks.length)
        ? menus.foods.length
        : menus.drinks.length;
    for (int i = 0; i < rowMax; i++) {
      final row = DataRow(cells: [
        DataCell(Text(
          (i < menus.foods.length) ? menus.foods[i] : "",
          textAlign: TextAlign.center,
        )),
        DataCell(Text((i < menus.drinks.length) ? menus.drinks[i] : "",
            textAlign: TextAlign.center)),
      ]);
      _dataRows.add(row);
    }
    return _dataRows;
  }
}

class FullScreenImage extends StatelessWidget {
  final String path;

  const FullScreenImage({Key? key, required this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Hero(
            tag: path,
            child: Image.network(path, fit: BoxFit.contain, errorBuilder:
                (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
              return Image.asset(AssetsList.imgLogo);
            }),
          ),
        ),
      ),
    );
  }
}
