import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'app_args.dart';

class AppRouter extends GoRoute {
  final String route;
  final Widget screen;
  final List<GoRoute> mRoutes;

  AppRouter({
    required this.route,
    required this.screen,
    this.mRoutes = const [],
  }) : super(
          path: route,
          name: route,
          routes: mRoutes,
          builder: (context, state) {
            setArgs(route, state.pathParameters);
            return screen;
          },
        );
}
