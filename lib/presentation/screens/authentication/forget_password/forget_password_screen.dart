// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:travel/constants/constants.dart';
import 'package:travel/presentation/screens/authentication/reset_password/reset_password_screen.dart';
import 'package:travel/presentation/widgets/login_form/login_form.dart';

class ForgetPasswordScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 0.0,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 35),
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
            'assets/images/Waiting.png',
            width: w * 0.3,
            height: h * 0.32,
            fit: BoxFit.contain,
          ),
          Text(
            'Forgot Your Password?',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: w * 0.06,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: const Color(0xff3A0CA3)),
          ),
          SizedBox(
            height: h * 0.04,
          ),
          Center(
            child: SizedBox(
              height: h * 0.06,
              // width: 500,
              child: const Text(
                'Don’t worry! It happens. Please enter the address associated with your account',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    color: Color(0xff3A0CA3)),
              ),
            ),
          ),
          SizedBox(
            height: h * 0.05,
          ),
          textFormField(
            hintText: 'Email',
            controller: emailController,
            validator: (val) {
              return null;
            },
            obscureText: false,
          ),
          SizedBox(
            height: h * 0.065,
          ),
          defaultButton(
              title: 'SUBMIT',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResetPasswordScreen()));
              },
              fontSize: 16,
              height: h * 0.07,
              width: 260,
              color: Colors.white,
              textColor: const Color(0xff3A0CA3),
              margin: const EdgeInsets.symmetric(horizontal: 25),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade500,
                  blurRadius: 5,
                  offset: const Offset(0, 5), // Shadow position
                ),
              ]),
        ],
      ),
    );
  }
}
