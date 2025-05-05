import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum LanguageType { english, arabic }

const String arabic = "ar";
const String english = "en";
const String assetPathLocalizations = "assets/translation";

const Locale arabicLocale = Locale("ar", "SA");
const Locale englishLocale = Locale("en", "US");

class AppLocalizations {
  final Locale? locale;

  AppLocalizations({
    this.locale,
  });

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  late Map<String, String> _localizedStrings;

  Future loadJsonLanguage() async {
    String jsonString = await rootBundle.loadString("$assetPathLocalizations/${locale!.languageCode}-${locale!.countryCode}.json");

    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
  }

  String translate(String key) => _localizedStrings[key] ?? key;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return [english, arabic].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale: locale);
    await localizations.loadJsonLanguage();
    return localizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) => false;
}

extension TranslateX on String {
  String tr(context) {
    return AppLocalizations.of(context)!.translate(this);
  }
}
