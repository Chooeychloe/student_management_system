import 'package:flutter/material.dart';

enum AppPage { dashboard, settings, about, backupRestore }

class NavigationProvider extends ChangeNotifier {
  AppPage _currentPage = AppPage.dashboard;

  AppPage get currentPage => _currentPage;

  void navigateTo(AppPage page) {
    if (_currentPage == page) return;

    _currentPage = page;
    notifyListeners();
  }
}
