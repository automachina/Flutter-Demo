import 'package:flutter/material.dart';

extension ColorExtension on BuildContext {
  Color themedColor(Color lightColor, Color darkColor) =>
      Theme.of(this).brightness == Brightness.light ? lightColor : darkColor;
}
