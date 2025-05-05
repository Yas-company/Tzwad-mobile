import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/routes/app_routes.dart';
import 'package:tzwad_mobile/core/util/app_context.dart';
import 'package:tzwad_mobile/features/auth/ui/login/view/login_view.dart';
import 'package:tzwad_mobile/features/auth/ui/register/view/register_view.dart';
import 'package:tzwad_mobile/features/generic/ui/onboarding/view/onboarding_view.dart';
import 'package:tzwad_mobile/features/generic/ui/splash/view/splash_view.dart';
import 'package:tzwad_mobile/features/generic/ui/undefined_route/view/undefined_route_view.dart';

class RouterManager {
  static final GoRouter router = GoRouter(
    navigatorKey: AppContext.navigatorKey,
    initialLocation: AppRoutes.splashRoute,
    routes: [
      GoRoute(
        path: AppRoutes.splashRoute,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: AppRoutes.onboardingRoute,
        builder: (context, state) => const OnboardingView(),
      ),
      GoRoute(
        path: AppRoutes.loginRoute,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        name: AppRoutes.registerRoute,
        path: AppRoutes.registerRoute,
        builder: (context, state) => const RegisterView(),
      ),
      // ShellRoute(
      //   builder: (context, state, child) => SizedBox(child: child),
      //   routes: [],
      // ),
    ],
    errorBuilder: (context, state) => UnDefinedRouteView(),
  );
}
