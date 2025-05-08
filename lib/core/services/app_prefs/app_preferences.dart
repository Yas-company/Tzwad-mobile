import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tzwad_mobile/core/extension/language_type_extentions.dart';
import 'package:tzwad_mobile/core/resource/language_manager.dart';

String keyLang = "KEY_LANG";
String keyFontSize = "KEY_FONT_SIZE";

String keyIsUserLoggedIn = "KEY_IS_USER_LOGGED_IN";
String keyOnBoardingScreenViewed = "KEY_ON_BOARDING_SCREEN_VIEWED";

// user data key
String keyLoginInfo = "KEY_LOGIN_INFO";
String keyToken = "KEY_TOKEN";
// String keyRefreshToken = "KEY_REFRESH_TOKEN$versionSaveCash";
// String keyPassword = "KEY_PASSWORD$versionSaveCash";
// String keyIsBiometricEnabled = "KEY_IS_BIOMETRIC_ENABLED$versionSaveCash";
// String keyIsVisibleMessageBiometric = "KEY_IS_VISIBLE_MESSAGE_BIOMETRIC$versionSaveCash";
// String keySpecialPhoneNumber = "KEY_SPECIAL_PHONE_NUMBER$versionSaveCash";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  // region Language
  String getAppLanguage() {
    String? language = _sharedPreferences.getString(keyLang);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      // return default lang
      return LanguageType.arabic.getValue();
    }
  }

  bool isEnglish() {
    return getAppLanguage() == LanguageType.english.getValue();
  }

  Future<void> setLocale(String lang) async {
    _sharedPreferences.setString(keyLang, lang);
  }

  Locale getLocale() {
    String currentLang = getAppLanguage();

    if (currentLang == LanguageType.arabic.getValue()) {
      return arabicLocale;
    } else {
      return englishLocale;
    }
  }

  //endregion

  //region OnBoarding

  Future<void> setOnBoardingScreenViewed() async {
    _sharedPreferences.setBool(keyOnBoardingScreenViewed, true);
  }

  bool isOnBoardingScreenViewed() {
    return _sharedPreferences.getBool(keyOnBoardingScreenViewed) ?? false;
  }

  //endregion

  //region Login

  Future<void> setUserLogged() async {
    _sharedPreferences.setBool(keyIsUserLoggedIn, true);
  }

  bool isUserLogged() {
    return _sharedPreferences.getBool(keyIsUserLoggedIn) ?? false;
  }

  Future<void> setToken(String token) async {
    _sharedPreferences.setString(keyToken, token);
  }

  String getToken() {
    return _sharedPreferences.getString(keyToken) ?? '';
  }

//endregion
}
