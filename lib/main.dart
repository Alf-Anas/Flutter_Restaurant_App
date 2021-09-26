import 'dart:io';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:restaurant_app/screen/favorite.dart';
import 'package:restaurant_app/screen/home.dart';
import 'package:restaurant_app/screen/setting.dart';
import 'package:restaurant_app/screen/splash.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/database_helper.dart';
import 'package:restaurant_app/utils/notification_helper.dart';
import 'package:restaurant_app/values/strings.dart';
import 'package:restaurant_app/values/colors.dart';
import 'api/api_service.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

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
        RouteList.home: (context) => ChangeNotifierProvider<RestaurantProvider>(
              create: (_) => RestaurantProvider(
                apiService: ApiService(),
              ),
              child: const HomePage(),
            ),
        RouteList.favorite: (context) =>
            ChangeNotifierProvider<DatabaseProvider>(
              create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
              child: const FavoritePage(),
            ),
        RouteList.setting: (context) =>
            ChangeNotifierProvider<SchedulingProvider>(
              create: (_) => SchedulingProvider(),
              child: const SettingPage(),
            ),
      },
    );
  }
}
