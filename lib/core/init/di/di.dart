import 'package:easy_localization/easy_localization.dart';

import '../../../product/mixin/env_manager.dart';
import '/core/init/cache/locale_manager.dart';

import '../network/network_manager.dart';

class DependencyInjection {
  static Future<void> init() async {
    await Future.wait([EnvManager.loadDotEnv(), LocaleManager.prefrencesInit(), EasyLocalization.ensureInitialized()]);
    NetworkManager.instance?.coreDio;
  }
}
