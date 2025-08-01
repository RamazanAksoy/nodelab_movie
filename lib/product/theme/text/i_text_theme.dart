import 'package:flutter/material.dart';

abstract class ITextTheme {
  TextStyle? displayLarge;
  TextStyle? displayMedium;
  TextStyle? displaySmall;
  TextStyle? headlineLarge;
  TextStyle? headlineMedium;
  TextStyle? headlineSmall;
  TextStyle? bodyLarge;
  TextStyle? bodyMedium;
  TextStyle? bodySmall;
  TextStyle? titleLarge;
  TextStyle? titleMedium;
  TextStyle? titleSmall;
  TextStyle? labelLarge;
  TextStyle? labelMedium;
  TextStyle? labelSmall;

  String? fontFamily;

  ITextTheme();
}
