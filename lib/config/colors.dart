import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  static const Color colorPrimary = Color(0xFF31A4ED);
  static const Color colorPrimaryDark = const Color(0xFFFE2500);
  static const Color colorAccent = const Color(0xFF62D806);
  static const Color white = const Color(0xFFFFFFFF);

  static const MaterialColor colorPrimarySwatch = MaterialColor(0xFFFBFF36, {
    50: Color.fromRGBO(251, 255, 54, .1),
    100: Color.fromRGBO(251, 255, 54, .2),
    200: Color.fromRGBO(251, 255, 54, .3),
    300: Color.fromRGBO(251, 255, 54, .4),
    400: Color.fromRGBO(251, 255, 54, .5),
    500: Color.fromRGBO(251, 255, 54, .6),
    600: Color.fromRGBO(251, 255, 54, .7),
    700: Color.fromRGBO(251, 255, 54, .8),
    800: Color.fromRGBO(251, 255, 54, .9),
    900: Color.fromRGBO(251, 255, 54, 1),
  });
}
