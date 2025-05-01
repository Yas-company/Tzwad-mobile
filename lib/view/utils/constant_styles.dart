import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gren_mart/service/navigation_bar_helper_service.dart';
import 'package:gren_mart/service/user_profile_service.dart';
import '../../service/country_dropdown_service.dart';
import '../../service/language_service.dart';
import '../../service/shipping_addresses_service.dart';
import '../../service/state_dropdown_service.dart';
import '../../view/utils/constant_colors.dart';
import '../../view/utils/constant_name.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../cart/payment_status.dart';
import '../order/orders.dart';
import '../settings/change_password.dart';
import '../settings/manage_account.dart';
import '../settings/shipping_addresses.dart';
import '../ticket/all_ticket_view.dart';

ConstantColors cc = ConstantColors();

Widget textFieldTitle(String title, {double fontSize = 15}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 8),
    margin: const EdgeInsets.only(top: 17),
    child: Text(
      title,
      style: TextStyle(
        color: ConstantColors().greytitle,
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

paymentFailedDialogue(BuildContext context) {
  showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(asProvider.getString('Are you sure?')),
          content: Text(asProvider
              .getString('Your payment process will get terminated.')),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => PaymentStatusView(true)),
                  (Route<dynamic> route) => false),
              child: Text(
                asProvider.getString('Yes'),
                style: TextStyle(color: cc.primaryColor),
              ),
            )
          ],
        );
      });
}

Widget customContainerButton(
    String buttonTitle, double? buttonWidth, Function ontapFunction,
    {Color? color}) {
  return GestureDetector(
      onTap: () {
        ontapFunction();
      },
      child: Container(
        height: 50,
        width: buttonWidth ?? double.infinity,
        // margin: const EdgeInsets.symmetric(vertical: 15),
        // margin: EdgeInsets.all(8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color ?? ConstantColors().primaryColor,
        ),
        child: Text(
          buttonTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: ConstantColors().pureWhite, fontWeight: FontWeight.bold),
        ),
      ));
}

Widget customBorderButton(String buttonText, Function ontap,
    {double width = 180, double? height}) {
  return GestureDetector(
    onTap: () {
      ontap();
    },
    child: Container(
        // margin: const EdgeInsets.all(8),
        height: height ?? 50,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color: ConstantColors().primaryColor,
          ),
        ),
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: ConstantColors().primaryColor,
              fontWeight: FontWeight.w700),
        )),
  );
}

Widget containerBorder(String imagePath, String text,
    {double widht = double.infinity}) {
  return Container(
    height: 44,
    width: double.infinity,
    margin: const EdgeInsets.symmetric(vertical: 7),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: ConstantColors().greyBorder,
        width: 1,
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 25,
          child: Image.asset(imagePath),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: TextStyle(color: ConstantColors().greyParagraph),
        )
      ],
    ),
  );
}

Widget customIconButton(String iconTitle, String iconName,
    {double padding = 8.0, void Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: EdgeInsets.all(padding),
      child: SvgPicture.asset(
        'assets/images/icons/$iconName',
        height: 27,
        color: Colors.black54,
      ),
    ),
  );
}

PreferredSizeWidget helloAppBar(BuildContext context) {
  print(asProvider.getString('Hello'));
  return AppBar(
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    elevation: 0,
    backgroundColor: ConstantColors().pureWhite,
    title: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: SizedBox(
        height: 100,
        // width: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              asProvider.getString('Hello') + ',',
              style: TextStyle(color: ConstantColors().greyHint, fontSize: 12),
            ),
            Consumer<UserProfileService>(builder: (context, uService, child) {
              return Text(
                uService.userProfileData == null
                    ? asProvider.getString('Welcome to Grenmart!')
                    : uService.userProfileData!.name,
                style: TextStyle(
                    color: ConstantColors().titleTexts,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              );
            }),
          ],
        ),
      ),
    ),
    actions: [
      Consumer<UserProfileService>(
        builder: (context, uService, child) {
          return GestureDetector(
            onTap: (() {
              if (uService.userProfileData == null) {
                Provider.of<NavigationBarHelperService>(context, listen: false)
                    .setNavigationIndex(4);
                return;
              }
              showTopSlider(context, uService);
            }),
            // Provider.of<NavigationBarHelperService>(context, listen: false)
            //     .setNavigationIndex(4)),
            child: uService.userProfileData == null
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage('assets/images/avatar.png'),
                      radius: 23,
                    ))
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: uService.userProfileData == null
                        ? SizedBox()
                        : CircleAvatar(
                            backgroundColor:
                                uService.userProfileData!.profileImageUrl ==
                                        null
                                    ? cc.primaryColor
                                    : cc.pureWhite,
                            child: uService.userProfileData!.profileImageUrl ==
                                    null
                                ? Text(
                                    uService.userProfileData!.name
                                        .substring(0, 2)
                                        .toUpperCase(),
                                    style: TextStyle(
                                        color: cc.pureWhite,
                                        fontWeight: FontWeight.bold),
                                  )
                                : null,
                            backgroundImage:
                                uService.userProfileData!.profileImageUrl !=
                                        null
                                    ? NetworkImage(uService.userProfileData!
                                        .profileImageUrl as String)
                                    : null,
                          ),
                  ),
          );
        },
      )
    ],
  );
}

