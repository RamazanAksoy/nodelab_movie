import '../../extension/string_extension.dart';

class AppImages {
  AppImages._init();
  static AppImages? _instace;
  static AppImages get instance => _instace ??= AppImages._init();

  String approvalsIcon = 'test'.toPNG;
  String backButton = 'back_button'.toPNG;
  String movieLogo = 'movie_logo'.toPNG;
  String coin70 = 'coin_70'.toPNG;
  String coin35 = 'coin_35'.toPNG;
  String coin10 = 'coin_10'.toPNG;
  String frame70 = 'frame_70'.toPNG;
  String frame35 = 'frame_35'.toPNG;
  String frame10 = 'frame_10'.toPNG;
  String pro1 = 'pro1'.toPNG;
  String pro2 = 'pro2'.toPNG;
  String pro3 = 'pro3'.toPNG;
  String pro4 = 'pro4'.toPNG;
  String ellipse = 'ellipse'.toPNG;
}
