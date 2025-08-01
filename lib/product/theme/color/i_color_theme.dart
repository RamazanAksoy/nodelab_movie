import 'package:flutter/material.dart';

class AppColors {
  final white = const Color(0xffFFFFFF);
  final white2 = const Color(0xffF8F8FB);
  final white3 = const Color(0xffE0E3E6);
  final grey = const Color(0xffABAFB3);
  final black = const Color(0xff0A0A0A);
  final appleBlack = const Color(0xff282a2e);
  final tBlue = const Color(0xff1DA1F2);
  final green = const Color(0xff3A6427);
  final red = const Color(0xffED6461);
  final blue = const Color(0xff1377FE);
  final blue2 = const Color(0xffE7F1FF);
}

abstract class IColorTheme {
  AppColors get color;
  Color? background;
  Brightness? brightness;
  ColorScheme? colorScheme;
}
