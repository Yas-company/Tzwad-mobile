import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gren_mart/view/utils/constant_name.dart';
import 'package:provider/provider.dart';

import '../../service/country_dropdown_service.dart';
import '../../service/navigation_bar_helper_service.dart';
import '../../service/state_dropdown_service.dart';
import '../../service/language_service.dart';
import '../../service/shipping_addresses_service.dart';
import '../../service/signin_signup_service.dart';
import '../../service/user_profile_service.dart';
import '../../view/auth/auth.dart';
import '../../view/settings/change_password.dart';
import '../../view/settings/manage_account.dart';
import '../../view/order/orders.dart';
import '../../view/settings/setting_screen_appbar.dart';
import '../../view/settings/shipping_addresses.dart';
import '../../view/ticket/all_ticket_view.dart';
import '../../view/utils/constant_colors.dart';
import '../../view/utils/constant_styles.dart';
import '../../service/auth_text_controller_service.dart';
import '../utils/text_themes.dart';

class SettingView extends StatelessWidget {
  SettingView({Key? key}) : super(key: key);

  bool login = true;

  ConstantColors cc = ConstantColors();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () =>
          Provider.of<NavigationBarHelperService>(context, listen: false)
              .setNavigationIndex(0),
      child: Consumer<UserProfileService>(builder: (context, uData, child) {
        return uData.userProfileData == null
            ? Center(
                child: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height - 150,
                    constraints: BoxConstraints(maxWidth: 300),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/images/avatar.png',
                            height: screenHight / 6,
                            // width: 48,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                                asProvider.getString(
                                    "You 'll have to login/register to edit or see your profile info."),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                ))),
                        const SizedBox(height: 20),
                        customContainerButton(
                          asProvider.getString('Login/Register'),
                          screenWidth / 2,
                          () {
                            Provider.of<SignInSignUpService>(context,
                                    listen: false)
                                .getUserData();
                            Provider.of<SignInSignUpService>(context,
                                    listen: false)
                                .toggleSigninSignup(value: true);
                            Navigator.of(context).pushNamed(Auth.routeName);
                          },
                        )
                      ],
                    )),
              )
            : ListView(
                padding: const EdgeInsets.all(0),
                children: [
                  SettingScreenAppBar(uData.userProfileData!.profileImageUrl),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      uData.userProfileData!.name,
                      style: TextThemeConstrants.titleText,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Center(
                      child: Text(
                        (uData.userProfileData!.phone == null
                                ? ''
                                : uData.userProfileData!.phone.toString() +
                                    '.') +
                            uData.userProfileData!.email.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: cc.greyHint,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  settingItem(context, 'assets/images/icons/orders.svg',
                      asProvider.getString('My Orders'), onTap: () {
                    Navigator.of(context).push(MaterialPageRoute<void>(
                      builder: (BuildContext context) => MyOrders(),
                    ));
                  }),
                  settingItem(
                      context,
                      'assets/images/icons/shipping_address.svg',
                      asProvider.getString('Shipping Address'), onTap: () {
                    Provider.of<ShippingAddressesService>(context,
                            listen: false)
                        .fetchUsersShippingAddress(context);
                    Navigator.of(context)
                        .pushNamed(ShippingAdresses.routeName)
                        .then((value) => Provider.of<ShippingAddressesService>(
                                context,
                                listen: false)
                            .setNoData(false));
                  }),
                  settingItem(context, 'assets/images/icons/manage_profile.svg',
                      asProvider.getString('Manage Account'), onTap: () async {
                    // setData(context);
                    Provider.of<CountryDropdownService>(context, listen: false)
                        .getContries(context)
                        .then((value) async {
                      final userData = Provider.of<UserProfileService>(context,
                          listen: false);
                      if (userData.userProfileData!.country != null) {
                        Provider.of<CountryDropdownService>(context,
                                listen: false)
                            .setCountryIdAndValue(
                                userData.userProfileData!.country!.name,
                                context);
                        await Provider.of<StateDropdownService>(context,
                                listen: false)
                            .getStates(userData.userProfileData!.country!.id,
                                context: context);
                      }
                      if (userData.userProfileData!.state != null) {
                        Provider.of<StateDropdownService>(context,
                                listen: false)
                            .setStateIdAndValue(
                                userData.userProfileData!.state!.name,
                                valueID: userData.userProfileData!.state!.id
                                    .toString());
                      }
                    });
                    Navigator.of(context).pushNamed(ManageAccount.routeName);
                  }),
                  settingItem(context, 'assets/images/icons/support_ticket.svg',
                      asProvider.getString('Support Ticket'),
                      icon: true,
                      imagePath2: 'assets/images/change_pass.png', onTap: () {
                    Navigator.of(context).pushNamed(AllTicketsView.routeName);
                  }),
                  settingItem(context, 'assets/images/icons/change_pass.svg',
                      asProvider.getString('Change Password'),
                      icon: false,
                      imagePath2: 'assets/images/change_pass.png', onTap: () {
                    Navigator.of(context).pushNamed(ChangePassword.routeName);
                  }),
                  const SizedBox(height: 70),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: customContainerButton(
                        asProvider.getString('Log Out'), double.infinity, () {
                      // Provider.of<NavigationBarHelperService>(context,
                      //         listen: false)
                      //     .setNavigationIndex(0);
                      Provider.of<SignInSignUpService>(context, listen: false)
                          .signOut();
                      Provider.of<AuthTextControllerService>(context,
                                  listen: false)
                              .setEmail(Provider.of<SignInSignUpService>(
                                      context,
                                      listen: false)
                                  .email) ??
                          '';
                      Provider.of<AuthTextControllerService>(context,
                              listen: false)
                          .setPass(Provider.of<SignInSignUpService>(context,
                                      listen: false)
                                  .password ??
                              '');
                      Provider.of<SignInSignUpService>(context, listen: false)
                          .toggleLaodingSpinner(value: false);
                      Provider.of<SignInSignUpService>(context, listen: false)
                          .getUserData();
                      // Provider.of<CartDataService>(context, listen: false)
                      //     .emptyCart();
                      globalUserToken = null;
                      // Navigator.of(context).pushAndRemoveUntil(
                      //     MaterialPageRoute(builder: (context) => Auth()),
                      //     (Route<dynamic> route) => false);
                      Provider.of<UserProfileService>(context, listen: false)
                          .userLogout();
                    }),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'v1.0',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromARGB(127, 158, 158, 158),
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                ],
              );
      }),
    );
  }

  Widget settingItem(
    BuildContext context,
    String imagePath,
    String itemText, {
    void Function()? onTap,
    bool icon = true,
    String? imagePath2,
    double imageSize = 35,
    double imageSize2 = 35,
    double textSize = 16,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: SizedBox(
        child: Column(
          children: [
            SizedBox(
              child: ListTile(
                onTap: onTap,
                visualDensity: const VisualDensity(vertical: -3),
                dense: false,
                leading: icon
                    ? SvgPicture.asset(
                        imagePath,
                        height: imageSize,
                      )
                    : SizedBox(
                        height: imageSize2, child: Image.asset(imagePath2!)),
                title: Text(
                  itemText,
                  style: TextStyle(
                    fontSize: textSize,
                    color: cc.blackColor,
                  ),
                ),
                trailing: Transform(
                  transform:
                      Provider.of<LanguageService>(context, listen: false).rtl
                          ? Matrix4.rotationY(pi)
                          : Matrix4.rotationY(0),
                  child: SvgPicture.asset(
                    'assets/images/icons/arrow_right.svg',
                  ),
                ),
              ),
            ),
            const Divider()
          ],
        ),
      ),
    );
  }
}
