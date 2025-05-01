import 'package:flutter/material.dart';
import 'package:gren_mart/service/social_login_service.dart';
import 'package:gren_mart/view/utils/constant_name.dart';
import 'package:gren_mart/view/utils/text_themes.dart';
import 'package:provider/provider.dart';

import '../../service/auth_text_controller_service.dart';
import '../../service/signin_signup_service.dart';
import '../../service/user_profile_service.dart';
import '../../view/auth/horizontal_devider.dart';
import '../../view/auth/login.dart';
import '../../view/auth/remember.dart';
import '../../view/auth/enter_email_reset_pass.dart';
import '../../view/auth/signup.dart';
import '../../view/utils/constant_colors.dart';
import '../utils/constant_styles.dart';

class Auth extends StatefulWidget {
  static const routeName = 'auth';

  Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  DateTime? currentBackPressTime;
  ConstantColors cc = ConstantColors();
  ScrollController scrollController = ScrollController();

  final GlobalKey<FormState> _formKeySignin = GlobalKey();

  final GlobalKey<FormState> _formKeySignup = GlobalKey();

  List<String> contries = [];

  Future<void> _onSubmit(
      BuildContext context, bool login, GlobalKey<FormState> formKey) async {
    final validated = formKey.currentState!.validate();
    if (!validated) {
      snackBar(
          context, asProvider.getString('Please provide all the information'),
          backgroundColor: cc.orange);
      scrollController.animateTo(0.0,
          curve: Curves.easeIn, duration: const Duration(milliseconds: 300));
      // formKey.currentContext!.visitChildElements((element) {
      //   element.deactivate();
      // });
      return;
    }
    final ssService = Provider.of<SignInSignUpService>(context, listen: false);
    final authTextControllers =
        Provider.of<AuthTextControllerService>(context, listen: false);
    ssService.toggleLaodingSpinner(value: true);
    if (login) {
      var email = authTextControllers.email;
      var pass = authTextControllers.password;
      if (email == null) {
        email = ssService.email;
        pass = ssService.password;
      }
      // Provider.of<NavigationBarHelperService>(context, listen: false)
      //     .setNavigationIndex(0);
      await ssService
          .signInOption(context, email.trim(), pass)
          .then((value) async {
        if (value) {
          await Provider.of<UserProfileService>(context, listen: false)
              .fetchProfileService();
          // Provider.of<PosterCampaignSliderService>(context, listen: false)
          //     .fetchPosters();
          // Provider.of<PosterCampaignSliderService>(context, listen: false)
          //     .fetchCampaigns();
          // Provider.of<CampaignCardListService>(context, listen: false)
          //     .fetchCampaignCardList();
          // Provider.of<NavigationBarHelperService>(context, listen: false)
          //     .setNavigationIndex(0);

          ssService.toggleLaodingSpinner(value: false);
          Navigator.pop(context, true);
          // Navigator.of(context).pushReplacementNamed(HomeFront.routeName);
          return;
        }
        ssService.toggleLaodingSpinner(value: false);

        // snackBar(context, 'SomeThing went wrong');
      }).onError((error, stackTrace) {
        snackBar(context, asProvider.getString('Login failed!'),
            backgroundColor: cc.orange);
        print(error.toString());
      });
      ssService.toggleLaodingSpinner(value: false);
      return;
    }
    if (!(ssService.termsAndCondi)) {
      snackBar(
          context,
          asProvider
              .getString('Please read and accept the terms and condition'),
          backgroundColor: cc.orange);
      ssService.toggleLaodingSpinner(value: false);

      return;
    }
    if (authTextControllers.country == null) {
      snackBar(context, asProvider.getString('Please select your country'),
          backgroundColor: cc.orange);
      ssService.toggleLaodingSpinner(value: false);

      return;
    }
    if (authTextControllers.state == null) {
      snackBar(context, asProvider.getString('Please select your state'),
          backgroundColor: cc.orange);
      ssService.toggleLaodingSpinner(value: false);

      return;
    }
    ssService.toggleLaodingSpinner(value: true);
    await ssService
        .signUpOption(
            authTextControllers.newEmail,
            authTextControllers.newPassword,
            authTextControllers.name,
            authTextControllers.newUsername,
            authTextControllers.phoneNumber,
            authTextControllers.countryCode,
            (authTextControllers.country ?? 1).toString(),
            (authTextControllers.state ?? 1).toString(),
            // authTextControllers.cityAddress,
            'true')
        .then((value) async {
      if (value) {
        await Provider.of<UserProfileService>(context, listen: false)
            .fetchProfileService();
        // Provider.of<PosterCampaignSliderService>(context, listen: false)
        //     .fetchPosters();
        // Provider.of<PosterCampaignSliderService>(context, listen: false)
        //     .fetchCampaigns();
        // Provider.of<CampaignCardListService>(context, listen: false)
        //     .fetchCampaignCardList();
        // Provider.of<NavigationBarHelperService>(context, listen: false)
        //     .setNavigationIndex(0);
        ssService.toggleLaodingSpinner(value: false);
        // Provider.of<NavigationBarHelperService>(context, listen: false)
        //     .setNavigationIndex(0);
        // Navigator.of(context).pushReplacementNamed(HomeFront.routeName);
        Navigator.pop(context, true);

        return;
      }
      ssService.toggleLaodingSpinner(value: false);

      snackBar(context, asProvider.getString('Register failed.'),
          backgroundColor: cc.orange);
    }).onError((error, stackTrace) {
      ssService.toggleLaodingSpinner(value: false);
      snackBar(context, error.toString(), backgroundColor: cc.orange);
      return;
    });
    ssService.toggleLaodingSpinner(value: false);
  }

