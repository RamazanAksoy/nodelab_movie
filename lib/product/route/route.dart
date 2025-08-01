import 'package:flutter/material.dart';

import '../../feature/login/view/login_screen.dart';

class AppRoutes {
  static const String login = '/login';

  static Map<String, WidgetBuilder> get routes => {login: (_) => LoginScreen()};
}
