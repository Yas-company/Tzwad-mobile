import 'package:flutter/material.dart';
import 'package:gren_mart/service/app_string_service.dart';
import 'package:gren_mart/service/campaign_card_list_service.dart';
import 'package:gren_mart/service/language_service.dart';
import 'package:gren_mart/service/terms_and_condition_service.dart';
import 'package:gren_mart/view/home/campaigns.dart';
import 'package:gren_mart/view/home/category_page.dart';
import 'package:gren_mart/view/home/category_product_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../../service/checkout_service.dart';
import '../../service/confirm_payment_service.dart';
import '../../service/review_service.dart';
import '../../service/social_login_service.dart';
import '../../view/home/all_camp_product_from_link.dart';
import '../../view/utils/text_themes.dart';
import '../../view/utils/web_view.dart';
import '../../service/payment_gateaway_service.dart';
import '../../service/shipping_zone_service.dart';
import '../../view/home/all_products.dart';
import '../../service/order_list_service.dart';
import '../../service/add_new_ticket_service.dart';
import '../../service/cupon_discount_service.dart';
import '../../service/auth_text_controller_service.dart';
import '../../service/cart_data_service.dart';
import '../../service/categories_data_service.dart';
import '../../service/change_password_service.dart';
import '../../service/country_dropdown_service.dart';
import '../../service/favorite_data_service.dart';
import '../../service/manage_account_service.dart';
import '../../service/poster_campaign_slider_service.dart';
import '../../service/product_card_data_service.dart';
import '../../service/product_details_service.dart';
import '../../service/reset_pass_otp_service.dart';
import '../../service/search_result_data_service.dart';
import '../../service/shipping_addresses_service.dart';
import '../../service/signin_signup_service.dart';
import '../../service/state_dropdown_service.dart';
import '../../service/ticket_chat_service.dart';
import '../../service/ticket_service.dart';
import '../../service/user_profile_service.dart';
import '../../view/auth/reset_password.dart';
import '../../view/settings/shipping_addresses.dart';
import '../../view/ticket/add_new_ticket.dart';
import '../../view/ticket/all_ticket_view.dart';
import '../../view/auth/auth.dart';
import '../../view/auth/enter_otp.dart';
import '../../view/auth/enter_email_reset_pass.dart';
import '../../view/cart/cart_view.dart';
import '../../view/cart/checkout.dart';
import '../../view/details/product_details.dart';
import '../../view/home/home_front.dart';
import '../../view/intro/intro.dart';
import '../../view/intro/splash.dart';
import '../../view/settings/change_password.dart';
import '../../view/settings/manage_account.dart';
import '../../view/settings/new_address.dart';
import '../../view/utils/constant_colors.dart';
import '../../service/navigation_bar_helper_service.dart';
import '../../service/order_details_service.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.transparent,
  ));
  TextThemeConstrants();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartDataService()),
        ChangeNotifierProvider(create: (_) => FavoriteDataService()),
        ChangeNotifierProvider(create: (_) => CountryDropdownService()),
        ChangeNotifierProvider(create: (_) => StateDropdownService()),
        ChangeNotifierProvider(create: (_) => PosterCampaignSliderService()),
        ChangeNotifierProvider(create: (_) => UserProfileService()),
        ChangeNotifierProvider(create: (_) => SignInSignUpService()),
        ChangeNotifierProvider(create: (_) => AuthTextControllerService()),
        ChangeNotifierProvider(create: (_) => NavigationBarHelperService()),
        ChangeNotifierProvider(create: (_) => ResetPassOTPService()),
        ChangeNotifierProvider(create: (_) => ProductCardDataService()),
        ChangeNotifierProvider(create: (_) => CategoriesDataService()),
        ChangeNotifierProvider(create: (_) => SearchResultDataService()),
        ChangeNotifierProvider(create: (_) => ChangePasswordService()),
        ChangeNotifierProvider(create: (_) => ManageAccountService()),
        ChangeNotifierProvider(create: (_) => ShippingAddressesService()),
        ChangeNotifierProvider(create: (_) => TicketService()),
        ChangeNotifierProvider(create: (_) => TicketChatService()),
        ChangeNotifierProvider(create: (_) => AddNewTicketService()),
        ChangeNotifierProvider(create: (_) => ProductDetailsService()),
        ChangeNotifierProvider(create: (_) => ShippingZoneService()),
        ChangeNotifierProvider(create: (_) => CuponDiscountService()),
        ChangeNotifierProvider(create: (_) => PaymentGateawayService()),
        ChangeNotifierProvider(create: (_) => OrderListService()),
        ChangeNotifierProvider(create: (_) => OrderDetailsService()),
        ChangeNotifierProvider(create: (_) => SocialLoginService()),
        ChangeNotifierProvider(create: (_) => CheckoutService()),
        ChangeNotifierProvider(create: (_) => ReviewService()),
        ChangeNotifierProvider(create: (_) => ConfirmPaymentService()),
        ChangeNotifierProvider(create: (_) => TermsAndCondition()),
        ChangeNotifierProvider(create: (_) => CampaignCardListService()),
        ChangeNotifierProvider(create: (_) => LanguageService()),
        ChangeNotifierProvider(create: (_) => AppStringService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Grenmart',
        builder: (context, rtlchild) {
          return Directionality(
            textDirection: Provider.of<LanguageService>(context).rtl
                ? TextDirection.rtl
                : TextDirection.ltr,
            child: rtlchild!,
          );
        },
        theme: ThemeData(
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
          }),
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: ConstantColors().pureWhite,
          appBarTheme: AppBarTheme(backgroundColor: ConstantColors().pureWhite),
          // bottomNavigationBarTheme: BottomNavigationBarThemeData(
          //     backgroundColor: ConstantColors().blackColor),
          buttonTheme:
              ButtonThemeData(buttonColor: ConstantColors().primaryColor),
          textSelectionTheme: TextSelectionThemeData(
              cursorColor: ConstantColors().primaryColor),
        ),
        home: const SplashScreen(),
        routes: {
          Intro.routeName: (context) => Intro(),
          Auth.routeName: (context) => Auth(),
          ResetPassEmail.routeName: (context) => ResetPassEmail(),
          EnterOTP.routeName: (context) => EnterOTP(),
          HomeFront.routeName: (context) => HomeFront(),
          ProductDetails.routeName: (context) => ProductDetails(),
          CartView.routeName: (context) => CartView(),
          Checkout.routeName: (context) => Checkout(),
          AddNewAddress.routeName: (context) => AddNewAddress(),
          ManageAccount.routeName: (context) => ManageAccount(),
          ChangePassword.routeName: (context) => const ChangePassword(),
          ShippingAdresses.routeName: (context) => const ShippingAdresses(),
          ResetPassword.routeName: (context) => const ResetPassword(),
          AllTicketsView.routeName: (context) => AllTicketsView(),
          AddNewTicket.routeName: (context) => AddNewTicket(),
          AllProducts.routeName: (context) => AllProducts(),
          WebViewScreen.routeName: (context) => WebViewScreen(),
          CategoryProductPage.routeName: (context) => CategoryProductPage(),
          CategoryPage.routeName: (context) => CategoryPage(),
          Campaigns.routeName: (context) => Campaigns(),
          ALLCampProductFromLink.routeName: (context) =>
              ALLCampProductFromLink(),
        },
      ),
    );
  }
}
