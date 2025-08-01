import 'package:dio/dio.dart';
import '/core/extension/string_extension.dart';
import '../../../product/network/header_query.dart';
import '../../constants/app/app_constants.dart';
import '../../constants/enums/preferences_types.dart';

import '../cache/locale_manager.dart';
import 'ICoreDio.dart';
import 'core_dio.dart';

class NetworkManager {
  static NetworkManager? _instance;
  static NetworkManager? get instance {
    _instance = NetworkManager._init();
    return _instance;
  }

  ICoreDioNullSafety? coreDio;

  NetworkManager._init() {
    final baseOptions = BaseOptions(
      headers: LocaleManager.instance.getStringValue(PreferencesTypes.token) != ''
          ? Map.fromEntries([HeaderQuery.token.rawValue(token: LocaleManager.instance.getStringValue(PreferencesTypes.token))])
          : {},
      baseUrl: ApplicationConstants.BASE_URL.toEnv,
    );

    coreDio = CoreDio(baseOptions);
  }
}
