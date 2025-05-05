import 'package:flutter/material.dart';

class AppContext {
  static final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  static get navigatorKey => _navigatorKey;

  static BuildContext get context => _navigatorKey.currentState!.context;
}
