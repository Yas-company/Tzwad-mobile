import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gren_mart/service/state_dropdown_service.dart';
import 'package:gren_mart/service/user_profile_service.dart';
import 'package:provider/provider.dart';
import '../../model/country_dropdown_model.dart';
import '../../service/common_service.dart';
import 'package:http/http.dart' as http;

class CountryDropdownService with ChangeNotifier {
  List countryDropdownList = [];
  List countryDropdownIdList = [];
  var selectedCountry;
  var selectedCountryId;
  var countrySearchValue = '';
  bool countryLoading = false;
  String? nexPage = '';
  bool loadingNextPage = false;

  setCountryIdAndValue(var value, BuildContext context) {
    selectedCountry = value;
    int valueIndex;
    valueIndex = countryDropdownList.indexOf(value);
    selectedCountryId = countryDropdownIdList[valueIndex];
    Provider.of<StateDropdownService>(context, listen: false).resetState();
    print(selectedCountry + '-------' + selectedCountryId.toString());
    notifyListeners();
  }

  setCountrySearchValue(value) {
    if (value == countrySearchValue) {
      return;
    }
    countrySearchValue = value;
  }

  setCountryLoading(value) {
    if (value == countryLoading) {
      return;
    }
    countryLoading = value;
    notifyListeners();
  }

  setNextPageLoading(value) {
    if (value == loadingNextPage) {
      return;
    }
    loadingNextPage = value;
  }

  Future getContries(BuildContext context, {notFromAuth}) async {
    // if (countryDropdownList.isNotEmpty) {
    //   return;
    // }
    countryDropdownList = [];
    setCountryLoading(true);
    print('Fetching country');
    print('get countries function ran');
    final url = Uri.parse('$baseApiUrl/country?key=$countrySearchValue');

    try {
      // Provider.of<StateDropdownService>(context, listen: false).resetState();
      final response = await http.get(url);

      if (response.statusCode == 200) {
        var data = CountryDropdownModel.fromJson(jsonDecode(response.body));
        var nameList = [];
        var idList = [];
        for (int i = 0; i < data.countries!.data!.length; i++) {
          nameList.add(data.countries!.data![i].name ?? '');
          idList.add(data.countries!.data![i].id);
        }
        countryDropdownList = nameList;
        countryDropdownIdList = idList;
        nexPage = data.countries?.nextPageUrl;
        final countryData =
            Provider.of<UserProfileService>(context, listen: false);
        if (notFromAuth == null &&
            countryData.userProfileData?.country != null) {
          selectedCountry = countryData.userProfileData!.country!.name;
          selectedCountryId = countryData.userProfileData!.country!.id;
        } else {
          // selectedCountry = countryDropdownList[0];
          // selectedCountryId = countryDropdownIdList[0];
        }
        // await Provider.of<StateDropdownService>(context, listen: false)
        //     .getStates(selectedCountryId, context: context);
        print(selectedCountry);
        print(countryDropdownList.length);
        // print(response.body);
        print(response.statusCode);

        notifyListeners();
        // setCountryLoading(false);
        return selectedCountryId;
      } else {
        //something went wrong
      }
    } catch (error) {
      // snackBar(context, 'Connection failed!', backgroundColor: cc.orange);
      print(error);
      return;
    } finally {
      setCountryLoading(false);
    }
  }

  Future getNextPageContries(BuildContext context, {notFromAuth}) async {
    // if (countryDropdownList.isNotEmpty) {
    //   return;
    // }
    setNextPageLoading(true);
    print('Fetching country');
    print('get countries function ran');
    final url = Uri.parse('$nexPage');

    try {
      Provider.of<StateDropdownService>(context, listen: false).resetState();
      final response = await http.get(url);

      if (response.statusCode == 200) {
        var data = CountryDropdownModel.fromJson(jsonDecode(response.body));
        nexPage = data.countries?.nextPageUrl;
        for (int i = 0; i < data.countries!.data!.length; i++) {
          countryDropdownList.add(data.countries!.data![i].name ?? '');
          countryDropdownIdList.add(data.countries!.data![i].id);
        }
        final countryData =
            Provider.of<UserProfileService>(context, listen: false);
        if (notFromAuth == null &&
            countryData.userProfileData?.country != null) {
          selectedCountry = countryData.userProfileData!.country!.name;
          selectedCountryId = countryData.userProfileData!.country!.id;
        } else {
          // selectedCountry = countryDropdownList[0];
          // selectedCountryId = countryDropdownIdList[0];
        }
        // await Provider.of<StateDropdownService>(context, listen: false)
        //     .getStates(selectedCountryId, context: context);
        print(selectedCountry);
        print(countryDropdownList.length);
        // print(response.body);
        print(response.statusCode);

        notifyListeners();
        // setCountryLoading(false);
        return selectedCountryId;
      } else {
        //something went wrong
      }
    } catch (error) {
      // snackBar(context, 'Connection failed!', backgroundColor: cc.orange);
      print(error);
    } finally {
      setNextPageLoading(false);
    }
  }
}
