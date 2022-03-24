import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../../../generated/locale_keys.g.dart';

Widget richTextInSignUp() => RichText(
      textAlign: TextAlign.center,
      text:  TextSpan(
        children: [
          TextSpan(
            text: LocaleKeys.Terms.tr(),
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xff3A0CA3),
            ),
          ),
           TextSpan(
            text: LocaleKeys.AND.tr(),
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              color: Color(0xff3A0CA3),
            ),
          ),
          TextSpan(
            text: LocaleKeys.Privacy_Policy.tr(),
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: Color(0xff3A0CA3),
            ),
          ),
        ],
      ),
    );
