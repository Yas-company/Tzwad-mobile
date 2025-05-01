import 'package:flutter/material.dart';
import 'package:gren_mart/service/shipping_addresses_service.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:provider/provider.dart';

import '../../service/checkout_service.dart';
import '../../service/cupon_discount_service.dart';
import '../../service/navigation_bar_helper_service.dart';
import '../../service/shipping_zone_service.dart';
import '../../service/cart_data_service.dart';
import '../../service/signin_signup_service.dart';
import '../../service/user_profile_service.dart';
import '../../view/cart/cart_tile.dart';
import '../../view/cart/checkout.dart';
import '../../view/utils/constant_colors.dart';
import '../../view/utils/constant_styles.dart';
import '../auth/auth.dart';
import '../utils/constant_name.dart';

class CartView extends StatelessWidget {
  static const routeName = 'cart';
  CartView({Key? key}) : super(key: key);

  ConstantColors cc = ConstantColors();

  @override
  Widget build(BuildContext context) {
    initiateDeviceSize(context);
    return WillPopScope(
      onWillPop: () =>
          Provider.of<NavigationBarHelperService>(context, listen: false)
              .setNavigationIndex(0),
      child: Consumer<CartDataService>(builder: (context, cartData, child) {
        List<String> cuponData = [];
        cartData.cartList!.forEach((key, value) {
          value.forEach((element) {
            cuponData.add(
                '{"id":${element['id']},"price":${(element['price'] as double) * (element['quantity'] as int)}}');
          });
        });
        print(cuponData);
        return Column(
          children: [
            const SizedBox(height: 10),
            if (cartData.cartList!.isNotEmpty)
              Expanded(
                child: ListView(
                    physics:
                        Provider.of<CartDataService>(context).cartList!.isEmpty
                            ? const NeverScrollableScrollPhysics()
                            : const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                    children: [
                      ...cartTiles(cartData),
                    ]),
              ),
            if (cartData.cartList!.isEmpty)
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: screenHight / 2.5,
                    padding: const EdgeInsets.all(20),
                    child: Image.asset('assets/images/empty_cart.png'),
                  ),
                  Center(
                      child: Text(asProvider.getString('Add item to cart!'),
                          style: TextStyle(
                            color: cc.greyHint,
                          ))),
                ],
              )),
            if (Provider.of<CartDataService>(context, listen: false)
                .cartList!
                .isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(20),
                child: customContainerButton(
                  asProvider.getString('Checkout'),
                  double.infinity,
                  () async {
                    bool continueCheckout = true;
                    if (Provider.of<UserProfileService>(context, listen: false)
                            .userProfileData ==
                        null) {
                      continueCheckout = false;
                      continueCheckout = await loginPopup(context);
                    }
                    if (!continueCheckout) {
                      return;
                    }

                    print(cuponData.toString());
                    Provider.of<ShippingZoneService>(context, listen: false)
                        .resetChecout(backingout: true);
                    Provider.of<ShippingAddressesService>(context,
                            listen: false)
                        .clearSelectedAddress();
                    Provider.of<CuponDiscountService>(context, listen: false)
                        .clearCoupon();
                    Provider.of<CuponDiscountService>(context, listen: false)
                        .setCarData(cuponData.toString().replaceAll(' ', ''));
                    Provider.of<CheckoutService>(context, listen: false)
                        .setIsLoading(false);
                    Navigator.of(context)
                        .pushNamed(Checkout.routeName)
                        .then((value) {
                      Provider.of<ShippingZoneService>(context, listen: false)
                          .resetChecout(backingout: true);
                      Provider.of<ShippingAddressesService>(context,
                              listen: false)
                          .clearSelectedAddress();
                      Provider.of<CuponDiscountService>(context, listen: false)
                          .clearCoupon();
                    });
                  },
                ),
              ),
          ],
        );
      }),
    );
  }

  List<Widget> cartTiles(CartDataService cService) {
    List<Widget> list = [];
    cService.cartList!.forEach((key, value) {
      value.forEach((e) {
        list.add(CartTile(
          e['id'],
          e['title'] as String,
          e['imgUrl'] as String,
          e['quantity'] as int,
          e['price'] as double,
          e['attributes'] == {} ? null : e['attributes'] as Map,
        ));
      });
    });
    return list;
  }

  loginPopup(BuildContext context, {title, description}) async {
    bool logedIn = false;
    await Alert(
        context: context,
        style: AlertStyle(
            alertElevation: 0,
            overlayColor: Colors.black.withOpacity(.6),
            alertPadding: const EdgeInsets.all(25),
            isButtonVisible: false,
            alertBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            titleStyle: const TextStyle(),
            animationType: AnimationType.grow,
            animationDuration: const Duration(milliseconds: 500)),
        content: Container(
          margin: const EdgeInsets.only(top: 22),
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.01),
                  spreadRadius: -2,
                  blurRadius: 13,
                  offset: const Offset(0, 13)),
            ],
          ),
          child: Column(
            children: [
              Text(
                title ?? asProvider.getString('Login to checkout?'),
                style: TextStyle(color: cc.greytitle, fontSize: 17),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                description ??
                    asProvider.getString(
                        'You have to  login to proceed the checkout.'),
                style: TextStyle(color: cc.greyParagraph, fontSize: 13),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  customBorderButton(asProvider.getString('Cancel'), () {
                    Navigator.pop(context);
                  }, width: screenWidth / 3.3),
                  const SizedBox(
                    width: 16,
                  ),
                  customContainerButton(
                    asProvider.getString('Login'),
                    screenWidth / 3.3,
                    () {
                      Provider.of<SignInSignUpService>(context, listen: false)
                          .getUserData();
                      Provider.of<SignInSignUpService>(context, listen: false)
                          .toggleSigninSignup(value: true);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => Auth(),
                        ),
                      ).then((value) {
                        if (value == true) {
                          logedIn = value;
                        }
                        Navigator.pop(context);
                      });
                    },
                  ),
                ],
              )
            ],
          ),
        )).show();
    return logedIn;
  }
}
