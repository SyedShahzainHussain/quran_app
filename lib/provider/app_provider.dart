import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// final themeMap = {
//   "dark": ThemeMode.dark,
//   "light": ThemeMode.light,
// };

class AppProvider with ChangeNotifier {
  static const String themeKey = 'theme_mode';
  ThemeMode? _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode!;
  bool get isDark => _themeMode == ThemeMode.dark;

  AppProvider() {
    _loadTheme();
  }
  _loadTheme() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    int? themeValue = sp.getInt(themeKey);
    _themeMode =
        themeValue != null ? ThemeMode.values[themeValue] : ThemeMode.light;
    notifyListeners();
  }

  void setTheme(ThemeMode themeMode) async {
    if (_themeMode == themeMode) {
      return;
    }
    _themeMode = themeMode;
    notifyListeners();
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt(themeKey, _themeMode!.index);
  }
}
