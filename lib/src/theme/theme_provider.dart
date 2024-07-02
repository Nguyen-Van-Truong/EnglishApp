// lib/src/theme/theme_provider.dart
import 'package:flutter/material.dart';
import 'colors.dart';

class ThemeProvider with ChangeNotifier {
  int _themeIndex = 2; // Đặt giá trị mặc định là 2 cho theme màu vàng
  Locale _locale = const Locale('en');

  int get themeIndex => _themeIndex;
  Locale get locale => _locale;

  ThemeData getTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.getColor(_themeIndex, 'navigationBarBackground')),
      useMaterial3: true,
    );
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
