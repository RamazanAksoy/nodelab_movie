import '/product/theme/text/i_text_theme.dart';
import 'package:flutter/material.dart';

class LightTextTheme implements ITextTheme {
  @override
  TextStyle? displayLarge;

  @override
  TextStyle? displayMedium;

  @override
  TextStyle? displaySmall;

  @override
  TextStyle? headlineLarge;

  @override
  TextStyle? headlineMedium;

  @override
  TextStyle? headlineSmall;

  @override
  TextStyle? labelLarge;

  @override
  TextStyle? labelMedium;

  @override
  TextStyle? labelSmall;

  @override
  TextStyle? bodyLarge;

  @override
  TextStyle? bodyMedium;

  @override
  TextStyle? bodySmall;

  @override
  TextStyle? titleLarge;

  @override
  TextStyle? titleMedium;

  @override
  TextStyle? titleSmall;

  @override
  String? fontFamily;

  LightTextTheme() {
    displayLarge = ThemeData.light().textTheme.displayLarge?.copyWith();
    displayMedium = ThemeData.light().textTheme.displayMedium?.copyWith();
    displaySmall = ThemeData.light().textTheme.displaySmall?.copyWith();
    headlineLarge = ThemeData.light().textTheme.headlineLarge?.copyWith();
    headlineMedium = ThemeData.light().textTheme.headlineMedium?.copyWith();
    headlineSmall = ThemeData.light().textTheme.headlineSmall?.copyWith();
    bodyLarge = ThemeData.light().textTheme.bodyLarge?.copyWith();
    bodyMedium = ThemeData.light().textTheme.bodyMedium?.copyWith();
    bodySmall = ThemeData.light().textTheme.bodySmall?.copyWith();
    titleLarge = ThemeData.light().textTheme.titleLarge?.copyWith();
    titleMedium = ThemeData.light().textTheme.titleMedium?.copyWith();
    titleSmall = ThemeData.light().textTheme.titleSmall?.copyWith();
    labelLarge = ThemeData.light().textTheme.labelLarge?.copyWith();
    labelMedium = ThemeData.light().textTheme.labelMedium?.copyWith();
    labelSmall = ThemeData.light().textTheme.labelSmall?.copyWith();
  }
}
