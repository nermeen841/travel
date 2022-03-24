// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:travel/constants/constants.dart';
import 'package:travel/generated/locale_keys.g.dart';
import 'package:travel/presentation/screens/authentication/forget_password/forget_password_screen.dart';
import 'package:travel/presentation/screens/layout/bottomNave.dart';
import 'package:travel/presentation/widgets/login_form/login_form.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 0.0,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: w * 0.06,
        ),
        shrinkWrap: true,
        primary: true,
        children: [
          SizedBox(
            height: h * 0.03,
          ),
          Align(
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 35,
                  color: const Color(0xff3A0CA3).withOpacity(0.55),
                ),
              )),
          Image.asset(
            'assets/images/Explore.png',
            width: w * 0.2,
            height: h * 0.3,
            fit: BoxFit.contain,
          ),
          Text(
            LocaleKeys.Welcome.tr(),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: w * 0.056,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: const Color(0xff3A0CA3)),
          ),
          SizedBox(
            height: h * 0.013,
          ),
          textFormField(
            hintText: LocaleKeys.Email.tr(),
            controller: emailController,
            validator: (val) {
              return null;
            },
            obscureText: false,
          ),
          SizedBox(
            height: h * 0.03,
          ),
          textFormField(
            hintText: LocaleKeys.Password.tr(),
            controller: passwordController,
            validator: (val) {
              return null;
            },
            obscureText: true,
            suffixIcon: Icon(
              Icons.visibility,
              color: const Color(0xff3A0CA3).withOpacity(0.55),
              size: 25,
            ),
          ),
          SizedBox(height: h * 0.03),
          InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ForgetPasswordScreen())),
            child: Text(
              LocaleKeys.Forget_Password.tr(),
              textAlign: TextAlign.end,
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: w * 0.03,
                  color: const Color(0xff3A0CA3)),
            ),
          ),
          SizedBox(
            height: h * 0.03,
          ),
          defaultButton(
              title: LocaleKeys.Login.tr(),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BottomNave(
                              index: 0,
                            )));
              },
              fontSize: 16,
              height: h * 0.07,
              width: 260,
              color: Colors.white,
              textColor: const Color(0xff3A0CA3),
              margin: EdgeInsets.symmetric(horizontal: w * 0.05),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade500,
                  blurRadius: 5,
                  offset: const Offset(0, 5), // Shadow position
                ),
              ]),
          SizedBox(
            height: h * 0.04,
          ),
          Text(
            LocaleKeys.or_connect.tr(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xff3A0CA3),
              fontSize: w * 0.035,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
            ),
          ),
          SizedBox(
            height: h * 0.02,
          ),
          googleAndFacebookRow(context: context),
          // SizedBox(height:  h * 0.03,),
        ],
      ),
    );
  }
}
