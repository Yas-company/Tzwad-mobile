import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gren_mart/view/utils/constant_name.dart';
import '../../model/user_profile_model.dart';
import '../../service/common_service.dart';
import 'package:http/http.dart' as http;

class UserProfileService with ChangeNotifier {
  UserDetails? userProfileData;

  userLogout() {
    userProfileData = null;
    notifyListeners();
  }

  Future<UserDetails?> fetchProfileService() async {
    print('fetching profile data');

    final url = Uri.parse('$baseApiUrl/user/profile');

    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $globalUserToken",
    };

    // try {
    final response = await http.get(url, headers: header);
    if (response.statusCode == 200) {
      final data = UserProfileModel.fromJson(jsonDecode(response.body));
      userProfileData = data.userDetails;
      print(userProfileData);
      print(data.userDetails.name);

      // posterDataList = data.data;
      print(userProfileData!.name +
          userProfileData!.email.toString() +
          '---------------');
      // print('-------------------------------------');
      notifyListeners();
      return userProfileData;
    }

    return null;
    // throw '';
  }
  //   //  catch (error) {
  //   //   // print(error);

  //   //   rethrow;
  //   // }
  // }
}
