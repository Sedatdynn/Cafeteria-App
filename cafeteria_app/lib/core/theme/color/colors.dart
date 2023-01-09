import 'package:flutter/material.dart';

class AppColors {
  static const Color mainPrimary = Color(0xffff5f00);
  static const int _primaryColor = 0xffff5f00;
  static const Map<int, Color> _swatch = <int, Color>{
    50: Color.fromARGB(24, 220, 85, 1),
    100: Color.fromARGB(24, 220, 85, 2),
    200: Color.fromARGB(24, 220, 85, 3),
    300: Color.fromARGB(24, 220, 85, 4),
    400: Color.fromARGB(24, 220, 85, 5),
    500: Color.fromARGB(24, 220, 85, 6),
    600: Color.fromARGB(24, 220, 85, 7),
    700: Color.fromARGB(24, 220, 85, 8),
    800: Color.fromARGB(24, 220, 85, 9),
    900: Color.fromARGB(24, 220, 85, 1),
  };

  static const MaterialColor primarySwatch =
      MaterialColor(_primaryColor, _swatch);

  /// White color.
  static const Color white = Color.fromRGBO(255, 255, 255, 1);

  /// White color.
  static const Color black = Color(0xff0d0d0d);

  /// Green color.
  static const Color green = Color(0xff00b33c);

  /// Light grey color.
  static const Color lightGrey = Color.fromRGBO(224, 224, 224, 1);

  /// Divider orange color.
  static const Color divider = Color(0xffff5f00);

  /// Drawer items indigo color
  static const Color indigo = Color.fromRGBO(63, 81, 181, 1);

  /// Selected container Light Indigo Color
  static const Color lightIndigo = Color.fromRGBO(197, 202, 233, 1);

  /// Dark grey color.
  static const Color darkGrey = Color(0xff4e5d6a);

  /// Error color.
  static const Color error = Color(0xffff3333);

  /// Color for loading bubbles.
  static const Color loadingColor = Color(0xff708edf);
}
