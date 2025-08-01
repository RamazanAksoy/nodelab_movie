import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../core/constants/app/app_constants.dart';

mixin EnvManager {
  static Future<void> loadDotEnv() async {
    await dotenv.load(fileName: ApplicationConstants.ENV_ASSET_PATH);
  }
}
