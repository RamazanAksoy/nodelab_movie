import 'package:flutter/material.dart';
import '/product/theme/text/i_text_theme.dart';

class DarkTextTheme implements ITextTheme {
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

  DarkTextTheme() {
    displayLarge = ThemeData.dark().textTheme.displayLarge?.copyWith();
    displayMedium = ThemeData.dark().textTheme.displayMedium?.copyWith();
    displaySmall = ThemeData.dark().textTheme.displaySmall?.copyWith();
    headlineLarge = ThemeData.dark().textTheme.headlineLarge?.copyWith();
    headlineMedium = ThemeData.dark().textTheme.headlineMedium?.copyWith();
    headlineSmall = ThemeData.dark().textTheme.headlineSmall?.copyWith();
    bodyLarge = ThemeData.dark().textTheme.bodyLarge?.copyWith();
    bodyMedium = ThemeData.dark().textTheme.bodyMedium?.copyWith();
    bodySmall = ThemeData.dark().textTheme.bodySmall?.copyWith();
    titleLarge = ThemeData.dark().textTheme.titleLarge?.copyWith();
    titleMedium = ThemeData.dark().textTheme.titleMedium?.copyWith();
    titleSmall = ThemeData.dark().textTheme.titleSmall?.copyWith();
    labelLarge = ThemeData.dark().textTheme.labelLarge?.copyWith();
    labelMedium = ThemeData.dark().textTheme.labelMedium?.copyWith();
    labelSmall = ThemeData.dark().textTheme.labelSmall?.copyWith();
  }
}
