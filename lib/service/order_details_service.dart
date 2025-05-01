import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gren_mart/model/order_details_model.dart';
import 'package:gren_mart/service/common_service.dart';
import 'package:gren_mart/view/utils/constant_name.dart';
import 'package:http/http.dart' as http;

class OrderDetailsService with ChangeNotifier {
  late OrderDetailsModel orderDetailsModel;

  Future fetchOrderDetails(String id) async {
    final url =
        Uri.parse('$baseApiUrl/user/order-list/${id.replaceAll('#', '')}');
    final header = {'Authorization': 'Bearer $globalUserToken'};
    final response = await http.get(url, headers: header);
    orderDetailsModel = OrderDetailsModel.fromJson(jsonDecode(response.body));
    if (response.statusCode == 200) {
      print(response.body);
      orderDetailsModel = OrderDetailsModel.fromJson(jsonDecode(response.body));
      print(orderDetailsModel.product);

      return 'fetching success.';
    }
    print(jsonDecode(response.body));
    return;
  }
}
