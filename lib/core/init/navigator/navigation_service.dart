import 'package:flutter/material.dart';

class NavigationService {
  static NavigationService? _instace;
  static NavigationService? get instance {
    _instace ??= NavigationService._init();
    return _instace;
  }

  NavigationService._init();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState? get _navigator => navigatorKey.currentState;

  Future<T?>? pushNamed<T extends Object?>(String routeName, {Object? arguments}) {
    return _navigator?.pushNamed<T>(routeName, arguments: arguments);
  }

  Future<T?>? pushReplacementNamed<T extends Object?, TO extends Object?>(String routeName, {TO? result, Object? arguments}) {
    return _navigator?.pushReplacementNamed<T, TO>(routeName, arguments: arguments, result: result);
  }

  Future<T?>? push<T extends Object?>(Route<T> route) {
    return _navigator?.push(route);
  }

  void pop<T extends Object?>([T? result]) {
    return _navigator?.pop(result);
  }

  void popUntil(String routeName) {
    _navigator?.popUntil(ModalRoute.withName(routeName));
  }

  void popUntilRoot() {
    _navigator?.popUntil((route) => route.isFirst);
  }

  Future<T?>? pushNamedAndRemoveUntil<T extends Object?>(String routeName, bool Function(Route<dynamic>) predicate, {Object? arguments}) {
    return _navigator?.pushNamedAndRemoveUntil<T>(routeName, predicate, arguments: arguments);
  }

  bool canPop() => _navigator?.canPop() ?? false;
}
