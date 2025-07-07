import 'dart:ui';

import 'package:tzwad_mobile/core/extension/language_type_extentions.dart';
import 'package:tzwad_mobile/core/local_data/app_hive_adapter_enum.dart';
import 'package:tzwad_mobile/core/local_data/app_local_data.dart';
import 'package:tzwad_mobile/core/resource/language_manager.dart';

String keyOnBoardingScreenViewed = "KEY_ON_BOARDING_SCREEN_VIEWED";
String keyIsUserLoggedIn = "KEY_IS_USER_LOGGED_IN";
String keyToken = "KEY_TOKEN";
String keyLang = "KEY_LANG";
String keyFontSize = "KEY_FONT_SIZE";

class SettingLocalData extends AppLocalData<dynamic> {
  SettingLocalData()
      : super(
          boxName: AppHiveAdapterEnum.settingAdapter.boxName,
        );

  void setToken(String token) {
    insert(keyToken, token);
  }

  String getToken() {
    return getByKey(keyToken) ?? '';
  }

  void setLanguageApp(String token) {
    insert(keyLang, token);
  }

  String getLanguageApp() {
    return getByKey(keyLang) ?? LanguageType.arabic.getValue();
  }

  Locale getLocale() {
    String currentLang = getLanguageApp();

    if (currentLang == LanguageType.arabic.getValue()) {
      return arabicLocale;
    } else {
      return englishLocale;
    }
  }

  void setUserLogged() {
    insert(keyIsUserLoggedIn, true);
  }

  bool isUserLogged() {
    return getByKey(keyIsUserLoggedIn) ?? false;
  }

  void setOnBoardingScreenViewed() {
    insert(keyOnBoardingScreenViewed, true);
  }

  bool isOnBoardingScreenViewed() {
    return getByKey(keyOnBoardingScreenViewed) ?? false;
  }

  Future<void> clearBox() async {
    await box.clear();
  }
}
