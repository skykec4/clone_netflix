import 'package:flutter/material.dart';

class Constant {
  //config dev or live
  // static const String config = 'live';
  static const String config = 'dev';

  static const String apiBaseUrl = 'https://api.themoviedb.org/3/';
  static const String apiKey = 'ce16f7da30a47ba16d9f038d895318bd';
  static const String language = 'ko-KR';

  //color
  static const int _colorMainInt = 0xff000000;
  static const Color colorMain = Color(0xff000000);

  static const MaterialColor colorMainMaterialColor =
      MaterialColor(_colorMainInt, {
    50: colorMain,
    100: colorMain,
    200: colorMain,
    300: colorMain,
    400: colorMain,
    500: colorMain,
    600: colorMain,
    700: colorMain,
    800: colorMain,
    900: colorMain,
  });
}
