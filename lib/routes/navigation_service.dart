import 'package:flutter/material.dart';

class NavigationService {
  NavigationService._();
  static NavigationService instance = NavigationService._();
  final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  Future<dynamic> pushNamed<T>(String routeName, {T? arguments}) async {
    return navigationKey.currentState?.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  Future<dynamic> pushAndRemove<T>(String routeName, {T? arguments}) async {
    return navigationKey.currentState?.pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }
}
