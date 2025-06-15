import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/language_manager.dart';
import 'package:tzwad_mobile/core/resource/theme_manager.dart';
import 'package:tzwad_mobile/core/routes/router_manager.dart';
import 'package:tzwad_mobile/core/util/constants.dart';

import 'widgets/main_app_body.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: RouterManager.router,
      debugShowCheckedModeBanner: false,
      title: Constants.appName,
      builder: (context, child) => MainAppBody(
        child: child!,
      ),
      locale: arabicLocale,
      supportedLocales: const [
        englishLocale,
        arabicLocale,
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        for (var locale in supportedLocales) {
          if (deviceLocale != null && deviceLocale.languageCode == locale.languageCode) {
            return deviceLocale;
          }
        }
        return supportedLocales.first;
      },
      theme: LightModeTheme().getThemeData(
        fontFamily: FontConstants.fontTajawal,
      ),
    );
  }
}
