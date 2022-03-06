// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';

class MyColors {
  static Color mainColor = const Color(0xff3a0ca3);
  static Color unslectedIconColor = Colors.black.withOpacity(0.5);
  static Color gradientColor1 = const Color(0xff3a0ca300);
  static Color gradientColor2 = const Color(0xff3a0ca3db);
  static const backgroundColor = Color(0xffe5e5e5);
  static const colorGreen = Color(0xff24B824);
}

TextStyle headingStyle =
    TextStyle(fontFamily: 'Poppins', color: MyColors.mainColor);
