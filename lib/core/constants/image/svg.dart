import '/core/extension/string_extension.dart';

class AppSVG {
  AppSVG._init();
  static AppSVG? _instace;
  static AppSVG get instance {
    return _instace ??= AppSVG._init();
  }

  final iconTest = 'test'.toSVG;
}
