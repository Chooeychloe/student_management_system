import 'package:flutter/material.dart';

import '../models/activity.dart';

class ActivityProvider extends ChangeNotifier {
  final List<Activity> _activities = [];

  List<Activity> get activities => _activities;

  List<Activity> get recentActivities => _activities.reversed.take(10).toList();

  void addActivity({required String title, required String description}) {
    _activities.add(
      Activity(
        title: title,
        description: description,
        timestamp: DateTime.now(),
      ),
    );

    notifyListeners();
  }

  void clear() {
    _activities.clear();
    notifyListeners();
  }
}
