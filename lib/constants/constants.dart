import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel/constants/colors.dart';

Widget defaultButton({
  required String title,
  required VoidCallback? onPressed,
  required double? fontSize,
  required double? height,
  required double? width,
  required Color color,
  required Color textColor,
  List<BoxShadow>? boxShadow,
  EdgeInsetsGeometry? margin,
}) =>
    Container(
      height: height,
      width: width,
      margin: margin,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
        boxShadow: boxShadow,

        //#3A0CA3
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700),
        ),
      ),
    );
//////////////////////////////////////////////////////////////////

late SharedPreferences prefs;
Future startShared() async {
  prefs = await SharedPreferences.getInstance();
}

///////////////////////////////////////////////////////////////////////

void dialog(context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        child: Opacity(
          opacity: 0.7,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black12,
            child: Center(
              child: CircularProgressIndicator(
                color: MyColors.mainColor,
              ),
            ),
          ),
        ),
        onWillPop: () async => false,
      );
    },
  );
}
