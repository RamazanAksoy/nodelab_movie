import 'package:flutter/material.dart';

import '../../feature/login/view/login_screen.dart';
import '../../feature/profile/view/photo_upload_view.dart';
import '../../feature/register/view/register_screen.dart';
import '../widget/bottom_nav_bar.dart';

class AppRoutes {
  static const String register = '/register';
  static const String login = '/login';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String photoUpload = '/photoUpload';

  static Map<String, WidgetBuilder> get routes => {
    login: (_) => LoginScreen(),
    register: (_) => RegisterScreen(),
    home: (_) => MainScreen(),
    photoUpload: (_) => PhotoUploadScreen(),
  };
}
