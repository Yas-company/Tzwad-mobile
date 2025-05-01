import 'dart:convert';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gren_mart/model/checkout_model.dart';
import 'package:gren_mart/service/user_profile_service.dart';
import 'package:gren_mart/view/settings/manage_account.dart';
import 'package:gren_mart/view/utils/constant_name.dart';
import 'package:gren_mart/view/utils/constant_styles.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../service/common_service.dart';
import 'package:http/http.dart' as http;

import '../view/utils/text_themes.dart';
import 'cart_data_service.dart';
import 'cupon_discount_service.dart';
import 'payment_gateaway_service.dart';
import 'shipping_addresses_service.dart';
import 'shipping_zone_service.dart';
import '../view/order/order_details.dart' as order;

class CheckoutService with ChangeNotifier {
  CheckoutModel? checkoutModel;
  File? pickedImage;
  bool isLoading = false;
  bool termsAcondi = false;
  String? paytmResponse;

  setTermsACondi() {
    termsAcondi = !termsAcondi;
    notifyListeners();
  }

  setIsLoading(value) {
    isLoading = false;
    termsAcondi = false;
  }

  Future<void> imageSelector() async {
    try {
      final pickedFile =
          await ImagePicker.platform.pickImage(source: ImageSource.gallery);
      pickedImage = File(pickedFile!.path);
      notifyListeners();
    } catch (error) {
      print('error occured------------------------------------');
      print(error.toString());
    }
  }

