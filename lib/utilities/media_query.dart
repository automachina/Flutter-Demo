import 'package:flutter/material.dart';

extension MediaQueryExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get screenSize => mediaQuery.size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  Offset get screenCenter => Offset(screenWidth / 2, screenHeight / 2);
  double get statusBarHeight => mediaQuery.padding.top;
}
