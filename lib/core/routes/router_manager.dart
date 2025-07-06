import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/routes/app_router.dart';
import 'package:tzwad_mobile/core/routes/app_routes.dart';
import 'package:tzwad_mobile/core/util/app_context.dart';
import 'package:tzwad_mobile/features/auth/ui/change_password/view/change_password_view.dart';
import 'package:tzwad_mobile/features/auth/ui/forget_password/view/forget_password_view.dart';
import 'package:tzwad_mobile/features/auth/ui/login_buyer/view/login_buyer_view.dart';
import 'package:tzwad_mobile/features/auth/ui/login_supplier/view/login_supplier_view.dart';
import 'package:tzwad_mobile/features/auth/ui/otp/view/otp_view.dart';
import 'package:tzwad_mobile/features/auth/ui/register_buyer/view/register_buyer_view.dart';
import 'package:tzwad_mobile/features/auth/ui/register_supplier/view/register_supplier_view.dart';
import 'package:tzwad_mobile/features/auth/ui/reset_password/view/reset_password_view.dart';
import 'package:tzwad_mobile/features/category/ui/categories/view/categories_view.dart';
import 'package:tzwad_mobile/features/category/ui/category_details/view/category_details_view.dart';
import 'package:tzwad_mobile/features/generic/ui/under_develop_view.dart';
import 'package:tzwad_mobile/features/home/ui/home_supplier/view/home_supplier_view.dart';
import 'package:tzwad_mobile/features/order/ui/order_details/view/order_details_view.dart';
import 'package:tzwad_mobile/features/order/ui/orders/view/orders_view.dart';
import 'package:tzwad_mobile/features/product/ui/cart/view/cart_view.dart';
import 'package:tzwad_mobile/features/product/ui/favorite_products/view/favorite_products_view.dart';
import 'package:tzwad_mobile/features/generic/ui/onboarding/view/onboarding_view.dart';
import 'package:tzwad_mobile/features/generic/ui/settings/view/settings_view.dart';
import 'package:tzwad_mobile/features/generic/ui/splash/view/splash_view.dart';
import 'package:tzwad_mobile/features/generic/ui/trems_conditions/view/trems_conditions_view.dart';
import 'package:tzwad_mobile/features/generic/ui/undefined_route/view/undefined_route_view.dart';
import 'package:tzwad_mobile/features/generic/ui/nav_bar/view/nav_bar_view.dart';
import 'package:tzwad_mobile/features/product/ui/product_details/view/product_details_view.dart';
import 'package:tzwad_mobile/features/product/ui/products/view/products_view.dart';
import 'package:tzwad_mobile/features/product/ui/search/view/search_view.dart';

class RouterManager {
  static final GoRouter router = GoRouter(
    navigatorKey: AppContext.navigatorKey,
    initialLocation: AppRoutes.splashRoute,
    routes: [
      AppRouter(
        route: AppRoutes.underDevelopmentRoute,
        screen: const UnderDevelopView(),
      ),
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
        route: AppRoutes.loginBuyerRoute,
        screen: const LoginBuyerView(),
      ),
      AppRouter(
        route: AppRoutes.loginSupplierRoute,
        screen: const LoginSupplierView(),
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
        route: AppRoutes.changePasswordRoute,
        screen: const ChangePasswordView(),
      ),
      AppRouter(
        route: AppRoutes.otpRoute,
        screen: const OtpView(),
      ),
      AppRouter(
        route: AppRoutes.registerBuyerRoute,
        screen: const RegisterBuyerView(),
      ),
      AppRouter(
        route: AppRoutes.registerSupplierRoute,
        screen: const RegisterSupplierView(),
      ),
      AppRouter(
        route: AppRoutes.productsRoute,
        screen: const ProductsView(),
      ),
      AppRouter(
        route: AppRoutes.productDetailsRoute,
        screen: const ProductDetailsView(),
      ),
      AppRouter(
        route: AppRoutes.categoriesRoute,
        screen: const CategoriesView(),
      ),
      AppRouter(
        route: AppRoutes.categoryDetailsRoute,
        screen: const CategoryDetailsView(),
      ),
      AppRouter(
        route: AppRoutes.ordersRoute,
        screen: const OrdersView(),
      ),
      AppRouter(
        route: AppRoutes.orderDetailsRoute,
        screen: const OrderDetailsView(),
      ),
      AppRouter(
        route: AppRoutes.homeSupplierRoute,
        screen: const HomeSupplierView(),
      ),
      ShellRoute(
        builder: (context, state, child) => NavBarView(child: child),
        routes: [
          AppRouter(
            route: AppRoutes.homeBuyerRoute,
            screen: const HomeSupplierView(),
          ),
          AppRouter(
            route: AppRoutes.searchRoute,
            screen: const SearchView(),
          ),
          AppRouter(
            route: AppRoutes.cartRoute,
            screen: const CartView(),
          ),
          AppRouter(
            route: AppRoutes.favoriteProductsRoute,
            screen: const FavoriteProductsView(),
          ),
          AppRouter(
            route: AppRoutes.settingsRoute,
            screen: const SettingsView(),
          ),
        ],
      ),

      // ShellRoute(
      //   builder: (context, state, child) => NavBarView(child: child),
      //   routes: [
      //     AppRouter(
      //       route: AppRoutes.homeSupplierRoute,
      //       screen: const HomeSupplierView(),
      //     ),
      //     AppRouter(
      //       route: AppRoutes.searchRoute,
      //       screen: const SearchView(),
      //     ),
      //     AppRouter(
      //       route: AppRoutes.cartRoute,
      //       screen: const CartView(),
      //     ),
      //     AppRouter(
      //       route: AppRoutes.favoriteProductsRoute,
      //       screen: const FavoriteProductsView(),
      //     ),
      //     AppRouter(
      //       route: AppRoutes.settingsRoute,
      //       screen: const SettingsView(),
      //     ),
      //   ],
      // ),
    ],
    errorBuilder: (context, state) => const UnDefinedRouteView(),
  );
}
