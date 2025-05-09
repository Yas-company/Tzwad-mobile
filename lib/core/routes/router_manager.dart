import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/routes/app_router.dart';
import 'package:tzwad_mobile/core/routes/app_routes.dart';
import 'package:tzwad_mobile/core/util/app_context.dart';
import 'package:tzwad_mobile/features/auth/ui/forget_password/view/forget_password_view.dart';
import 'package:tzwad_mobile/features/auth/ui/login/view/login_view.dart';
import 'package:tzwad_mobile/features/auth/ui/otp/view/otp_view.dart';
import 'package:tzwad_mobile/features/auth/ui/register/view/register_view.dart';
import 'package:tzwad_mobile/features/auth/ui/reset_password/reset_password_view.dart';
import 'package:tzwad_mobile/features/favorite/ui/favorite_view.dart';
import 'package:tzwad_mobile/features/generic/ui/onboarding/view/onboarding_view.dart';
import 'package:tzwad_mobile/features/generic/ui/settings/view/settings_view.dart';
import 'package:tzwad_mobile/features/generic/ui/splash/view/splash_view.dart';
import 'package:tzwad_mobile/features/generic/ui/trems_conditions/view/trems_conditions_view.dart';
import 'package:tzwad_mobile/features/generic/ui/undefined_route/view/undefined_route_view.dart';
import 'package:tzwad_mobile/features/home/ui/home_view.dart';
import 'package:tzwad_mobile/features/nav_bar/ui/view/nav_bar_view.dart';
import 'package:tzwad_mobile/features/search/ui/search_view.dart';

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
        route: AppRoutes.termsConditionsRoute,
        screen: const TermsConditionsView(),
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
        route: AppRoutes.resetPasswordRoute,
        screen: const ResetPasswordView(),
      ),
      AppRouter(
        route: AppRoutes.otpRoute,
        screen: const OtpView(),
      ),
      AppRouter(
        route: AppRoutes.registerRoute,
        screen: const RegisterView(),
      ),
      ShellRoute(
        builder: (context, state, child) => NavBarView(child: child),
        routes: [
          AppRouter(
            route: AppRoutes.homeRoute,
            screen: const HomeView(),
          ),
          AppRouter(
            route: AppRoutes.searchRoute,
            screen: const SearchView(),
          ),
          AppRouter(
            route: AppRoutes.cartRoute,
            screen: const FavoriteView(),
          ),
          AppRouter(
            route: AppRoutes.favoriteRoute,
            screen: const FavoriteView(),
          ),
          AppRouter(
            route: AppRoutes.settingsRoute,
            screen: const SettingsView(),
          ),
        ],
      )
    ],
    errorBuilder: (context, state) => const UnDefinedRouteView(),
  );
}
