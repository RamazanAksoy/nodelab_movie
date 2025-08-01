import 'package:flutter/material.dart';

class ApplicationItem {
  ApplicationItem._init() {
    rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  }
  static ApplicationItem? _instance;
  static ApplicationItem get instance {
    _instance ??= ApplicationItem._init();
    return _instance!;
  }

  GlobalKey<ScaffoldMessengerState>? rootScaffoldMessengerKey;

  BuildContext get context {
    if (rootScaffoldMessengerKey?.currentState?.context == null || rootScaffoldMessengerKey == null) {
      throw Exception('context is empty');
    }
    return rootScaffoldMessengerKey!.currentState!.context;
  }
}
