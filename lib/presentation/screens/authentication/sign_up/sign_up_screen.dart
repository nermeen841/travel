// ignore_for_file: use_key_in_widget_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:travel/generated/locale_keys.dart';
import 'package:travel/presentation/screens/authentication/sign_up/componnent/form.dart';
import 'package:travel/presentation/widgets/sign_up_form/sign_up_form.dart';

// ignore: must_be_immutable
class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return PreferredSize(
      preferredSize: Size(w, h),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xffF8CBAF).withOpacity(0.99),
              Colors.white,
              Colors.white,
              Colors.white,
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: w * 0.05,
            ),
            shrinkWrap: true,
            primary: true,
            children: [
              SizedBox(
                height: 38,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 30,
                      color: const Color(0xff3A0CA3).withOpacity(0.55),
                    ),
                  )),
              Image.asset(
                'assets/images/Journey.png',
                width: w * 0.15,
                height: h * 0.25,
                fit: BoxFit.contain,
              ),
              Text(
                LocaleKeys.Create_Account.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: w * 0.056,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff3A0CA3)),
              ),
              // SizedBox(
              //   height: h * 0.01,
              // ),
              const SignupForm(),
              SizedBox(
                height: h * 0.01,
              ),
              Text(
                LocaleKeys.By_Singning.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xff3A0CA3),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: w * 0.035,
                ),
              ),
              richTextInSignUp(),
              SizedBox(
                height: h * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
