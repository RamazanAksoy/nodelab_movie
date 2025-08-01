import 'package:flutter/material.dart';
import '/product/theme/color/i_color_theme.dart';

class DarkColor implements IColorTheme {
  @override
  Color? background;

  @override
  Brightness? brightness;

  @override
  ColorScheme? colorScheme;

  @override
  AppColors color = AppColors();
  DarkColor() {
    colorScheme = ThemeData.dark().colorScheme.copyWith();
    brightness = ThemeData.dark().brightness;
    background = ThemeData.dark().scaffoldBackgroundColor;
  }
}