  Future proccessCheckout(BuildContext context) async {
    print('checkout in process');

    final userData = Provider.of<UserProfileService>(context, listen: false)
        .userProfileData!;
    final cartData = Provider.of<CartDataService>(context, listen: false);
    final shippingAddress =
        Provider.of<ShippingAddressesService>(context, listen: false);
    final shippingZone =
        Provider.of<ShippingZoneService>(context, listen: false);
    final couponData =
        Provider.of<CuponDiscountService>(context, listen: false);
    final selectedGateway =
        Provider.of<PaymentGateawayService>(context, listen: false)
            .selectedGateaway!;

    final clist = Provider.of<CartDataService>(context, listen: false).cartList;
    Map<String, List<Map<String, Object?>>>? formatedCartItem = clist;
    final taxAmount = shippingZone.taxMoney(context);
    final subTotal = ((cartData.calculateSubtotal())).toString();
    print(couponData.couponDiscount);
    print(subTotal);
    if (shippingAddress.selectedAddress == null &&
        (userData.city == null ||
            userData.city!.isEmpty ||
            userData.address == null ||
            userData.address.isEmpty ||
            userData.zipcode == null ||
            userData.zipcode!.isEmpty ||
            userData.phone == null ||
            userData.phone!.isEmpty ||
            userData.country == null ||
            userData.state == null)) {
      await showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text(asProvider.getString('Insufficient data?')),
              content: Text(asProvider
                  .getString('Please provide all the profile Information.')),
              actions: [
                TextButton(
                    onPressed: (() {
                      Navigator.pop(context);
                    }),
                    child: Text(
                      asProvider.getString('Not now'),
                      style: TextStyle(color: cc.pink),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(ManageAccount.routeName)
                          .then((value) {
                        Provider.of<ShippingAddressesService>(context,
                                listen: false)
                            .fetchUsersShippingAddress(context,
                                loadShippingZone: true);
                        Navigator.of(context).pop();
                      });
                    },
                    child: Text(
                      asProvider.getString('Add now'),
                      style: TextStyle(color: cc.primaryColor),
                    ))
              ],
            );
          });
      throw '';
    }
    if (cartData.calculateSubtotal() <
        (shippingZone.selectedOption?.options.minimumOrderAmount ?? 0)) {
      snackBar(
          context,
          asProvider.getString("Order total does not meet minimum for") +
                  ' ${shippingZone.selectedOption?.name}' ??
              "",
          backgroundColor: cc.orange);
      throw '';
    }
    if (selectedGateway.name == 'paytm') {
      await paytmCheckout(context);
      return;
    }
    bool notCurrent = shippingAddress.selectedAddress != null;
    Map<String, dynamic> fieldss = {
      'name':
          notCurrent ? shippingAddress.selectedAddress!.name : userData.name,
      'email':
          notCurrent ? shippingAddress.selectedAddress!.email : userData.email,
      'country': notCurrent
          ? shippingAddress.selectedAddress!.countryId.toString()
          : (userData.country == null ? '' : userData.country!.id.toString()),
      'address': notCurrent
          ? shippingAddress.selectedAddress!.address
          : userData.address,
      'city': notCurrent
          ? shippingAddress.selectedAddress!.city
          : userData.city ?? '',
      'state': notCurrent
          ? shippingAddress.selectedAddress!.stateId.toString()
          : (userData.state == null ? '' : userData.state!.id.toString()),
      'zipcode': notCurrent
          ? shippingAddress.selectedAddress!.zipCode
          : userData.zipcode ?? '',
      'phone': notCurrent
          ? shippingAddress.selectedAddress!.phone
          : userData.phone ?? '',
      'shipping_address_id':
          notCurrent ? shippingAddress.selectedAddress!.id.toString() : '',
      'selected_shipping_option':
          shippingZone.selectedOption?.id.toString() ?? "",
      'tax_amount': taxAmount.toString(),
      'coupon': couponData.couponText ?? '',
      'agree': 'on',
      'sub_total': subTotal,
      'products_ids': jsonEncode(cartData.cartList!.keys.toList()),
      'all_cart_items': jsonEncode(cartData.formatItems()),
      'coupon_amount': couponData.couponDiscount.toString()
    };
    print(fieldss);

    final url = Uri.parse('$baseApiUrl/user/checkout');
    var request = http.MultipartRequest('POST', url);

    fieldss.forEach((key, value) {
      request.fields[key] = value is String ? value : value.toString();
    });
    request.headers.addAll(
      {
        "Accept": "application/json",
        "Authorization": "Bearer $globalUserToken",
      },
    );
    print(pickedImage);
    if (pickedImage != null &&
        (selectedGateway.name.contains('bank_transfer') ||
            selectedGateway.name.contains('cheque_payment'))) {
      print('pickedImage!.path');
      var multiport = await http.MultipartFile.fromPath(
        selectedGateway.name.contains('bank_transfer')
            ? 'bank_payment_input'
            : 'check_payment_input',
        pickedImage!.path,
      );

      request.files.add(multiport);
    }
    var streamedResponse = await request.send();
    // try {
    var response = await http.Response.fromStream(streamedResponse);

    print(response.statusCode.toString() + '++++++++++++++');
    if (response.statusCode == 201) {
      checkoutModel = CheckoutModel.fromJson(jsonDecode(response.body));
      // if (selectedGateaway.name == 'cash_on_delivery' ||
      //     selectedGateaway.name.contains('bank_transfer') ||
      //     selectedGateaway.name.contains('cheque_payment')) {
      //   await showDialogue(context);
      // }
      if (selectedGateway.name == 'paytm') {
        await paytmCheckout(context);
      }
      if (selectedGateway.name == 'bank_transfer' ||
          selectedGateway.name == 'cheque_payment' ||
          selectedGateway.name == 'cash_on_delivery') {
        cartData.emptyCart();
      }
      print(jsonDecode(response.body));
      // Provider.of<CartDataService>(context, listen: false).emptyCart();
      notifyListeners();
      return;
    }
    if (response.statusCode == 500) {
      print(jsonDecode(response.body));
      throw asProvider.getString('Connection failed');
    }

    return;
    // throw '';
    // } catch (error) {
    //   // print(error);

    //   rethrow;
    // }
  }

  Future paytmCheckout(BuildContext context) async {
    final userData = Provider.of<UserProfileService>(context, listen: false)
        .userProfileData!;
    final cartData = Provider.of<CartDataService>(context, listen: false);
    final shippingAddress =
        Provider.of<ShippingAddressesService>(context, listen: false);
    final shippingZone =
        Provider.of<ShippingZoneService>(context, listen: false);
    final cuponData = Provider.of<CuponDiscountService>(context, listen: false);
    final selectedGateaway =
        Provider.of<PaymentGateawayService>(context, listen: false)
            .selectedGateaway!;
    final taxAmount = shippingZone.taxMoney(context);
    final clist = Provider.of<CartDataService>(context, listen: false).cartList;
    Map<String, List<Map<String, Object?>>>? formatedCartItem = clist;
    final subTotal = cartData.calculateSubtotal().toString();
    bool notCurrent = shippingAddress.selectedAddress != null;
    Map<String, dynamic> fieldss = {
      'name':
          notCurrent ? shippingAddress.selectedAddress!.name : userData.name,
      'email':
          notCurrent ? shippingAddress.selectedAddress!.email : userData.email,
      'country': notCurrent
          ? shippingAddress.selectedAddress!.countryId
          : (userData.country == null ? '' : userData.country!.id.toString()),
      'address': notCurrent
          ? shippingAddress.selectedAddress!.address
          : userData.address,
      'city': notCurrent
          ? shippingAddress.selectedAddress!.city
          : userData.city ?? '',
      'state': notCurrent
          ? shippingAddress.selectedAddress!.stateId
          : (userData.state == null ? '' : userData.state!.id.toString()),
      'zipcode': notCurrent
          ? shippingAddress.selectedAddress!.zipCode
          : userData.zipcode ?? '',
      'phone': notCurrent
          ? shippingAddress.selectedAddress!.phone
          : userData.phone ?? '',
      'shipping_address_id':
          notCurrent ? shippingAddress.selectedAddress!.id.toString() : '',
      'selected_shipping_option': shippingZone.selectedOption!.id.toString(),
      'tax_amount': taxAmount.toString(),
      'coupon': cuponData.couponText ?? '',
      'agree': 'on',
      'sub_total': subTotal,
      'products_ids': jsonEncode(cartData.cartList!.keys.toList()),
      'all_cart_items': jsonEncode(cartData.formatItems()),
      'coupon_amount': cuponData.couponDiscount.toString()
    };

    final url = Uri.parse('$baseApiUrl/user/checkout-paytm');
    var request = http.MultipartRequest('POST', url);

    fieldss.forEach((key, value) {
      request.fields[key] = value is String ? value : value.toString();
    });
    request.headers.addAll(
      {
        "Accept": "application/json",
        "Authorization": "Bearer $globalUserToken",
      },
    );
    print(pickedImage);
    if (pickedImage != null &&
        (selectedGateaway.name.contains('bank_transfer') ||
            selectedGateaway.name.contains('cheque_payment'))) {
      print('pickedImage!.path');
      var multiport = await http.MultipartFile.fromPath(
        selectedGateaway.name.contains('bank_transfer')
            ? 'bank_payment_input'
            : 'check_payment_input',
        pickedImage!.path,
      );

      request.files.add(multiport);
    }
    var streamedResponse = await request.send();
    // try {
    var response = await http.Response.fromStream(streamedResponse);

    print(response.statusCode.toString() + '++++++++++++++');
    if (response.statusCode == 200) {
      paytmResponse = response.body;
      return;
    }
    if (response.statusCode == 500) {
      print(jsonDecode(response.body));
      throw asProvider.getString('Connection failed');
    }

    return;
    // throw '';
    // } catch (error) {
    //   // print(error);

    //   rethrow;
    // }
  }

  Future showDialogue(BuildContext context) async {
    await showDialog(
        useSafeArea: false,
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
                        "Your order has been successful! You'll receive ordered items in 3-5 days. Your order ID  is"),
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
                                builder: (BuildContext context) =>
                                    order.OrderDetails(
                                        checkoutModel!.id.toString()),
                              ));
                            },
                          text: ' #${checkoutModel!.id}',
                          style: TextStyle(color: cc.primaryColor)),
                    ],
                  ),
                ),
              ),
              actions: [
                Spacer(),
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
}