  @override
  Widget build(BuildContext context) {
    // countryStateInitiate(context);
    return WillPopScope(
      onWillPop: () async {
        // DateTime now = DateTime.now();
        // if (currentBackPressTime == null ||
        //     now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
        //   currentBackPressTime = now;
        //   snackBar(context, 'Press again to exit', backgroundColor: cc.orange);
        //   return false;
        // }
        return true;
      },
      child: Stack(
        children: [
          Scaffold(
            body: Consumer<SignInSignUpService>(
                builder: (context, ssData, child) {
              return SingleChildScrollView(
                controller: scrollController,
                child: ListView(
                    padding: const EdgeInsets.all(0),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      Container(
                        height: 230,
                        // padding:
                        //     EdgeInsets.only(top: MediaQuery.of(context).padding.top - 20),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                            color: Color(0xffE3FFE5),
                            image: DecorationImage(
                                image: AssetImage('assets/images/elements.png'),
                                repeat: ImageRepeat.repeat,
                                opacity: .7)
                            // boxShadow: [
                            //   BoxShadow(
                            //       color: Colors.grey,
                            //       blurRadius: 4,
                            //       spreadRadius: 2,
                            //       blurStyle: BlurStyle.normal)
                            // ]
                            ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).padding.top),
                            child: SizedBox(
                              height: 230,
                              child:
                                  Image.asset('assets/images/auth_image.png'),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 35),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          ssData.login
                              ? asProvider.getString('Welcome back')
                              : asProvider.getString('Register to join us'),
                          style: TextThemeConstrants.titleText,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: ssData.login
                              ? Login(
                                  _formKeySignin,
                                  () {
                                    FocusScope.of(context).unfocus();
                                    _onSubmit(
                                        context, ssData.login, _formKeySignin);
                                  },
                                  initialPass: ssData.password,
                                  initialemail: ssData.email,
                                )
                              : SignUp(_formKeySignup)),
                      const SizedBox(height: 10),
                      Consumer<SignInSignUpService>(
                          builder: (context, ssData, child) {
                        return ssData.login
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Container(
                                    margin: const EdgeInsets.only(top: 5),
                                    height: 30,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: RememberBox(
                                              ssData.rememberPass, (value) {
                                            ssData.toggleRememberPass(value);
                                          }),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                                ResetPassEmail.routeName);
                                          },
                                          child: RichText(
                                            overflow: TextOverflow.clip,
                                            textAlign: TextAlign.end,
                                            softWrap: true,
                                            maxLines: 1,
                                            text: TextSpan(
                                              text: asProvider.getString(
                                                  'Forgot password?'),
                                              style: TextStyle(
                                                color: cc.titleTexts,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              )
                            : const SizedBox();
                      }),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Stack(
                          children: [
                            customContainerButton(
                              ssData.isLoading
                                  ? ''
                                  : (ssData.login
                                      ? asProvider.getString('Log in')
                                      : asProvider.getString('Register')),
                              double.infinity,
                              ssData.login
                                  ? () {
                                      FocusScope.of(context).unfocus();
                                      _onSubmit(context, ssData.login,
                                          _formKeySignin);
                                    }
                                  : () {
                                      FocusScope.of(context).unfocus();
                                      _onSubmit(context, ssData.login,
                                          _formKeySignup);

                                      // Navigator.of(context)
                                      //     .pushReplacementNamed(HomeFront.routeName);
                                    },
                            ),
                            if (ssData.isLoading)
                              SizedBox(
                                  height: 50,
                                  width: double.infinity,
                                  child: Center(
                                      child: loadingProgressBar(
                                          size: 30, color: cc.pureWhite)))
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              ssData.login
                                  ? asProvider
                                      .getString("Don't have an account?")
                                  : asProvider
                                      .getString('Already have an account?'),
                              style: TextThemeConstrants.paragraphText,
                            ),
                            const SizedBox(width: 5),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0.0),
                              child: GestureDetector(
                                onTap: () {
                                  ssData.toggleSigninSignup();
                                },
                                child: RichText(
                                  overflow: TextOverflow.clip,
                                  textAlign: TextAlign.end,
                                  softWrap: true,
                                  maxLines: 1,
                                  text: TextSpan(
                                    text: ssData.login
                                        ? asProvider.getString('Register')
                                        : asProvider.getString('Log in'),
                                    style: TextStyle(
                                      color: cc.primaryColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: HorizontalDivider(),
                      ),
                      const SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: GestureDetector(
                          onTap: (() async {
                            Provider.of<SocialLoginService>(context,
                                    listen: false)
                                .setIsLoading(true);
                            Provider.of<SocialLoginService>(context,
                                    listen: false)
                                .googleLogin(context)
                                .then((value) async {
                              await Provider.of<UserProfileService>(context,
                                      listen: false)
                                  .fetchProfileService()
                                  .then((value) async {
                                if (value == null) {
                                  snackBar(context,
                                      asProvider.getString('Failed to load!'),
                                      backgroundColor: cc.orange);
                                  Provider.of<SocialLoginService>(context,
                                          listen: false)
                                      .setIsLoading(false);
                                  return;
                                }
                                // Provider.of<PosterCampaignSliderService>(
                                //         context,
                                //         listen: false)
                                //     .fetchPosters();
                                // Provider.of<PosterCampaignSliderService>(
                                //         context,
                                //         listen: false)
                                //     .fetchCampaigns();
                                // Provider.of<CampaignCardListService>(context,
                                //         listen: false)
                                //     .fetchCampaignCardList();
                                // // Provider.of<NavigationBarHelperService>(context,
                                // //         listen: false)
                                // //     .setNavigationIndex(0);
                                Navigator.pop(context, true);
                                Provider.of<SocialLoginService>(context,
                                        listen: false)
                                    .setIsLoading(false);

                                // Navigator.of(context)
                                //     .pushReplacementNamed(HomeFront.routeName);
                              });
                            });
                          }),
                          child: containerBorder(
                              'assets/images/icons/google.png',
                              ssData.login
                                  ? asProvider.getString('Login with Google')
                                  : asProvider
                                      .getString('Register with Google')),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: GestureDetector(
                          onTap: () async {
                            Provider.of<SocialLoginService>(context,
                                    listen: false)
                                .setIsLoading(true);
                            Provider.of<SocialLoginService>(context,
                                    listen: false)
                                .facebookLogin(context)
                                .then((value) async {
                              await Provider.of<UserProfileService>(context,
                                      listen: false)
                                  .fetchProfileService()
                                  .then((value) async {
                                if (value == null) {
                                  snackBar(context,
                                      asProvider.getString('Loading failed!'),
                                      backgroundColor: cc.orange);
                                  Provider.of<SocialLoginService>(context,
                                          listen: false)
                                      .setIsLoading(false);
                                  return;
                                }
                                // Provider.of<PosterCampaignSliderService>(
                                //         context,
                                //         listen: false)
                                //     .fetchPosters();
                                // Provider.of<PosterCampaignSliderService>(
                                //         context,
                                //         listen: false)
                                //     .fetchCampaigns();
                                // Provider.of<CampaignCardListService>(context,
                                //         listen: false)
                                //     .fetchCampaignCardList();
                                // Provider.of<NavigationBarHelperService>(context,
                                //         listen: false)
                                //     .setNavigationIndex(0);
                                Navigator.pop(context, true);
                                Provider.of<SocialLoginService>(context,
                                        listen: false)
                                    .setIsLoading(false);
                                // Navigator.of(context)
                                //     .pushReplacementNamed(HomeFront.routeName);
                              });
                            }).onError((error, stackTrace) {
                              Provider.of<SocialLoginService>(context,
                                      listen: false)
                                  .setIsLoading(false);
                              snackBar(context,
                                  asProvider.getString('Failed to load!'),
                                  backgroundColor: cc.orange);
                            });
                          },
                          child: containerBorder(
                              'assets/images/icons/facebook.png',
                              ssData.login
                                  ? asProvider.getString('Login with Facebook')
                                  : asProvider
                                      .getString('Register with Facebook')),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      )
                    ]),
              );
            }),
          ),
          Consumer<SocialLoginService>(
            builder: (context, socialService, child) {
              return socialService.isLoading
                  ? Container(
                      color: Colors.white54,
                      child: loadingProgressBar(),
                    )
                  : const SizedBox();
            },
          )
        ],
      ),
    );
  }

  // countryStateInitiate(BuildContext context) {
  //   Provider.of<CountryDropdownService>(context, listen: false)
  //       .getContries(context, notFromAuth: false);
  // }
}
