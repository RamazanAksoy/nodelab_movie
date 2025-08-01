import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'core/constants/app/app_constants.dart';
import 'core/constants/enums/preferences_types.dart';
import 'core/init/cache/locale_manager.dart';
import 'core/init/di/di.dart';
import 'core/init/language/language_manager.dart';
import 'core/init/navigator/navigation_service.dart';
import 'core/init/theme/theme_service.dart';
import 'product/app/application_item.dart';
import 'product/route/route.dart';
import 'product/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjection.init();

  final token = LocaleManager.instance.getStringValue(PreferencesTypes.token);
  final langCode = LocaleManager.instance.getStringValue(PreferencesTypes.language);

  runApp(
    EasyLocalization(
      supportedLocales: LanguageManager.instance?.supportedLocales ?? [],
      path: ApplicationConstants.LANG_ASSET_PATH,
      startLocale: langCode.isNotEmpty ? Locale(langCode) : LanguageManager.instance?.trLocale,
      child: MyApp(isLoggedIn: token.isNotEmpty),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          scaffoldMessengerKey: ApplicationItem.instance.rootScaffoldMessengerKey,
          navigatorKey: NavigationService.instance?.navigatorKey,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          initialRoute: isLoggedIn ? AppRoutes.home : AppRoutes.login,
          routes: AppRoutes.routes,
          theme: ThemeManager.createTheme(AppThemeLight()),
          darkTheme: ThemeManager.createTheme(AppThemeDark()),
          themeMode: ThemeService().themeMode,
        );
      },
    );
  }
}
