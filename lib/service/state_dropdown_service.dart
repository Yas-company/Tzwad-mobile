import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gren_mart/service/manage_account_service.dart';
import 'package:gren_mart/service/shipping_addresses_service.dart';
import 'package:provider/provider.dart';
import '../../model/state_dropdown_model.dart';
import '../../service/common_service.dart';
import 'package:http/http.dart' as http;

class StateDropdownService with ChangeNotifier {
  List stateDropdownList = [];
  List stateDropdownIdList = [];
  late List<Datum> allState;
  var selectedState;
  String? selectedStateId;
  var stateSearchValue = '';
  dynamic nexPage;
  bool loadingNextPage = false;

  bool isLoading = false;

  resetState() {
    isLoading = true;
    stateSearchValue = '';
    nexPage = null;
    selectedState = null;
    notifyListeners();
  }

  setStateIdAndValue(value, {valueID}) {
    selectedState = value;
    final valueIndex = stateDropdownList.indexOf(value);
    selectedStateId = valueID ?? stateDropdownIdList[valueIndex].toString();
    print(selectedState + selectedStateId.toString() + '---------------');
    notifyListeners();
  }

  setStateIdAndValueDefault() {
    // print(allState.length);
    final valueState = allState[0];
    selectedState = valueState.name;
    selectedStateId = valueState.id.toString();
    print(selectedState + selectedStateId.toString() + '---------------');
    notifyListeners();
  }

  setStateSearchValue(value) {
    if (value == stateSearchValue) {
      return;
    }
    stateSearchValue = value;
  }

  setLoading(value) {
    if (value == isLoading) {
      return;
    }
    isLoading = value;
    notifyListeners();
  }

  Future getStates(selectedCountryId, {BuildContext? context}) async {
    // print('getting state data____________' + selectedCountryId.toString());

    setLoading(true);
    notifyListeners();
    final url =
        Uri.parse('$baseApiUrl/state/$selectedCountryId?key=$stateSearchValue');
    print('$baseApiUrl/state/$selectedCountryId?key=$stateSearchValue');
    try {
      final response = await http.get(
        url,
      );
      if (response.statusCode == 200) {
        final data = StateDropdownModel.fromJson(jsonDecode(response.body));
        var stateData = [];
        var stateIdData = [];
        nexPage = data.state?.nextPageUrl;

        allState = data.state!.data!;
        for (int i = 0; i < data.state!.data!.length; i++) {
          var element = data.state!.data![i];
          stateData.add(element.name);
          stateIdData.add(element.id);
        }
        stateDropdownList = stateData;
        stateDropdownIdList = stateIdData;

        // setStateIdAndValue(selectedCountryId);
        isLoading = false;

        notifyListeners();
        if (context != null) {
          setStateIdAndValueDefault();
          Provider.of<ShippingAddressesService>(context, listen: false)
              .setDefaultCountryState(context);
          Provider.of<ManageAccountService>(context, listen: false)
              .setCountryID(selectedCountryId.toString());
          Provider.of<ManageAccountService>(context, listen: false)
              .setStateId(selectedStateId);
        }
        return selectedCountryId;
      } else {
        // print('something went wrong');
      }
    } catch (error) {
      print(error);
      // snackBar(context!, 'Connection failed!', backgroundColor: cc.orange);

      // return;
    } finally {
      setLoading(false);
    }
  }

  Future getNextStates(selectedCountryId, {BuildContext? context}) async {
    // print('getting state data____________' + selectedCountryId.toString());

    loadingNextPage = true;
    notifyListeners();
    final url = Uri.parse('$nexPage');

    try {
      final response = await http.get(
        url,
      );
      if (response.statusCode == 200) {
        final data = StateDropdownModel.fromJson(jsonDecode(response.body));
        var stateData = [];
        var stateIdData = [];
        nexPage = data.state?.nextPageUrl;
        allState = data.state!.data!;
        for (int i = 0; i < data.state!.data!.length; i++) {
          var element = data.state!.data![i];
          stateData.add(element.name);
          stateIdData.add(element.id);
        }
        stateDropdownList = stateData;
        stateDropdownIdList = stateIdData;

        // setStateIdAndValue(selectedCountryId);
        isLoading = false;

        notifyListeners();
        if (context != null) {
          setStateIdAndValueDefault();
          Provider.of<ShippingAddressesService>(context, listen: false)
              .setDefaultCountryState(context);
          Provider.of<ManageAccountService>(context, listen: false)
              .setCountryID(selectedCountryId.toString());
          Provider.of<ManageAccountService>(context, listen: false)
              .setStateId(selectedStateId);
          print(selectedCountryId);
          print(selectedStateId);
        }
        return selectedCountryId;
      } else {
        // print('something went wrong');
      }
    } catch (error) {
      print(error);
      // snackBar(context!, 'Connection failed!', backgroundColor: cc.orange);

      // return;
    } finally {
      loadingNextPage = false;
    }
  }
}
