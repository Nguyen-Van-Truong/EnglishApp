// lib/src/theme/theme_provider.dart
import 'package:flutter/material.dart';
import 'colors.dart';

class ThemeProvider with ChangeNotifier {
  int _themeIndex = 0;
  Locale _locale = const Locale('vi');

  int get themeIndex => _themeIndex;
  Locale get locale => _locale;

  ThemeData getTheme() {
    if (_themeIndex == 0) {
      return ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      );
    } else {
      return ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      );
    }
  }

  void setTheme(int themeIndex) {
    _themeIndex = themeIndex;
    notifyListeners();
  }

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }
}
