import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gren_mart/service/common_service.dart';
import 'package:gren_mart/service/signin_signup_service.dart';
import 'package:gren_mart/view/utils/constant_name.dart';
import 'package:gren_mart/view/utils/constant_styles.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SocialLoginService with ChangeNotifier {
  bool isLoading = false;

  setIsLoading(value) {
    isLoading = value;
    notifyListeners();
  }

  Future facebookLogin(BuildContext context) async {
    try {
      final AccessToken? accessToken = await FacebookAuth.instance.accessToken;
// or FacebookAuth.i.accessToken
      // if (accessToken != null) {
      //   final userData = await FacebookAuth.i.getUserData(
      //     fields: "name,email,id",
      //   );
      //   print(userData['email']);
      //   print(userData['id']);
      //   print(userData['name']);
      //   return socialLogin(
      //       context, '0', userData['email'], userData['name'], userData['id']);
      // }

      final response = await FacebookAuth.i.login(
        permissions: [
          'email',
          'public_profile',
        ],
      );
      if (response.status == LoginStatus.success) {
        final userData = await FacebookAuth.i.getUserData(
          fields: "name,email,id",
        );
        print(userData['email']);
        print(userData['id']);
        print(userData['name']);
        return socialLogin(
            context, '0', userData['email'], userData['name'], userData['id']);
      }
      throw '';
    } catch (e) {
      throw '';
    }
  }

  Future googleLogin(BuildContext context) async {
    try {
      await GoogleSignIn().signOut();
      final response = await GoogleSignIn().signIn();
      return socialLogin(
          context, '1', response!.email, response.displayName, response.id);
    } catch (e) {
      print(e);
      snackBar(context, asProvider.getString('Loading failed'),
          backgroundColor: cc.orange);
      isLoading = false;
      notifyListeners();
    }
  }

  Future socialLogin(BuildContext context, isGoogle, email, name, id) async {
    final url = Uri.parse('$baseApiUrl/social/login');

    final response = await http.post(url, body: {
      'email': email.toString(),
      'isGoogle': isGoogle,
      'displayName': name.toString(),
      'id': id.toString(),
    });
    print(jsonDecode(response.body)['token']);
    if (response.statusCode == 200) {
      final loginData = jsonDecode(response.body);
      final pref = await SharedPreferences.getInstance();
      if (pref.containsKey('token')) {
        pref.remove('token');
      }
      print('working on pref');
      final tokenData = json.encode({
        'token': loginData['token'],
      });
      pref.setString('token', tokenData);
      globalUserToken = loginData['token'];
      print('here');
      Provider.of<SignInSignUpService>(context, listen: false)
          .setToken(globalUserToken);
      return loginData['token'];
    }
    print('why here');
    throw '';
  }
}
