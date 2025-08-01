import 'package:flutter/material.dart';
import '../../constants/enums/preferences_types.dart';
import '../cache/locale_manager.dart';

class ThemeService extends ChangeNotifier {
  final LocaleManager? localService = LocaleManager.instance;

  late ThemeMode _themeMode;

  ThemeService() {
    final isDark = localService?.getBoolValue(PreferencesTypes.theme) ?? true;
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  ThemeMode get themeMode => _themeMode;

  Future<void> setTheme(bool isDarkMode) async {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    await localService?.setBoolValue(PreferencesTypes.theme, isDarkMode);
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    final isDark = _themeMode == ThemeMode.dark;
    await setTheme(!isDark);
  }

  bool isDarkMode() => _themeMode == ThemeMode.dark;
}
