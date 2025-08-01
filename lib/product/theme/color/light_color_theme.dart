// light_color_theme.dart
import 'package:flutter/material.dart';
import 'i_color_theme.dart';

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
    colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFFE50914),
      brightness: Brightness.light,
      primary: const Color.fromARGB(154, 255, 26, 37),
      onPrimary: const Color.fromARGB(255, 0, 0, 0),
      background: const Color(0xFFF8F8FB),
      onBackground: Colors.black87,
      onSecondary: const Color.fromARGB(247, 58, 57, 57),
    );
    brightness = Brightness.light;
    background = colorScheme?.background;
  }
}