Widget favoriteIcon(bool isFavorite,
    {double size = 15, required void Function()? onPressed}) {
  return Container(
    margin: const EdgeInsets.only(top: 9, right: 5, left: 5),
    child: CircleAvatar(
      radius: size,
      backgroundColor: cc.pureWhite,
      child: IconButton(
        onPressed: onPressed,
        icon: SvgPicture.asset(
          'assets/images/icons/${isFavorite ? 'red_heart' : 'grey_heart'}.svg',
          height: 20,
        ),
      ),
    ),
  );
}

Widget seeAllTitle(BuildContext context, String title,
    {void Function()? onPressed}) {
  return Container(
    margin: const EdgeInsets.only(left: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
        ),
        SizedBox(
            child: Row(children: [
          TextButton(
            onPressed: onPressed,
            child: Text(asProvider.getString('See All'),
                textAlign: TextAlign.end,
                style: TextStyle(color: cc.primaryColor, fontSize: 14)),
          ),
          // const Icon(
          //   Icons.arrow_forward_ios,
          //   size: 18,
          // )
        ]))
      ],
    ),
  );
}

Widget discAmountRow(
    BuildContext context, int discountAmount, int amount, String currency) {
  return Row(
    children: [
      Consumer<LanguageService>(builder: (context, lService, child) {
        return Text(
          lService.currencyRTL
              ? '${discountAmount <= 0 ? amount.toString() : discountAmount.toStringAsFixed(2)}${currency}'
              : '${currency}${discountAmount <= 0 ? amount.toString() : discountAmount.toStringAsFixed(2)}',
          style: TextStyle(
              color: cc.primaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 13),
        );
      }),
      const SizedBox(width: 4),
      Consumer<LanguageService>(builder: (context, lService, child) {
        return Text(
          lService.currencyRTL
              ? '${amount.toStringAsFixed(2)}${currency}'
              : '${currency}${amount.toStringAsFixed(2)}',
          style: TextStyle(
              color: cc.cardGreyHint,
              decoration: TextDecoration.lineThrough,
              decorationColor: cc.cardGreyHint,
              fontSize: 11),
        );
      }),
    ],
  );
}

Widget customRowButton(
  BuildContext context,
  String buttonText1,
  String buttonText2,
  Function ontap,
  Function ontap2,
) {
  initiateDeviceSize(context);
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      //skip Button

      customBorderButton(buttonText1, ontap, width: (screenWidth - 45) / 2),

      //continue button

      customContainerButton(buttonText2, (screenWidth - 45) / 2, ontap2)
    ],
  );
}

snackBar(BuildContext context, String content,
    {String? buttonText,
    void Function()? onTap,
    Color? backgroundColor,
    Duration? duration,
    SnackBarAction? action}) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(

      // width: screenWidth - 100,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.all(5),
      backgroundColor: backgroundColor ?? cc.primaryColor,
      duration: duration ?? const Duration(seconds: 2),
      action: action,
      content: Row(
        children: [
          Text(
            content,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          if (buttonText != null)
            GestureDetector(
              child: Text(buttonText),
              onTap: onTap,
            )
        ],
      )));
}

Widget loadingProgressBar({Color? color, double size = 35}) {
  return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
    size: size,
    color: color ?? cc.primaryColor,
  ));
}

