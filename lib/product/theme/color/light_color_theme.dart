import '/product/theme/color/i_color_theme.dart';
import 'package:flutter/material.dart';

class LightColor implements IColorTheme {
  @override
  Color? background;

  @override
  Brightness? brightness;

  @override
  ColorScheme? colorScheme;

  @override
  AppColors color = AppColors();

  LightColor() {
    colorScheme = ThemeData.light().colorScheme.copyWith(primary: color.red);
    brightness = ThemeData.light().brightness;
    background = ThemeData.light().scaffoldBackgroundColor;
  }
}
