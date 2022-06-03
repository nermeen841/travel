// ignore_for_file: unused_local_variable

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

Future<Locale> getLocale() async {
  Locale temp;
  String languageCode = prefs.getString('lang').toString();
  return temp = _locale(languageCode);
}
