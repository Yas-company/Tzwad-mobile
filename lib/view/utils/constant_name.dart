import 'package:flutter/cupertino.dart';
import 'package:gren_mart/service/app_string_service.dart';
import 'package:provider/provider.dart';

double screenHight = 0;
double screenWidth = 0;
String? globalUserToken;
late AppStringService asProvider;
void initiateDeviceSize(BuildContext context) {
  screenHight = MediaQuery.of(context).size.height;
  screenWidth = MediaQuery.of(context).size.width;
  asProvider = Provider.of<AppStringService>(context, listen: false);
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

void setToken(value) {
  globalUserToken = value;
}
