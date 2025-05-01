import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:gren_mart/service/campaign_card_list_service.dart';
import 'package:gren_mart/service/language_service.dart';
import 'package:gren_mart/service/navigation_bar_helper_service.dart';
import 'package:gren_mart/view/utils/constant_styles.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';

import '../../db/database_helper.dart';
import '../../service/app_string_service.dart';
import '../../service/cart_data_service.dart';
import '../../service/favorite_data_service.dart';
import '../../service/poster_campaign_slider_service.dart';
import '../../service/signin_signup_service.dart';
import '../../service/user_profile_service.dart';
import '../../view/home/home_front.dart';
import '../../service/auth_text_controller_service.dart';
import '../utils/constant_name.dart';
import 'intro.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool retry = false;
  bool goforward = false;

  Future<void> initialize() async {
    await getDatabegeData(context);

    // await Provider.of<LanguageService>(context, listen: false).setLanguage();
    // await Provider.of<LanguageService>(context, listen: false).setCurrency();
    initiateAutoSignIn(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initialize();
  }

  @override
  Widget build(BuildContext context) {
    initiateDeviceSize(context);
    // getDatabegeData(context);

    // initiateAutoSignIn(context);

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: cc.pureWhite,
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/images/splash.png',
              fit: BoxFit.fill,
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  width: retry ? null : screenWidth - 5,
                  margin: EdgeInsets.only(bottom: screenHight / 3.5),
                  child: retry ? SizedBox() : loadingProgressBar(),
                ))
          ],
        ),
      ),
    );
  }

  getDatabegeData(BuildContext context) {
    List databases = ['cart', 'favorite'];
    databases.map((e) => DbHelper.database(e));
    Provider.of<CartDataService>(context, listen: false).fetchCarts();
    Provider.of<FavoriteDataService>(context, listen: false).fetchFavorites();
    FlutterNativeSplash.remove();
  }

  initiateAutoSignIn(BuildContext context) async {
    // await Future.delayed(Duration(milliseconds: 900));

    try {
      await Provider.of<AppStringService>(context, listen: false)
          .fetchTranslatedStrings();
    } catch (e) {}

    var connection = await Connectivity().checkConnectivity();
    if (connection == ConnectivityResult.none) {
      snackBar(
        context,
        asProvider.getString('Please turn on your internet connection'),
        backgroundColor: cc.orange,
        duration: Duration(minutes: 10),
        action: SnackBarAction(
          label: 'Retry',
          onPressed: () {
            initiateAutoSignIn(context);
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            setState(() {
              retry = false;
            });
          },
          textColor: cc.pureWhite,
        ),
      );
      setState(() {
        retry = true;
      });
      return;
    }

    await Provider.of<LanguageService>(context, listen: false)
        .setLanguage(context)
        .onError((error, stackTrace) {
      return;
    });
    await Provider.of<LanguageService>(context, listen: false)
        .setCurrency()
        .onError((error, stackTrace) {
      print(error);

      return;
    });
    await Provider.of<SignInSignUpService>(context, listen: false)
        .getToken()
        .then((value) async {
      print('token.........................$value');
      print(value);
      if (value != null && value != '') {
        try {
          await Provider.of<UserProfileService>(context, listen: false)
              .fetchProfileService()
              .then((value) async {
            if (value == null) {
              // snackBar(context, 'Connection failed!',
              //     backgroundColor: cc.orange);
              return;
            }
            Provider.of<PosterCampaignSliderService>(context, listen: false)
                .fetchPosters();
            Provider.of<PosterCampaignSliderService>(context, listen: false)
                .fetchCampaigns();
            Provider.of<CampaignCardListService>(context, listen: false)
                .fetchCampaignCardList();

            Provider.of<NavigationBarHelperService>(context, listen: false)
                .setNavigationIndex(0);
            Navigator.of(context).pushReplacementNamed(HomeFront.routeName);

            return;
          }).onError((error, stackTrace) {
            snackBar(context, asProvider.getString("Connection failed!"),
                backgroundColor: cc.orange);
            throw '';
          });
        } catch (error) {
          print(error);
          throw error;
        }

        return;
      }
      Navigator.of(context).pushReplacementNamed(HomeFront.routeName);
      return;

      // Future.delayed(const Duration(seconds: 1));
    }).onError((error, stackTrace) async {
      final ref = await SharedPreferences.getInstance();

      if (ref.containsKey('intro')) {
        await Provider.of<SignInSignUpService>(context, listen: false)
            .getUserData();
        print('inside error, going to auth');
        Provider.of<PosterCampaignSliderService>(context, listen: false)
            .fetchPosters();
        Provider.of<PosterCampaignSliderService>(context, listen: false)
            .fetchCampaigns();
        Provider.of<CampaignCardListService>(context, listen: false)
            .fetchCampaignCardList();

        Provider.of<NavigationBarHelperService>(context, listen: false)
            .setNavigationIndex(0);
        Navigator.of(context).pushReplacementNamed(HomeFront.routeName);
        Provider.of<AuthTextControllerService>(context, listen: false).setEmail(
            Provider.of<SignInSignUpService>(context, listen: false).email);
        Provider.of<AuthTextControllerService>(context, listen: false).setPass(
            Provider.of<SignInSignUpService>(context, listen: false).password);
        return;
      }
      Navigator.of(context).pushReplacementNamed(Intro.routeName);
      return;
    });

    if (globalUserToken == null) {
      final ref = await SharedPreferences.getInstance();

      print('outside error, going to auth');
      if (ref.containsKey('intro')) {
        await Provider.of<SignInSignUpService>(context, listen: false)
            .getUserData();
        Provider.of<PosterCampaignSliderService>(context, listen: false)
            .fetchPosters();
        Provider.of<PosterCampaignSliderService>(context, listen: false)
            .fetchCampaigns();
        Provider.of<CampaignCardListService>(context, listen: false)
            .fetchCampaignCardList();

        Provider.of<NavigationBarHelperService>(context, listen: false)
            .setNavigationIndex(0);
        Navigator.of(context).pushReplacementNamed(HomeFront.routeName);
        Provider.of<AuthTextControllerService>(context, listen: false).setEmail(
            Provider.of<SignInSignUpService>(context, listen: false).email);
        Provider.of<AuthTextControllerService>(context, listen: false).setPass(
            Provider.of<SignInSignUpService>(context, listen: false).password);
        return;
      }
      Navigator.of(context).pushReplacementNamed(Intro.routeName);
    }
    // Navigator.of(context).pushReplacementNamed(HomeFront.routeName);
    return;
  }
}
