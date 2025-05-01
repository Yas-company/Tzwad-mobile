import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gren_mart/model/shipping_addresses_model.dart';
import 'package:gren_mart/service/user_profile_service.dart';
import 'package:provider/provider.dart';

import '../../service/common_service.dart';
import '../../service/language_service.dart';
import '../utils/web_view.dart';
import 'payment_grid_tile.dart';
import '../utils/text_themes.dart';
import '../payment/paypal_payment.dart';
import '../payment/stripe_payment.dart';
import '../settings/new_address.dart';
import '../../service/cart_data_service.dart';
import '../../service/shipping_zone_service.dart';
import '../../service/checkout_service.dart';
import '../../service/confirm_payment_service.dart';
import '../../view/order/order_details.dart';
import '../../view/payment/cash_free_payment.dart';
import '../../view/payment/flutter_wave_payment.dart';
import '../../view/payment/instamojo_payment.dart';
import '../../view/payment/mercado_pago_payment.dart';
import '../../view/payment/mid_trans_payment.dart';
import '../../view/payment/mollie_payment.dart';
import '../../view/payment/payfast_payment.dart';
import '../../view/payment/paystack_payment.dart';
import '../../view/payment/paytm_payment.dart';
import '../../view/payment/razorpay_payment.dart';
import '../../service/cupon_discount_service.dart';
import '../../service/payment_gateaway_service.dart';
import '../../service/shipping_addresses_service.dart';
import '../../view/utils/app_bars.dart';
import '../../view/utils/constant_colors.dart';
import '../../view/utils/constant_name.dart';
import '../../view/utils/constant_styles.dart';

class Checkout extends StatelessWidget {
  static const routeName = 'checkout';

  ConstantColors cc = ConstantColors();
  ScrollController controller = ScrollController();

