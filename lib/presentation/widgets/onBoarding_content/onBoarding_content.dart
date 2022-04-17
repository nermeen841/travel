// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel/constants/constants.dart';
import 'package:travel/presentation/screens/authentication/login_or_signup/login_or_signUp_screen.dart';

Widget buildSecondOnboard({required double w, required double h}) => Container(
    color: Colors.white,
    width: double.infinity,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: w * 0.08),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: h * 0.1),
            Row(
              children: [
                Image.asset(
                  'assets/images/Vector.png',
                  height: h * 0.03,
                  width: w * 0.09,
                  color: const Color(0xFF3A0CA3),
                ),
                SizedBox(
                  width: w * 0.04,
                ),
                Text(
                  'Travel',
                  style: TextStyle(
                      color: const Color(0xFF3A0CA3),
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins',
                      fontSize: w * 0.05),
                )
              ],
            ),
            SizedBox(
              height: h * 0.04,
            ),
            richText1_in_onBoarding(),
            SizedBox(
              height: h * 0.04,
            ),
            richText2_in_onBoarding(),
            SizedBox(
              height: h * 0.04,
            ),
            Center(
              child: Image.asset(
                'assets/images/Vacation.png',
                height: h * 0.4,
                width: w * 0.65,
                fit: BoxFit.contain,
              ),
            ),
          ]),
    ));

Widget buildThirdOnboard(
        {required double w, required double h, required context}) =>
    Container(
        color: Colors.white,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.08),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: h * 0.08),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/Vector.png',
                      height: h * 0.03,
                      width: w * 0.09,
                      color: const Color(0xFF3A0CA3),
                    ),
                    SizedBox(
                      width: w * 0.03,
                    ),
                    Text(
                      'Travel',
                      style: TextStyle(
                          color: const Color(0xFF3A0CA3),
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins',
                          fontSize: w * 0.05),
                    )
                  ],
                ),
                SizedBox(
                  height: h * 0.04,
                ),
                richText1_in_onBoarding(),
                SizedBox(
                  height: h * 0.04,
                ),
                richText2_in_onBoarding(),
                SizedBox(
                  height: h * 0.04,
                ),
                defaultButton(
                    title: 'GET STARTED',
                    textColor: Colors.white,
                    onPressed: () async {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      pref.setBool("onBoarding", true);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const LoginOrSignUpScreen()));
                    },
                    fontSize: w * 0.05,
                    height: h * 0.07,
                    width: w * 0.5,
                    color: const Color(0xFF3A0CA3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade500,
                        blurRadius: 5,
                        offset: const Offset(0, 3), // Shadow position
                      ),
                    ]),
                Center(
                  child: Image.asset(
                    'assets/images/Vacation.png',
                    height: h * 0.4,
                    width: w * 0.65,
                    fit: BoxFit.contain,
                  ),
                ),
              ]),
        ));

Widget buildFirstOnboard({required double w, required double h}) => Container(
    color: Colors.white,
    width: double.infinity,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: w * 0.08),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: h * 0.1),
            Row(
              children: [
                Image.asset(
                  'assets/images/Vector.png',
                  height: h * 0.03,
                  width: w * 0.09,
                  color: const Color(0xFF3A0CA3),
                ),
                SizedBox(
                  width: w * 0.04,
                ),
                Text(
                  'Travel',
                  style: TextStyle(
                      color: const Color(0xFF3A0CA3),
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins',
                      fontSize: w * 0.05),
                )
              ],
            ),
            SizedBox(
              height: h * 0.04,
            ),
            richText1_in_onBoarding(),
            SizedBox(
              height: h * 0.04,
            ),
            richText2_in_onBoarding(),
            SizedBox(
              height: h * 0.04,
            ),
            Center(
              child: Image.asset(
                'assets/images/Vacation.png',
                height: h * 0.4,
                width: w * 0.65,
                fit: BoxFit.contain,
              ),
            ),
          ]),
    ));

Widget richText1_in_onBoarding() => RichText(
      maxLines: 2,
      text: const TextSpan(
        children: [
          TextSpan(
            text: "Enjoy your holiday with",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
              fontSize: 30,
              color: Color(0xFF3A0CA3),
            ),
          ),
          TextSpan(
            text: " Travel",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              fontSize: 32,
              color: Color(0xFF3A0CA3),
            ),
          ),
        ],
      ),
    );
//Color(0xFF3A0CA380)
Widget richText2_in_onBoarding() => RichText(
      maxLines: 2,
      text: TextSpan(
        children: [
          TextSpan(
            text:
                "Keep your travel vey comfortable, easy and explor Egypt with ",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
              fontSize: 14,
              color: Colors.grey.shade400,
            ),
          ),
          TextSpan(
            text: " Travel",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              fontSize: 16,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
