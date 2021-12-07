import 'package:flutter/material.dart';

class ThemeModel {
  var _themeMode = ThemeMode.system;

  final _darkThemeData = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.grey[900],
  );
  ThemeData get darkTheme => _darkThemeData;

  final _lightThemeData = ThemeData.light();
  ThemeData get lightTheme => _lightThemeData;

  ThemeMode get currentTheme => _themeMode;

  ThemeModel toggleTheme(BuildContext context) {
    _themeMode = Theme.of(context).brightness == Brightness.dark ? ThemeMode.light : ThemeMode.dark;
    return this;
  }
}