  bool error = false;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<ShippingAddressesService>(context, listen: false)
            .clearSelectedAddress();
        Provider.of<ShippingZoneService>(context, listen: false)
            .resetChecout(backingout: true);
        return true;
      },
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBars()
                .appBarTitled(context, asProvider.getString('Checkout'), () {
              Provider.of<ShippingAddressesService>(context, listen: false)
                  .clearSelectedAddress();
              Provider.of<ShippingZoneService>(context, listen: false)
                  .resetChecout(backingout: true);
              Provider.of<PaymentGateawayService>(context, listen: false)
                  .resetGateaway();
              Navigator.of(context).pop();
            }, hasButton: true, hasElevation: true),
            body: ListView(
              controller: controller,
              padding: const EdgeInsets.all(20),
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                // CustomTextField(
                //   'enter new address',
                //   controller: TextEditingController(),
                //   leadingImage: 'assets/images/icons/location.png',
                // ),
                // const SizedBox(height: 10),

                FutureBuilder(
                    future: Provider.of<ShippingAddressesService>(context,
                            listen: false)
                        .fetchUsersShippingAddress(context,
                            loadShippingZone: true),
                    builder: (context, snapShot) {
                      if (snapShot.connectionState == ConnectionState.waiting) {
                        return loadingProgressBar();
                      }
                      if (snapShot.hasData) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 25),
                          child: Center(
                            child: Text(snapShot.data.toString()),
                          ),
                        );
                      }
                      return Consumer<ShippingAddressesService>(
                          builder: (context, saService, child) {
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: shippingAddress(context)
                            //     saService.shippingAddresseList.map(((e) {
                            //   final shippingAddress = saService.shippingAddresseList
                            //       .firstWhere((element) => element.id == e.id);
                            //   final selected = shippingAddress.id ==
                            //       (saService.selectedAddress == null
                            //           ? null
                            //           : saService.selectedAddress!.id);
                            //   return GestureDetector(
                            //       onTap: () {
                            //         if (saService.selectedAddress != null &&
                            //             saService.selectedAddress!.id == e.id) {
                            //           return;
                            //         }
                            //         saService.setSelectedAddress(e, context);
                            //       },
                            //       child: Container(
                            //         margin: const EdgeInsets.only(bottom: 15),
                            //         padding: const EdgeInsets.symmetric(vertical: 12),
                            //         decoration: BoxDecoration(
                            //             borderRadius: BorderRadius.circular(10),
                            //             color: selected
                            //                 ? cc.lightPrimery3
                            //                 : cc.whiteGrey,
                            //             border: Border.all(
                            //                 color: selected
                            //                     ? cc.primaryColor
                            //                     : cc.greyHint,
                            //                 width: .5)),
                            //         child: Stack(children: [
                            //           ListTile(
                            //             title: Padding(
                            //               padding: const EdgeInsets.symmetric(
                            //                   horizontal: 5, vertical: 5),
                            //               child: Text(shippingAddress.name),
                            //             ),
                            //             subtitle: Padding(
                            //               padding: const EdgeInsets.symmetric(
                            //                   horizontal: 5, vertical: 5),
                            //               child: Text(shippingAddress.address),
                            //             ),
                            //           ),
                            //           if (selected)
                            //             Positioned(
                            //                 top: 10,
                            //                 right: Provider.of<LanguageService>(context, listen: false).rtl ? null : 15,
                            //                 left: Provider.of<LanguageService>(context, listen: false).rtl ? 15 : null,
                            //                 child: Icon(
                            //                   Icons.check_box,
                            //                   color: cc.primaryColor,
                            //                 ))
                            //         ]),
                            //       ));
                            // })).toList()
                            );
                      });
                    }),
                GestureDetector(
                  onTap: () {
                    Provider.of<ShippingAddressesService>(context,
                            listen: false)
                        .clearSelectedAddress();
                    Provider.of<ShippingZoneService>(context, listen: false)
                        .resetChecout(backingout: true);
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            AddNewAddress(dontPop: true),
                      ),
                    );
                  },
                  child: Container(
                      // margin: const EdgeInsets.all(8),
                      height: 50,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 1,
                          color: ConstantColors().primaryColor,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/icons/location.png',
                            height: 30,
                            color: cc.primaryColor,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            asProvider.getString('Add new address'),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: ConstantColors().primaryColor,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      )),
                ),
                const SizedBox(height: 20),
                Container(
                  // height: 300,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    color: cc.whiteGrey,
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        rows(asProvider.getString('Product'),
                            trailing: asProvider.getString('Subtotal')),
                        const SizedBox(height: 15),
                        SizedBox(
                          child: Consumer<CartDataService>(
                              builder: (context, cService, child) {
                            return Column(
                              children: productList(context, cService),
                            );
                          }),
                        ),
                        const SizedBox(height: 15),
                        Consumer<LanguageService>(
                            builder: (context, lService, child) {
                          return rows(asProvider.getString('Subtotal'),
                              trailing: lService.currencyRTL
                                  ? '${Provider.of<CartDataService>(context, listen: false).calculateSubtotal()}${lService.currency}'
                                  : '${lService.currency}${Provider.of<CartDataService>(context, listen: false).calculateSubtotal()}');
                        }),
                        const SizedBox(height: 15),
                        rows(asProvider.getString('Shipping cost'),
                            trailing: ''),
                        const SizedBox(height: 15),
                        Consumer<ShippingZoneService>(
                          builder: (context, sService, child) {
                            return sService.noData
                                ? Text(asProvider
                                    .getString('Select a shipping address.'))
                                : (sService.isLoading
                                    ? loadingProgressBar()
                                    : Column(
                                        children: sService.shippingOptionsList
                                                ?.map((element) {
                                                  return Row(
                                                    children: [
                                                      Transform.scale(
                                                        scale: 1.3,
                                                        child: Checkbox(
                                                            // splashRadius: 30,
                                                            materialTapTargetSize:
                                                                MaterialTapTargetSize
                                                                    .shrinkWrap,
                                                            activeColor:
                                                                ConstantColors()
                                                                    .primaryColor,
                                                            value: sService
                                                                    .selectedOption!
                                                                    .id ==
                                                                element.id,
                                                            shape:
                                                                const CircleBorder(),
                                                            side: BorderSide(
                                                              width: 1.5,
                                                              color:
                                                                  ConstantColors()
                                                                      .greyBorder,
                                                            ),
                                                            onChanged: (v) {
                                                              sService
                                                                  .setSelectedOption(
                                                                      element);
                                                            }),
                                                      ),
                                                      Text(element.name),
                                                      const Spacer(),
                                                      Consumer<LanguageService>(
                                                          builder: (context,
                                                              lService, child) {
                                                        return Text(lService
                                                                .currencyRTL
                                                            ? '${element.availableOptions.cost}${lService.currency}'
                                                            : '${lService.currency}${element.availableOptions.cost}');
                                                      })
                                                    ],
                                                  );
                                                })
                                                .toList()
                                                .reversed
                                                .toList() ??
                                            [],
                                      ));
                          },
                        ),
                        const SizedBox(height: 15),
                        Consumer<ShippingZoneService>(
                            builder: (context, szService, child) {
                          return Consumer<LanguageService>(
                              builder: (context, lService, child) {
                            return rows('Tax',
                                trailing: lService.currencyRTL
                                    ? '${szService.taxMoney(context).toStringAsFixed(2)}${lService.currency}'
                                    : '${lService.currency}${szService.taxMoney(context).toStringAsFixed(2)}');
                          });
                        }),
                        const SizedBox(height: 15),
                        Consumer<CuponDiscountService>(
                            builder: (context, cupService, child) {
                          return Consumer<LanguageService>(
                              builder: (context, lService, child) {
                            return rows(asProvider.getString('Coupon discount'),
                                trailing: lService.currencyRTL
                                    ? '${cupService.couponDiscount.toStringAsFixed(2)}${lService.currency}'
                                    : '${lService.currency}${cupService.couponDiscount.toStringAsFixed(2)}');
                          });
                        }),
                        const SizedBox(height: 15),
                        const Divider(),
                        const SizedBox(height: 25),
                        Consumer<ShippingZoneService>(
                            builder: (context, szService, child) {
                          return Consumer<LanguageService>(
                              builder: (context, lService, child) {
                            return rows(asProvider.getString('Total'),
                                trailing: lService.currencyRTL
                                    ? '${szService.totalCounter(context).toStringAsFixed(2)}${lService.currency}'
                                    : '${lService.currency}${szService.totalCounter(context).toStringAsFixed(2)}');
                          });
                        }),
                        const SizedBox(height: 25),
                        rows(asProvider.getString('Coupon code')),
                        const SizedBox(height: 15),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  width: screenWidth / 2,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    child: TextField(
                                      style: TextThemeConstrants.greyHint13,
                                      decoration: InputDecoration(
                                          hintText: asProvider
                                              .getString('Enter Coupon code'),
                                          hintStyle:
                                              TextThemeConstrants.greyHint13,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color:
                                                    ConstantColors().greyBorder,
                                                width: 1),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color:
                                                    ConstantColors().greyBorder,
                                                width: 1),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: ConstantColors().orange,
                                                width: 1),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: ConstantColors().orange,
                                                width: 1),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.all(15)),
                                      onChanged: (value) {
                                        Provider.of<CuponDiscountService>(
                                                context,
                                                listen: false)
                                            .setCouponText(value.trim());
                                      },
                                    ),
                                  )
                                  //  CustomTextField(
                                  //     'Enter promo code', TextEditingController()),
                                  ),
                              Consumer<CuponDiscountService>(
                                  builder: (context, cService, child) {
                                return GestureDetector(
                                  onTap: cService.isLoading
                                      ? () {}
                                      : () {
                                          cService.setTotalAmount(0);
                                          cService
                                              .getCuponDiscontAmount(context)
                                              .then((value) {
                                            if (value != null) {
                                              snackBar(context, value,
                                                  backgroundColor: cc.orange);
                                            }
                                          }).onError((error, stackTrace) {
                                            cService.setIsLoading(false);
                                            snackBar(
                                                context,
                                                asProvider.getString(
                                                    'Connection failed.'),
                                                backgroundColor: cc.orange);
                                          });
                                          FocusScope.of(context).unfocus();
                                        },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: Provider.of<LanguageService>(
                                                        context,
                                                        listen: false)
                                                    .rtl
                                                ? 0
                                                : 10,
                                            right: Provider.of<LanguageService>(
                                                        context,
                                                        listen: false)
                                                    .rtl
                                                ? 10
                                                : 0),
                                        child: SizedBox(
                                          width: screenWidth / 4,
                                          child: FittedBox(
                                            child: Text(
                                              asProvider.getString(
                                                  'Apply Coupon code'),
                                              style: TextStyle(
                                                color: Colors.transparent,
                                                shadows: [
                                                  Shadow(
                                                      offset:
                                                          const Offset(0, -5),
                                                      color: cc.primaryColor)
                                                ],
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationColor:
                                                    cc.primaryColor,
                                                decorationThickness: 1.5,
                                                // fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (cService.isLoading)
                                        Container(
                                            width: screenWidth / 4,
                                            color: Colors.white60,
                                            alignment: Alignment.center,
                                            margin:
                                                const EdgeInsets.only(left: 10),
                                            child: loadingProgressBar(size: 20))
                                    ],
                                  ),
                                );
                              }),
                            ]),
                        const SizedBox(height: 15),
                        Text(
                          asProvider.getString('Chose a payment method'),
                          style: TextThemeConstrants.titleText,
                        ),
                        const SizedBox(height: 20),
                        FutureBuilder(
                            future: Provider.of<PaymentGateawayService>(context,
                                    listen: false)
                                .fetchPaymentGetterData(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const SizedBox();
                              }
                              if (snapshot.hasError) {
                                snackBar(context,
                                    asProvider.getString('An error occurred'));
                                return Text(snapshot.error.toString());
                              }
                              return Consumer<PaymentGateawayService>(
                                  builder: (context, pgService, child) {
                                return SizedBox(
                                    height: 260,
                                    // (pgService.gatawayList.length / 3) * 60,
                                    child: GridView(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              childAspectRatio: 3 / 1.2,
                                              crossAxisSpacing: 8,
                                              mainAxisSpacing: 12),
                                      children: pgService.gatawayList
                                          .map((e) => GestureDetector(
                                              onTap: () {
                                                if (pgService
                                                        .selectedGateaway ==
                                                    e) {
                                                  return;
                                                }
                                                pgService
                                                    .setSelectedGareaway(e);
                                              },
                                              child: CartGridTile(e.logoLink,
                                                  pgService.itemSelected(e))))
                                          .toList(),
                                    ));
                              });
                            }),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Transform.scale(
                              scale: 1.3,
                              child: Consumer<CheckoutService>(
                                  builder: (context, cService, child) {
                                return Checkbox(

                                    // splashRadius: 30,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    side: BorderSide(
                                      width: 1,
                                      color: cc.greyBorder,
                                    ),
                                    activeColor: cc.primaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        side: BorderSide(
                                          width: 1,
                                          color: cc.greyBorder,
                                        )),
                                    value: cService.termsAcondi,
                                    onChanged: (value) {
                                      cService.setTermsACondi();
                                    });
                              }),
                            ),
                            const SizedBox(width: 5),
                            SizedBox(
                              width: screenWidth - 130,
                              child: FittedBox(
                                child: RichText(
                                  softWrap: true,
                                  text: TextSpan(
                                      text: asProvider.getString('Accept all') +
                                          ' ',
                                      style: TextStyle(
                                        color: cc.greyHint,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      children: [
                                        TextSpan(
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () =>
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                          WebViewScreen
                                                              .routeName,
                                                          arguments: [
                                                        asProvider.getString(
                                                            'Terms and Conditions'),
                                                        '$baseApiUrl/terms-and-condition-page'
                                                      ]),
                                            text: '' +
                                                asProvider.getString(
                                                    'Terms and Conditions'),
                                            style: TextStyle(
                                                color: cc.primaryColor)),
                                        TextSpan(
                                            text: ' & ',
                                            style:
                                                TextStyle(color: cc.greyHint)),
                                        TextSpan(
                                            recognizer: TapGestureRecognizer()
                                              ..onTap =
                                                  () =>
                                                      Navigator.of(context)
                                                          .pushNamed(
                                                              WebViewScreen
                                                                  .routeName,
                                                              arguments: [
                                                            asProvider.getString(
                                                                'Privacy Policy'),
                                                            '$baseApiUrl/privacy-policy-page'
                                                          ]),
                                            text: asProvider
                                                .getString('Privacy Policy'),
                                            style: TextStyle(
                                                color: cc.primaryColor)),
                                      ]),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Consumer<CheckoutService>(
                            builder: (context, cService, child) {
                          return customContainerButton(
                              asProvider.getString('Pay & Confirm'),
                              double.maxFinite,
                              cService.termsAcondi
                                  ? () async {
                                      Provider.of<PaymentGateawayService>(
                                              context,
                                              listen: false)
                                          .setIsLoading(true);
                                      final shippingService =
                                          Provider.of<ShippingAddressesService>(
                                              context,
                                              listen: false);
                                      print(shippingService.currentAddress);
                                      if ((shippingService.selectedAddress ==
                                              null &&
                                          !shippingService.currentAddress)) {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  title: Text(asProvider.getString(
                                                      'No shipping address selected?')),
                                                  content: Text(
                                                      asProvider.getString(
                                                          'Please add or select Shipping address to proceed your payment.')),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                          controller.animateTo(
                                                              0.0,
                                                              curve:
                                                                  Curves.easeIn,
                                                              duration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          300));
                                                        },
                                                        child: Text(
                                                          asProvider
                                                              .getString('Ok'),
                                                          style: TextStyle(
                                                              color: cc
                                                                  .primaryColor),
                                                        ))
                                                  ],
                                                ));
                                        Provider.of<PaymentGateawayService>(
                                                context,
                                                listen: false)
                                            .setIsLoading(false);
                                        return;
                                      }
                                      final selecteGatway =
                                          Provider.of<PaymentGateawayService>(
                                                  context,
                                                  listen: false)
                                              .selectedGateaway!
                                              .name;
                                      await startPayment(context, cService)
                                          .onError((error, stackTrace) {
                                        if (error == '') {
                                          return;
                                        }
                                        snackBar(
                                            context,
                                            asProvider
                                                .getString('Payment failed!'),
                                            backgroundColor: cc.orange);
                                      });

                                      Provider.of<PaymentGateawayService>(
                                              context,
                                              listen: false)
                                          .setIsLoading(false);
                                      // DbHelper.deleteDbTable('cart');
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) => PaymentStatusView(error)),
                                      // );
                                      // error = true;
                                    }
                                  : () {
                                      snackBar(
                                          context,
                                          asProvider.getString(
                                              'You have agree to our Terms & Conditions.'),
                                          backgroundColor: cc.orange);
                                    });
                        }),
                        const SizedBox(height: 30),
                      ]),
                ),
              ],
            ),
          ),
          Consumer<PaymentGateawayService>(
              builder: (context, pgService, child) {
            return pgService.isLoading
                ? Container(
                    color: Colors.white60,
                    child: loadingProgressBar(),
                  )
                : const SizedBox();
          })
        ],
      ),
    );
  }

  List<Widget> productList(BuildContext context, CartDataService cService) {
    List<Widget> list = [];
    cService.cartList!.forEach((key, value) {
      value.forEach((e) {
        String attributes = e['attributes'].toString();
        String attributes2 = attributes.replaceAll('{', '');
        final attributes3 = attributes2.replaceAll('}', '');
        list.add(Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: screenWidth / 1.7,
                child: RichText(
                  text: TextSpan(
                      text: e['title'] as String,
                      style: TextThemeConstrants.greyHint13Eclipse,
                      children: [
                        if (e['attributes'] != null)
                          TextSpan(
                              text: (' (' + attributes3.toString() + ') ')
                                  .replaceAll('()', '')),
                        const TextSpan(text: 'X'),
                        TextSpan(
                            text: '${e['quantity']}',
                            style: const TextStyle(fontWeight: FontWeight.w600))
                      ]),
                ),
              ),
              Consumer<LanguageService>(builder: (context, lService, child) {
                return Text(
                  lService.currencyRTL
                      ? '${(e['price'] as double) * (e['quantity'] as int)}${lService.currency}'
                      : '${lService.currency}${(e['price'] as double) * (e['quantity'] as int)}',
                  style: TextThemeConstrants.greyHint13Eclipse,
                );
              })
            ],
          ),
        ));
      });
    });
    return list;
  }

  Widget rows(String leading, {String? trailing}) {
    final textStyle = TextStyle(
        color: cc.greyParagraph, fontSize: 15, fontWeight: FontWeight.bold);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          leading,
          style: textStyle,
        ),
        if (trailing != null)
          Text(
            trailing,
            style: textStyle,
          ),
      ],
    );
  }

  Future startPayment(BuildContext context, CheckoutService cService) async {
    final selectedGateaway =
        Provider.of<PaymentGateawayService>(context, listen: false)
            .selectedGateaway;
    if (selectedGateaway == null) {
      snackBar(context, asProvider.getString('Select a payment Gateway'));
      return;
    }

    if (selectedGateaway.name.contains('bank_transfer') ||
        selectedGateaway.name.contains('cheque_payment')) {
      bool continued = false;
      await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: GestureDetector(
                onTap: (() {
                  cService.imageSelector();
                }),
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      height: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: cc.primaryColor,
                          )),
                      child: Provider.of<CheckoutService>(context)
                                  .pickedImage ==
                              null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.image_outlined),
                                Text(asProvider
                                    .getString('Select an image from gallery')),
                              ],
                            )
                          : Image.file(cService.pickedImage!),
                    )),
              ),
              actions: [
                customContainerButton(
                    asProvider.getString('Continue'),
                    double.infinity,
                    Provider.of<CheckoutService>(context).pickedImage == null
                        ? () {
                            snackBar(
                                context,
                                asProvider
                                    .getString('Take an image to proceed'));
                          }
                        : () {
                            continued = true;
                            Navigator.of(context).pop();
                          })
              ],
            );
          });
      if (continued) {
        await cService.proccessCheckout(context);
        await showSuccessDialogue(context);
        Navigator.of(context).pop();
        return;
      }
      cService.pickedImage = null;
      return;
    }

    await cService.proccessCheckout(context);
    if (selectedGateaway.name == 'cash_on_delivery') {
      await showSuccessDialogue(context);
      Navigator.of(context).pop();
      return;
    }
    print('no confirming');
    print(selectedGateaway.name);
    if (selectedGateaway.name.toLowerCase().contains('marcadopago')) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => MercadopagoPayment(),
        ),
      );
      return;
    }
    if (selectedGateaway.name.toLowerCase().contains('paytm')) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => PaytmPayment(),
        ),
      );
      return;
    }
    if (selectedGateaway.name.toLowerCase().contains('paypal')) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => PaypalPayment(
            onFinish: (number) async {
              await Provider.of<ConfirmPaymentService>(context, listen: false)
                  .confirmPayment(context);
            },
          ),
        ),
      );
      return;
    }
    if (selectedGateaway.name.toLowerCase().contains('stripe')) {
      print('here');
      await StripePayment().makePayment(context);
      return;
    }
    if (selectedGateaway.name.toLowerCase().contains('razorpay')) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => RazorpayPayment(),
        ),
      );

      return;
    }
    if (selectedGateaway.name.toLowerCase().contains('paystack')) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => PaystackPayment(),
        ),
      );
      return;
    }
    if (selectedGateaway.name.toLowerCase().contains('flutterwave')) {
      FlutterWavePayment().makePayment(context);
      return;
    }
    if (selectedGateaway.name.toLowerCase().contains('cashfree')) {
      print('Paying using cashfree');
      await CashFreePayment()
          .doPayment(context)
          .onError((error, stackTrace) => null);
      return;
    }

    // }
    if (selectedGateaway.name.toLowerCase().contains('payfast')) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => PayfastPayment(),
        ),
      );
      return;
    }
    if (selectedGateaway.name.toLowerCase().contains('midtrans')) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => MidtransPayment(),
        ),
      );

      return;
    }
    if (selectedGateaway.name.toLowerCase().contains('instamojo')) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => InstamojoPayment(),
        ),
      );
      return;
    }
    if (selectedGateaway.name.toLowerCase().contains('mollie')) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => MolliePayment(),
        ),
      );
      return;
    }
  }

  Future showSuccessDialogue(BuildContext context) async {
    final cService = Provider.of<CheckoutService>(context, listen: false);
    await showDialog(
        useSafeArea: true,
        context: context,
        builder: (ctx) {
          return SizedBox(
            height: 300,
            child: AlertDialog(
              title: Text(asProvider.getString('Order submitted!')),
              content: SizedBox(
                width: 200,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: asProvider.getString(
                            "Your order has been successful! You'll receive ordered items in 3-5 days.") +
                        "\n" +
                        asProvider.getString("Your order ID  is") +
                        ' ',
                    style: TextThemeConstrants.paragraphText,
                    children: <TextSpan>[
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Provider.of<PaymentGateawayService>(context,
                                      listen: false)
                                  .setIsLoading(false);
                              Navigator.of(context)
                                  .push(MaterialPageRoute<void>(
                                builder: (BuildContext context) => OrderDetails(
                                    cService.checkoutModel!.id.toString()),
                              ));
                            },
                          text: ' #${cService.checkoutModel!.id}',
                          style: TextStyle(color: cc.primaryColor)),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    asProvider.getString('Ok'),
                    style: TextStyle(color: cc.primaryColor),
                  ),
                )
              ],
            ),
          );
        });
  }

  List<Widget> shippingAddress(BuildContext context) {
    List<Widget> list = [];
    final saService =
        Provider.of<ShippingAddressesService>(context, listen: false);
    final userData =
        Provider.of<UserProfileService>(context, listen: false).userProfileData;
    if (userData!.country != null && userData.address != null) {
      list.add(shippingBar(
          saService.currentAddress,
          saService,
          context,
          null,
          asProvider.getString('Current address'),
          Provider.of<UserProfileService>(context, listen: false)
              .userProfileData!
              .address));
      // saService.setSelectedAddress(null, context);
    } else {
      // Provider.of<ShippingZoneService>(context, listen: false).setNoData(true);
    }
    saService.shippingAddresseList.forEach((element) {
      list.add(shippingBar(saService.selectedAddress == element, saService,
          context, element, element.name, element.address));
    });
    if (list.isEmpty) {
      list.add(Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: FittedBox(
            child: Text(
              asProvider.getString(
                  "Add shipping address or all the account information's"),
              textAlign: TextAlign.center,
            ),
          )));
      // Provider.of<ShippingZoneService>(context, listen: false).setNoData(true);
      // Provider.of<ShippingAddressesService>(context, listen: false)
      //     .setNoData(true);
      return list;
    }
    return list;
  }

  Widget shippingBar(bool selected, ShippingAddressesService saService,
      BuildContext context, Datum? e, String addressName, String address) {
    return GestureDetector(
        onTap: () {
          if (e == null && !saService.currentAddress) {
            saService.setSelectedAddress(null, context);
            return;
          }
          if (saService.selectedAddress != null &&
              saService.selectedAddress == e) {
            print(saService.selectedAddress!.name);
            return;
          }
          saService.setSelectedAddress(e, context);
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 15),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: (addressName == asProvider.getString('Current address') &&
                          address ==
                              Provider.of<UserProfileService>(context,
                                      listen: false)
                                  .userProfileData!
                                  .address
                      ? saService.currentAddress
                      : saService.selectedAddress == e)
                  ? cc.lightPrimery3
                  : cc.whiteGrey,
              border: Border.all(
                  color:
                      (addressName == asProvider.getString('Current address') &&
                                  address ==
                                      Provider.of<UserProfileService>(context,
                                              listen: false)
                                          .userProfileData!
                                          .address
                              ? saService.currentAddress
                              : saService.selectedAddress == e)
                          ? cc.primaryColor
                          : cc.greyHint,
                  width: .5)),
          child: Stack(children: [
            ListTile(
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Text(addressName),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Text(address),
              ),
            ),
            if ((addressName == asProvider.getString('Current address') &&
                    address ==
                        Provider.of<UserProfileService>(context, listen: false)
                            .userProfileData!
                            .address
                ? saService.currentAddress
                : saService.selectedAddress == e))
              Positioned(
                  top: 10,
                  right:
                      Provider.of<LanguageService>(context, listen: false).rtl
                          ? null
                          : 15,
                  left: Provider.of<LanguageService>(context, listen: false).rtl
                      ? 15
                      : null,
                  child: Icon(
                    Icons.check_box,
                    color: cc.primaryColor,
                  ))
          ]),
        ));
  }
}
