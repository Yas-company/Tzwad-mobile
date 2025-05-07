import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/routes/app_router.dart';
import 'package:tzwad_mobile/core/routes/app_routes.dart';
import 'package:tzwad_mobile/core/util/app_context.dart';
import 'package:tzwad_mobile/features/auth/ui/forget_password/view/forget_password_view.dart';
import 'package:tzwad_mobile/features/auth/ui/login/view/login_view.dart';
import 'package:tzwad_mobile/features/auth/ui/otp/view/otp_view.dart';
import 'package:tzwad_mobile/features/auth/ui/register/view/register_view.dart';
import 'package:tzwad_mobile/features/generic/ui/onboarding/view/onboarding_view.dart';
import 'package:tzwad_mobile/features/generic/ui/splash/view/splash_view.dart';
import 'package:tzwad_mobile/features/generic/ui/undefined_route/view/undefined_route_view.dart';
import 'package:tzwad_mobile/features/nav_bar/ui/view/nav_bar_view.dart';

class RouterManager {
  static final GoRouter router = GoRouter(
    navigatorKey: AppContext.navigatorKey,
    initialLocation: AppRoutes.splashRoute,
    routes: [
      AppRouter(
        route: AppRoutes.splashRoute,
        screen: const SplashView(),
      ),
      AppRouter(
        route: AppRoutes.onboardingRoute,
        screen: const OnboardingView(),
      ),
      AppRouter(
        route: AppRoutes.loginRoute,
        screen: const LoginView(),
      ),
      AppRouter(
        route: AppRoutes.forgetPasswordRoute,
        screen: const ForgetPasswordView(),
      ),
      AppRouter(
        route: AppRoutes.otpRoute,
        screen: const OtpView(),
      ),
      AppRouter(
        route: AppRoutes.registerRoute,
        screen: const RegisterView(),
      ),
      AppRouter(
        route: AppRoutes.navBarRoute,
        screen: const NavBarView(),
      ),
    ],
    errorBuilder: (context, state) => const UnDefinedRouteView(),
  );
}
