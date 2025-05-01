import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gren_mart/view/utils/constant_name.dart';
import '../../service/common_service.dart';
import 'package:http/http.dart' as http;

class ManageAccountService with ChangeNotifier {
  String name = '';
  String email = '';
  String phoneNumber = '';
  String countryCode = 'BD';
  String countryId = '1';
  String stateId = '143';
  String? city = '';
  String? zipCode = '';
  String? address = '';
  String? imgUrl;
  File? pickeImage;
  bool isLoading = false;

  setInitialValue(nameValue, emailValue, phoneValue, countryIdValue,
      stateIdValue, cityValue, zipCodeValue, addressValue, imageUrl) {
    print(stateIdValue.toString() + '==================');
    name = nameValue;
    email = emailValue;
    phoneNumber = phoneValue;
    countryId = countryIdValue;
    stateId = stateIdValue;
    city = cityValue;
    zipCode = zipCodeValue;
    address = addressValue;
    imgUrl = imageUrl;
  }

  setName(value) {
    name = value;
    notifyListeners();
  }

  clearPickedImage() {
    pickeImage = null;
    notifyListeners();
  }

  setEmail(value) {
    email = value;
    notifyListeners();
  }

  setPhoneNumber(value) {
    phoneNumber = value;
    notifyListeners();
  }

  setCountryCode(value) {
    countryCode = value;
    notifyListeners();
  }

  setCountryID(value) {
    countryId = value;
    notifyListeners();
  }

  setStateId(value) {
    print(value);
    stateId = value;
    notifyListeners();
  }

  setCity(value) {
    city = value;
    notifyListeners();
  }

  setZipCode(value) {
    zipCode = value;
    notifyListeners();
  }

  setAddress(value) {
    address = value;
    notifyListeners();
  }

  setPickedImage(value) {
    pickeImage = value;
    notifyListeners();
  }

  setIsLoading(value) {
    isLoading = value;
    notifyListeners();
  }

  Future updateProfile() async {
    if (name.isEmpty ||
        email.isEmpty ||
        phoneNumber.isEmpty ||
        countryId.isEmpty ||
        stateId.isEmpty ||
        city == null ||
        city!.isEmpty ||
        zipCode == null ||
        address == null ||
        zipCode!.isEmpty ||
        address!.isEmpty) {
      return asProvider.getString('All Information must be provided');
    }
    print('Edit in process');
    Map<String, String> fieldss = {
      'name': name,
      'email': email,
      'phone': phoneNumber,
      'country_code': countryCode,
      'country': countryId,
      'state': stateId,
      'city': city ?? '',
      'zipcode': zipCode ?? '',
      'address': address ?? '',
    };
    print(fieldss);

    final url = Uri.parse('$baseApiUrl/user/update-profile');
    var request = http.MultipartRequest('POST', url);

    fieldss.forEach((key, value) {
      request.fields[key] = value;
    });
    request.headers.addAll(
      {
        "Accept": "application/json",
        "Authorization": "Bearer $globalUserToken",
      },
    );
    print(pickeImage);
    if (pickeImage != null) {
      print(pickeImage!.path);
      var multiport = await http.MultipartFile.fromPath(
        'file',
        pickeImage!.path,
      );

      request.files.add(multiport);
    }
    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);

    print(response.statusCode.toString() + '++++++++++++++');
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      notifyListeners();
      return;
    }
    if (response.statusCode == 500) {
      print(jsonDecode(response.body));
      return jsonDecode(response.body);
    }

    return;
    // throw '';
  }
  //   //  catch (error) {
  //   //   // print(error);

  //   //   rethrow;
  //   // }
  // }
}
