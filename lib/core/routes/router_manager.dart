import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/routes/app_router.dart';
import 'package:tzwad_mobile/core/routes/app_routes.dart';
import 'package:tzwad_mobile/core/util/app_context.dart';
import 'package:tzwad_mobile/features/auth/models/role_enum.dart';
import 'package:tzwad_mobile/features/auth/ui/change_password/view/change_password_view.dart';
import 'package:tzwad_mobile/features/auth/ui/forget_password/view/forget_password_view.dart';
import 'package:tzwad_mobile/features/auth/ui/login_buyer/view/login_buyer_view.dart';
import 'package:tzwad_mobile/features/auth/ui/login_supplier/view/login_supplier_view.dart';
import 'package:tzwad_mobile/features/auth/ui/otp/view/otp_view.dart';
import 'package:tzwad_mobile/features/auth/ui/register_buyer/view/register_buyer_view.dart';
import 'package:tzwad_mobile/features/auth/ui/register_supplier/view/register_supplier_view.dart';
import 'package:tzwad_mobile/features/auth/ui/reset_password/view/reset_password_view.dart';
import 'package:tzwad_mobile/features/buyer/cart/ui/cart/view/cart_view.dart';
import 'package:tzwad_mobile/features/buyer/home/view/home_buyer_view.dart';
import 'package:tzwad_mobile/features/buyer/supplier/ui/supplier_details/view/supplier_details_view.dart';
import 'package:tzwad_mobile/features/buyer/supplier/ui/suppliers/view/suppliers_view.dart';
import 'package:tzwad_mobile/features/category/ui/categories_supplier/view/categories_supplier_view.dart';
import 'package:tzwad_mobile/features/generic/ui/more/view/more_buyer_view.dart';
import 'package:tzwad_mobile/features/generic/ui/more/view/more_supplier_view.dart';
import 'package:tzwad_mobile/features/generic/ui/under_develop_view.dart';
import 'package:tzwad_mobile/features/home/ui/home_supplier/view/home_supplier_view.dart';
import 'package:tzwad_mobile/features/nav_bar/view/nav_bar_view.dart';
import 'package:tzwad_mobile/features/order/ui/order_details/view/order_details_view.dart';
import 'package:tzwad_mobile/features/order/ui/order_supplier/view/orders_supplier_view.dart';
import 'package:tzwad_mobile/features/order/ui/orders_buyer/view/orders_buyer_view.dart';
import 'package:tzwad_mobile/features/product/models/add_supplier_product_request_model.dart';
import 'package:tzwad_mobile/features/product/ui/favorite_products/view/favorite_products_view.dart';
import 'package:tzwad_mobile/features/generic/ui/onboarding/view/onboarding_view.dart';
import 'package:tzwad_mobile/features/generic/ui/splash/view/splash_view.dart';
import 'package:tzwad_mobile/features/generic/ui/trems_conditions/view/trems_conditions_view.dart';
import 'package:tzwad_mobile/features/generic/ui/undefined_route/view/undefined_route_view.dart';
import 'package:tzwad_mobile/features/product/ui/products_supplier/view/add_product_supplier_view.dart';
import 'package:tzwad_mobile/features/product/ui/products_supplier/view/products_supplier_view.dart';

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
        route: AppRoutes.suppliersRoute,
        screen: const SuppliersView(),
      ),
      AppRouter(
        route: AppRoutes.supplierDetailsRoute,
        screen: const SupplierDetailsView(),
      ),
      AppRouter(
        route: AppRoutes.orderDetailsRoute,
        screen: const OrderDetailsView(),
      ),
      AppRouter(
        route: AppRoutes.cartRoute,
        screen: const CartView(),
      ),
      ShellRoute(
        builder: (context, state, child) => NavBarView(
          role: RoleEnum.buyer,
          child: child,
        ),
        routes: [
          AppRouter(
            route: AppRoutes.homeBuyerRoute,
            screen: const HomeBuyerView(),
          ),
          AppRouter(
            route: AppRoutes.ordersBuyerRoute,
            screen: const OrdersBuyerView(),
          ),
          AppRouter(
            route: AppRoutes.favoriteProductsRoute,
            screen: const FavoriteProductsView(),
          ),
          AppRouter(
            route: AppRoutes.moreBuyerRoute,
            screen: const MoreBuyerView(),
          ),
        ],
      ),

      ShellRoute(
        builder: (context, state, child) => NavBarView(
          role: RoleEnum.supplier,
          child: child,
        ),
        routes: [
          AppRouter(
            route: AppRoutes.homeSupplierRoute,
            screen: const HomeSupplierView(),
          ),
          AppRouter(
            route: AppRoutes.ordersSupplier,
            screen: const OrdersSupplierView(),
          ),
          AppRouter(
            route: AppRoutes.categoriesSupplierRoute,
            screen: const CategoriesSupplierView(),
          ),
          AppRouter(
            route: AppRoutes.productsSupplierRoute,
            screen: const ProductsSupplierView(),
          ),
          AppRouter(
            route: AppRoutes.addProductSupplierView,
            builder: (context, state) {
              if(state.extra==null){
                return const AddProductSupplierView();
              }
              final model = state.extra as AddSupplierProductRequestModel;
              return AddProductSupplierView(model: model);
            },
          ),

          AppRouter(
            route: AppRoutes.moreSupplierRoute,
            screen: const MoreSupplierView(),
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
