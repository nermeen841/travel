import 'package:flutter/material.dart';
import 'package:travel/constants/constants.dart';

Future<Locale> setLocale(String languageCode) async {
  prefs.setString('lang', languageCode);
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  Locale temp;
  switch (languageCode) {
    case 'ar':
      temp = const Locale('ar', '');
      break;
    case 'en':
      temp = const Locale('en', '');
      break;
    default:
      temp = const Locale('ar', '');
  }
  return temp;
}

Future<Locale> getLocale(context) async {
  String languageCode = prefs.getString('lang').toString();
  return context.local = _locale(languageCode);
}
