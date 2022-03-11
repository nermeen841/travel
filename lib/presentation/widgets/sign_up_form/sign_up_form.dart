import 'package:flutter/cupertino.dart';

Widget richTextInSignUp() => RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
        children: [
          TextSpan(
            text: "Terms & condition",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xff3A0CA3),
            ),
          ),
          TextSpan(
            text: " and",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              color: Color(0xff3A0CA3),
            ),
          ),
          TextSpan(
            text: " Privacy policy",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: Color(0xff3A0CA3),
            ),
          ),
        ],
      ),
    );
