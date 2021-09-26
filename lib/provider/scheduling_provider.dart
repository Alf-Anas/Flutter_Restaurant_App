import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/date_time_helper.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/values/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;

  SchedulingProvider() {
    _loadDailyActivated();
  }

  bool get isScheduled => _isScheduled;

  void _loadDailyActivated() async {
    final prefs = await SharedPreferences.getInstance();
    _isScheduled = prefs.getBool(SharedPrefsList.dailyReminder) ?? false;
    notifyListeners();
  }

  void _dailyActivated(bool isActivated) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(SharedPrefsList.dailyReminder, isActivated);
  }

  Future<bool> scheduledNews(bool value) async {
    _isScheduled = value;
    _dailyActivated(_isScheduled);
    if (_isScheduled) {
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
