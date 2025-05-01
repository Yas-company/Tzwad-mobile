import 'package:flutter/material.dart';
import 'package:gren_mart/service/country_dropdown_service.dart';
import 'package:gren_mart/service/state_dropdown_service.dart';
import 'package:gren_mart/service/user_profile_service.dart';
import 'package:provider/provider.dart';
import '../../model/shipping_addresses_model.dart';
import 'dart:convert';

import '../../service/common_service.dart';
import '../../view/utils/constant_name.dart';
import 'package:http/http.dart' as http;

import 'shipping_zone_service.dart';

class ShippingAddressesService with ChangeNotifier {
  List<Datum> shippingAddresseList = [];
  Datum? selectedAddress;
  bool isLoading = false;
  bool changePassLoading = false;
  String? name;
  String? email;
  String? phone;
  String? countryCode;
  String countryId = '1';
  String stateID = '143';
  String? zipCode;
  String? address;
  String? city;
  bool alertBoxLoading = false;
  bool noData = false;
  bool firstLoad = true;
  bool currentAddress = false;

  setName(value) {
    name = value;
    notifyListeners();
  }

  clearSelectedAddress() {
    selectedAddress = null;
    noData = false;
    isLoading = false;
    firstLoad = true;
    currentAddress = false;
    notifyListeners();
  }

  clearAll() {
    noData = false;
    isLoading = false;
    name = null;
    email = null;
    phone = null;
    countryCode = null;
    zipCode = null;
    countryId = '1';
    stateID = '1';
    address = null;
    city = null;
    firstLoad = true;
    notifyListeners();
  }

  setCity(value) {
    city = value;
    notifyListeners();
  }

  setAddress(value) {
    address = value;
    notifyListeners();
  }

  setPhone(value) {
    phone = value;
    notifyListeners();
  }

  setEmail(value) {
    email = value;
    notifyListeners();
  }

  setZipCode(value) {
    zipCode = value;
    notifyListeners();
  }

  setCountryId(value) {
    countryId = value;
    notifyListeners();
  }

  setStateId(value) {
    stateID = value;
    notifyListeners();
  }

  setSelectedAddress(value, BuildContext context) async {
    print(value);
    final userProfile = Provider.of<UserProfileService>(context, listen: false)
        .userProfileData!;
    // if (userProfile.city == null) {
    //   Provider.of<ShippingZoneService>(context, listen: false).setNoData(true);
    //   return;
    // }
    if (value == null && (selectedAddress != null || firstLoad)) {
      selectedAddress = value;
      firstLoad = false;
      await Provider.of<ShippingZoneService>(context, listen: false)
        ..resetChecout()
        ..fetchContriesZone(userProfile.country!.id, userProfile.state!.id);
      currentAddress = true;
      notifyListeners();
      return;
    }
    if (value == null && selectedAddress == null) {
      return;
    }
    currentAddress = false;
    print('selecting $value');
    selectedAddress = value;
    Provider.of<ShippingZoneService>(context, listen: false)
      ..resetChecout()
      ..fetchContriesZone(selectedAddress!.countryId, selectedAddress!.stateId);
    print('selection done $value');
    notifyListeners();
  }

  setDefaultCountryState(BuildContext context) {
    countryId = Provider.of<CountryDropdownService>(context, listen: false)
        .selectedCountryId
        .toString();
    stateID = Provider.of<StateDropdownService>(context, listen: false)
        .selectedStateId
        .toString();
  }

  setCountryCode(value) {
    countryCode = value;
    notifyListeners();
  }

  setIsLoading(value) {
    isLoading = value;
    notifyListeners();
  }

  setAlertBoxLoading(value) {
    alertBoxLoading = value;
    notifyListeners();
  }

  setNoData(value) {
    noData = value;
    selectedAddress = null;
    isLoading = false;
    notifyListeners();
  }

  Future<dynamic> fetchUsersShippingAddress(BuildContext context,
      {bool loadShippingZone = false}) async {
    print('$globalUserToken --------------');
    final url = Uri.parse('$baseApiUrl/user/all-shipping-address');
    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      'Content-Type': 'application/json',
      "Authorization": "Bearer $globalUserToken",
    };
    // try {
    final response = await http.get(url, headers: header);
    if (response.statusCode == 200) {
      final data = ShippingAddressesModel.fromJson(jsonDecode(response.body));
      shippingAddresseList = data.data;
      // setNoData(shippingAddresseList.isEmpty);
      // Provider.of<ShippingZoneService>(context, listen: false)
      //     .setNoData(shippingAddresseList.isEmpty);
      if (shippingAddresseList.isEmpty) {
        noData = true;
        notifyListeners();
      }
      // selectedAddress ??= shippingAddresseList[0];
      // if (loadShippingZone) {
      //   Provider.of<ShippingZoneService>(
      //     context,
      //     listen: false,
      //   ).fetchContriesZone(
      //       selectedAddress!.countryId, selectedAddress!.stateId);
      // }

      notifyListeners();
      return;
    }
    if (response.statusCode == 422) {
      final data = json.decode(response.body);
      print(data['message']);
      return data['message'];
    }

    return asProvider.getString('Something went wrong');
    // } catch (error) {
    //   print(error);

    //   rethrow;
    // }
  }

  Future<dynamic> addShippingAddress() async {
    print('$globalUserToken --------------');
    final url = Uri.parse('$baseApiUrl/user/store-shipping-address');
    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      "Authorization": "Bearer $globalUserToken",
    };
    if (stateID == 1) {
      return asProvider.getString('Please select a state.');
    }
    try {
      final response = await http.post(url, headers: header, body: {
        'name': name,
        'email': email,
        'phone': phone,
        'country': countryId,
        'state': stateID,
        'city': city,
        'zip_code': zipCode,
        'address': address,
      });
      print(response.body);
      if (response.statusCode == 200) {
        print(response.body);
        notifyListeners();
        return;
      }
      if (response.statusCode == 422) {
        final data = json.decode(response.body);
        print(data['message']);
        return data['message'];
      }

      return asProvider.getString('Something went wrong');
    } catch (error) {
      print(error);

      rethrow;
    }
  }

  Future<dynamic> deleteSingleAddress(id) async {
    print('$globalUserToken --------------');
    final url = Uri.parse('$baseApiUrl/user/shipping-address/delete/$id');
    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      "Authorization": "Bearer $globalUserToken",
    };
    // try {
    final response = await http.get(url, headers: header);
    if (response.statusCode == 200) {
      print(response.body);
      shippingAddresseList.removeWhere((element) => element.id == id);
      if (shippingAddresseList.isEmpty) {
        noData = true;
        selectedAddress = null;
      }
      notifyListeners();
      return;
    }
    if (response.statusCode == 422) {
      final data = json.decode(response.body);
      print(data['message']);
      return data['message'];
    }

    return asProvider.getString('Something went wrong');
    // } catch (error) {
    //   print(error);

    //   rethrow;
    // }
  }
}
