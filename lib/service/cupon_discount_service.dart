import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gren_mart/view/utils/constant_name.dart';
import 'package:gren_mart/view/utils/constant_styles.dart';
import 'package:http/http.dart' as http;

import '../../service/common_service.dart';

class CuponDiscountService with ChangeNotifier {
  String? couponText;
  String? totalAmount;
  String? cartData;
  double couponDiscount = 0;
  bool isLoading = false;

  setIsLoading(value) {
    isLoading = value;
    notifyListeners();
  }

  setCouponText(value) {
    couponText = value;
    notifyListeners();
  }

  setTotalAmount(double value) {
    totalAmount = value.toStringAsFixed(0);
    notifyListeners();
  }

  setCarData(value) {
    cartData = value;
    notifyListeners();
  }

  clearCoupon() {
    couponText = null;
    totalAmount = null;
    cartData = null;
    couponDiscount = 0;
    isLoading = false;
  }

  Future<dynamic> getCuponDiscontAmount(BuildContext context) async {
    if (couponText == null || couponText == '') {
      return asProvider.getString('Enter a valid coupon');
    }
    isLoading = true;
    notifyListeners();
    final url = Uri.parse('$baseApiUrl/coupon');

    // try {
    final response = await http.post(url, body: {
      'coupon': couponText,
      'total_amount': totalAmount,
      'ids': cartData,
    });
    print(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      couponDiscount = json.decode(response.body)['coupon_amount'].toDouble();
      if (couponDiscount <= 0) {
        snackBar(context, 'Invalid coupon!', backgroundColor: cc.orange);
      } else {
        snackBar(context, asProvider.getString('Coupon applied!'));
      }
      isLoading = false;
      notifyListeners();
      return;
    }
    if (response.statusCode == 422) {
      final data = json.decode(response.body);
      print(data['coupon_amount']);
      isLoading = false;
      return data['coupon_amount'];
    }
    isLoading = false;
    //   return 'Someting went wrong';
    // } catch (error) {
    //   print(error);

    //   rethrow;
    // }
  }
}
