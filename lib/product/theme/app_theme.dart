import '/product/theme/color/dark_color_theme.dart';
import '/product/theme/color/i_color_theme.dart';
import '/product/theme/color/light_color_theme.dart';
import '/product/theme/text/dart_theme.dart';
import '/product/theme/text/i_text_theme.dart';
import '/product/theme/text/light_text_theme.dart';
import 'package:flutter/material.dart';

abstract class ITheme {
  ITextTheme get textTheme;
  IColorTheme get colorTheme;
}

class AppThemeLight extends ITheme {
  @override
  IColorTheme get colorTheme => LightColor();

  @override
  ITextTheme get textTheme => LightTextTheme();
}

class AppThemeDark extends ITheme {
  @override
  IColorTheme get colorTheme => DarkColor();

  @override
  ITextTheme get textTheme => DarkTextTheme();
}

abstract class ThemeManager {
  static ThemeData createTheme(ITheme theme) {
    return ThemeData(
      textTheme: textTheme(theme),
      fontFamily: theme.textTheme.fontFamily,
      colorScheme: theme.colorTheme.colorScheme,
      brightness: theme.colorTheme.brightness,
    );
  }

  static TextTheme textTheme(ITheme theme) {
    return TextTheme(
      displayLarge: theme.textTheme.displayLarge,
      displayMedium: theme.textTheme.displayMedium,
      displaySmall: theme.textTheme.displaySmall,
      headlineLarge: theme.textTheme.headlineLarge,
      headlineMedium: theme.textTheme.headlineMedium,
      headlineSmall: theme.textTheme.headlineSmall,
      labelLarge: theme.textTheme.labelLarge,
      labelMedium: theme.textTheme.labelMedium,
      labelSmall: theme.textTheme.labelSmall,
      bodyLarge: theme.textTheme.bodyLarge,
      bodyMedium: theme.textTheme.bodyMedium,
      bodySmall: theme.textTheme.bodySmall,
      titleLarge: theme.textTheme.titleLarge,
      titleMedium: theme.textTheme.titleMedium,
      titleSmall: theme.textTheme.titleSmall,
    );
  }
}
