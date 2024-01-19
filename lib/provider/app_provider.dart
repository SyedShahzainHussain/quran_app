import 'package:flutter/material.dart';

// final themeMap = {
//   "dark": ThemeMode.dark,
//   "light": ThemeMode.light,
// };

class AppProvider with ChangeNotifier {
  ThemeMode? _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode!;
  bool get isDark => _themeMode == ThemeMode.dark;

  void setTheme(ThemeMode themeMode) {
    if (_themeMode == themeMode) {
      return;
    }
    _themeMode = themeMode;
    notifyListeners();
  }
}
