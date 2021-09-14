import 'package:flutter/material.dart';
import 'package:restaurant_app/screen/home.dart';
import 'package:restaurant_app/screen/splash.dart';
import 'package:restaurant_app/values/strings.dart';
import 'package:restaurant_app/values/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StrList.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: createMaterialColor(ColorList.primary),
        ).copyWith(
          secondary: createMaterialColor(ColorList.secondary),
        ),
      ),
      initialRoute: RouteList.splash,
      routes: {
        RouteList.splash: (context) => const SplashPage(),
        RouteList.home: (context) => const HomePage(),
      },
    );
  }
}
