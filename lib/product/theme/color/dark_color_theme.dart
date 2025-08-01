// dark_color_theme.dart
import 'package:flutter/material.dart';
import 'i_color_theme.dart';

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
    colorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: const Color(0xFFE50914), // ✅ Primary kırmızı
      onPrimary: Colors.white,
      secondary: Colors.grey.shade800,
      onSecondary: Colors.grey,
      background: Colors.black,
      onBackground: Colors.white70,
      surface: Colors.grey.shade900,
      onSurface: Colors.white,
      error: Colors.redAccent,
      onError: Colors.white,
    );
  }
}
