import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


/// Fallback delegate for Yoruba since it's not officially supported by GlobalMaterialLocalizations yet.
/// This will use English for basic Material components (tooltips, etc.) while allowing the app to use Yoruba.
class YoMaterialLocalizationsDelegate extends LocalizationsDelegate<MaterialLocalizations> {
  const YoMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'yo';

  @override
  Future<MaterialLocalizations> load(Locale locale) => GlobalMaterialLocalizations.delegate.load(const Locale('en'));

  @override
  bool shouldReload(YoMaterialLocalizationsDelegate old) => false;
}

class YoCupertinoLocalizationsDelegate extends LocalizationsDelegate<CupertinoLocalizations> {
  const YoCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'yo';

  @override
  Future<CupertinoLocalizations> load(Locale locale) => GlobalCupertinoLocalizations.delegate.load(const Locale('en'));

  @override
  bool shouldReload(YoCupertinoLocalizationsDelegate old) => false;
}

class YoWidgetsLocalizationsDelegate extends LocalizationsDelegate<WidgetsLocalizations> {
  const YoWidgetsLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'yo';

  @override
  Future<WidgetsLocalizations> load(Locale locale) => GlobalWidgetsLocalizations.delegate.load(const Locale('en'));

  @override
  bool shouldReload(YoWidgetsLocalizationsDelegate old) => false;
}