void showTopSlider(BuildContext context, UserProfileService uService) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    transitionDuration: Duration(milliseconds: 500),
    barrierLabel: MaterialLocalizations.of(context).dialogLabel,
    barrierColor: Colors.black.withOpacity(0.5),
    pageBuilder: (context, _, __) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Card(
                elevation: 0,
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: <Widget>[
                    Row(
                      children: [
                        GestureDetector(
                          onTap: (() {
                            Provider.of<CountryDropdownService>(context,
                                    listen: false)
                                .getContries(context)
                                .then((value) {
                              final userData = Provider.of<UserProfileService>(
                                  context,
                                  listen: false);
                              print(userData.userProfileData!.country!.id);
                              if (userData.userProfileData!.country != null) {
                                Provider.of<CountryDropdownService>(context,
                                        listen: false)
                                    .setCountryIdAndValue(
                                        userData.userProfileData!.country!.name,
                                        context);
                              }
                              if (userData.userProfileData!.state != null) {
                                Provider.of<StateDropdownService>(context,
                                        listen: false)
                                    .setStateIdAndValue(
                                        userData.userProfileData!.state!.name);
                              }
                            });
                            Navigator.of(context)
                                .pushNamed(ManageAccount.routeName);
                          }),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 50,
                              width: 50,
                              color: cc.primaryColor,
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Center(
                                  child: Text(
                                      uService.userProfileData!.name
                                          .substring(0, 2)
                                          .toUpperCase()
                                          .trim(),
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: cc.pureWhite,
                                          fontWeight: FontWeight.bold)),
                                ),
                                imageUrl:
                                    uService.userProfileData!.profileImageUrl ??
                                        '',
                                errorWidget: (context, str, dyn) => Center(
                                  child: Text(
                                      uService.userProfileData!.name
                                          .substring(0, 2)
                                          .toUpperCase()
                                          .trim(),
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: cc.pureWhite,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(uService.userProfileData!.name,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                            SizedBox(height: 3),
                            Text(uService.userProfileData!.email,
                                style: TextStyle(
                                    color: cc.greyHint, fontSize: 11)),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    topSlidrOption(context,
                        optionText: asProvider.getString('My Orders'),
                        svgpath: 'assets/images/icons/orders.svg', onTap: () {
                      Navigator.of(context).push(MaterialPageRoute<void>(
                        builder: (BuildContext context) => MyOrders(),
                      ));
                    }),
                    topSlidrOption(context,
                        optionText: asProvider.getString('Shipping Address'),
                        svgpath: 'assets/images/icons/shipping_address.svg',
                        onTap: () {
                      Provider.of<ShippingAddressesService>(context,
                              listen: false)
                          .fetchUsersShippingAddress(context);
                      Navigator.of(context)
                          .pushNamed(ShippingAdresses.routeName)
                          .then((value) =>
                              Provider.of<ShippingAddressesService>(context,
                                      listen: false)
                                  .setNoData(false));
                    }),
                    topSlidrOption(context,
                        optionText: asProvider.getString('Manage Account'),
                        svgpath: 'assets/images/icons/manage_profile.svg',
                        onTap: () {
                      // setData(context);
                      Provider.of<CountryDropdownService>(context,
                              listen: false)
                          .getContries(context)
                          .then((value) {
                        final userData = Provider.of<UserProfileService>(
                            context,
                            listen: false);
                        if (userData.userProfileData!.country != null) {
                          Provider.of<CountryDropdownService>(context,
                                  listen: false)
                              .setCountryIdAndValue(
                                  userData.userProfileData!.country!.name,
                                  context);
                        }
                        if (userData.userProfileData!.state != null) {
                          Provider.of<StateDropdownService>(context,
                                  listen: false)
                              .setStateIdAndValue(
                                  userData.userProfileData!.state!.name);
                        }
                      });
                      Navigator.of(context).pushNamed(ManageAccount.routeName);
                    }),
                    topSlidrOption(context,
                        optionText: asProvider.getString('Support Ticket'),
                        svgpath: 'assets/images/icons/support_ticket.svg',
                        onTap: () {
                      Navigator.of(context).pushNamed(AllTicketsView.routeName);
                    }),
                    topSlidrOption(context,
                        optionText: asProvider.getString('Change Password'),
                        // svgpath: 'assets/images/icons/change_pass.svg',
                        imagePath: 'assets/images/change_pass.png', onTap: () {
                      Navigator.of(context).pushNamed(ChangePassword.routeName);
                    }),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: customBorderButton(
                        asProvider.getString('Log Out'),
                        () {
                          Provider.of<UserProfileService>(context,
                                  listen: false)
                              .userLogout();
                          Navigator.pop(context);
                        },
                        width: double.infinity,
                      ),
                    ),
                  ],
                )),
          ),
        ],
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
        ).drive(Tween<Offset>(
          begin: Offset(0, -1.0),
          end: Offset.zero,
        )),
        child: child,
      );
    },
  );
}

Widget topSlidrOption(
  BuildContext context, {
  String? svgpath,
  String? imagePath,
  required String optionText,
  void Function()? onTap,
}) {
  initiateDeviceSize(context);
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: screenWidth / 2.3,
      height: 48,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: cc.greyBorder),
      ),
      child: Row(
        children: [
          if (svgpath != null)
            SvgPicture.asset(
              '$svgpath',
              // height: 25,
            ),
          if (imagePath != null)
            Image.asset(
              '$imagePath',
              // height: 25,
            ),
          SizedBox(
            width: 5,
          ),
          FittedBox(
            child: Text(
              optionText,
              style: TextStyle(fontSize: 13),
            ),
          )
        ],
      ),
    ),
  );
}
