import 'package:flutter_dotenv/flutter_dotenv.dart';

import '/core/constants/app/app_constants.dart';

extension ImagePathExtension on String {
  String get toSVG => '${ApplicationConstants.SVG_ASSET_PATH}$this.svg';
}

extension ImagePngPathExtension on String {
  String get toPNG => '${ApplicationConstants.IMAGE_ASSET_PATH}$this.png';
}

extension DotenvExtension on String {
  String get toEnv => dotenv.env[this] ?? '';
}

extension StringExtention on String {
  String getFirstWords(String? sentence, int wordCounts) {
    try {
      return sentence!.split(" ").sublist(0, wordCounts).join(" ");
    } catch (e) {
      return sentence!;
    }
  }
}
