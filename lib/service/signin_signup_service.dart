import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gren_mart/view/utils/constant_styles.dart';
import '../../model/signin_model.dart';
import '../../model/signup_model.dart';
import '../../service/common_service.dart';
import '../../view/utils/constant_name.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignInSignUpService with ChangeNotifier {
  SignInModel? signInData;
  SignUpModel? signUpData;
  String? _token;
  var password;
  var email;
  bool login = true;
  bool isLoading = false;
  bool rememberPass = false;
  bool termsAndCondi = false;

  setToken(value) {
    _token = value;
    notifyListeners();
  }

  toggleSigninSignup({value}) {
    login = value ?? !login;
    notifyListeners();
  }

  toggleTermsAndCondi({bool? value}) {
    termsAndCondi = value ?? !termsAndCondi;
    notifyListeners();
  }

  toggleLaodingSpinner({bool? value}) {
    isLoading = value ?? !isLoading;
    print(isLoading.toString() + '------------------------');
    notifyListeners();
  }

  toggleRememberPass(bool? value) {
    rememberPass = value as bool;
    print(rememberPass);
    notifyListeners();
  }

  bool get isAuth {
    return token != null;
  }

  String? get userId {
    return signInData!.users.id.toString();
  }

  String? get token {
    if (_token == null) {
      return null;
    }
    return _token;
  }

  Future<bool> signInOption(
      BuildContext context, String? email, String? password) async {
    toggleLaodingSpinner(value: true);
    print('$email + $password');
    final url = Uri.parse('$baseApiUrl/login');

    // try {
    final response = await http.post(url, body: {
      'username': email!.toLowerCase().trim(),
      'password': password,
    });
    if (response.statusCode == 200) {
      print(response.body);
      final data = SignInModel.fromJson(jsonDecode(response.body));
      print(data);
      signInData = data;
      _token = signInData!.token;
      globalUserToken = _token;

      final pref = await SharedPreferences.getInstance();
      print('working on pref');
      final tokenData = json.encode({
        'token': signInData!.token,
      });
      await pref.setString('token', tokenData);
      if (rememberPass) {
        final userData = json.encode({
          'email': email,
          'password': password,
        });
        pref.setString('userData', userData);
      }
      if (!rememberPass) {
        resetEmailPassData();
      }

      notifyListeners();
      return true;
    }
    if (response.statusCode == 422) {
      snackBar(context, jsonDecode(response.body)['message'],
          backgroundColor: cc.orange);
    }

    return false;
    // } catch (error) {
    //   print(error);
    //   // snackBar(context, 'Login failed.');
    //   rethrow;
    // }
  }

  Future<bool> signUpOption(
      String email,
      String password,
      String name,
      String username,
      String phoneNumber,
      String countryCode,
      String countryId,
      String stateId,
      // String cityAdress,
      String termsAndCondition) async {
    toggleLaodingSpinner(value: true);
    toggleRememberPass(true);
    print(
        '$email + $password $name + $username + $phoneNumber + $countryCode + $countryId, $stateId + $termsAndCondition');

    final url = Uri.parse('$baseApiUrl/register');

    try {
      final response = await http.post(url, body: {
        'username': username.toLowerCase().trim(),
        'password': password.trim(),
        'full_name': name.trim(),
        'email': email.toLowerCase().trim(),
        'phone': phoneNumber,
        'country_id': countryId,
        'country_code': '00000000',
        'state_id': stateId,
        'terms_conditions': termsAndCondition,
      });
      print(response.body);
      if (response.statusCode == 200) {
        final data = SignUpModel.fromJson(jsonDecode(response.body));
        print(data.token);
        signUpData = data;
        print(signUpData!.token);
        _token = signUpData!.token;
        globalUserToken = _token;
        print(_token.toString() + '+++++++++++++++');

        final pref = await SharedPreferences.getInstance();
        print('working on pref');
        final tokenData = json.encode({
          'token': signUpData!.token,
        });

        await pref.setString('token', tokenData);
        if (rememberPass) {
          final userData = json.encode({
            'email': email,
            'password': password,
          });
          pref.setString('userData', userData);
        }

        notifyListeners();
        return true;
      }
      if (response.statusCode == 422) {
        final data = json.decode(response.body);
        final errors = data['validation_errors'];
        if (response.body.contains('message')) {
          toggleLaodingSpinner();
          throw data['message'];
        }
        if (errors!.containsKey('email')) {
          toggleLaodingSpinner();
          throw errors['email']![0];
        }
        if (errors.containsKey('username')) {
          toggleLaodingSpinner();
          throw errors['username']![0];
        }
        if (errors.containsKey('phone')) {
          toggleLaodingSpinner();
          throw errors['phone']![0];
        }
      }

      print(response.body);
      toggleLaodingSpinner(value: false);
      return false;
    } catch (error) {
      print(error);

      throw error;
    }
  }

  Future<dynamic> getToken() async {
    var token;
    final ref = await SharedPreferences.getInstance();
    if (!ref.containsKey('token')) {
      return;
    }
    final data = ref.getString('token');
    token = json.decode(data.toString());
    _token = token['token'];
    globalUserToken = _token;
    notifyListeners();
    print(token);
    return _token;
  }

  Future<bool> getUserData() async {
    final ref = await SharedPreferences.getInstance();
    if (!ref.containsKey('userData')) {
      return false;
    }
    final data = ref.getString('userData');
    final signinData = json.decode(data.toString()) as Map<String, dynamic>;
    email = signinData['email'];
    password = signinData['password'];
    print(signinData);
    toggleRememberPass(true);
    notifyListeners();
    return true;
  }

  Future<void> resetEmailPassData() async {
    final pref = await SharedPreferences.getInstance();
    pref.remove('userData');
    email = null;
    password = null;
    notifyListeners();
  }

  Future<void> signOut() async {
    final ref = await SharedPreferences.getInstance();
    if (!ref.containsKey('token')) {
      return;
    }
    ref.remove('token');
    globalUserToken = null;
    _token = '';

    notifyListeners();
    // print(token);
    return;
  }
}
