import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'app_args.dart';

class AppRouter extends GoRoute {
  final String route;
  final Widget screen;
  final List<GoRoute> subRoutes;
  final bool withAnimation;

  AppRouter({
    required this.route,
    required this.screen,
    this.subRoutes = const [],
    this.withAnimation = false,
  }) : super(
          path: route,
          name: route,
          routes: subRoutes,
          pageBuilder: (context, state) {
            final args = _extractArgs(state);
            setArgs(route, args);
            // 'AppRouter route: $route, args: $args ${_getUniqueKey()}'.log();
            // final uniqueKey = ValueKey(_getUniqueKey());
            if (withAnimation) {
              return CustomTransitionPage(
                child: screen,
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: screen);
                },
                transitionDuration: const Duration(milliseconds: 1000),
              );
            }
            return NoTransitionPage(
              child: screen,
            );
          },
        );

  static Map<String, dynamic> _extractArgs(GoRouterState state) {
    final args = <String, dynamic>{};
    args.addAll(state.pathParameters);
    args.addAll(state.uri.queryParameters);
    if (state.extra is Map<String, dynamic>) {
      args.addAll(state.extra as Map<String, dynamic>);
    }
    return args;
  }

  static String _getUniqueKey() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}
