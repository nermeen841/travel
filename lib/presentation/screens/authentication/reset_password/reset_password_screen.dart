// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:travel/constants/constants.dart';
import 'package:travel/presentation/widgets/login_form/login_form.dart';

class ResetPasswordScreen extends StatelessWidget {
  TextEditingController confirmNewPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

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
            'assets/images/Tourists.png',
            width: w * 0.33,
            height: h * 0.32,
            fit: BoxFit.contain,
          ),
          Text(
            'Reset  Password',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: w * 0.06,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: const Color(0xff3A0CA3)),
          ),
          SizedBox(
            height: h * 0.03,
          ),
          textFormField(
            hintText: 'New Password',
            controller: newPasswordController,
            validator: (val) {
              return null;
            },
            obscureText: false,
            suffixIcon: Icon(
              Icons.visibility,
              color: const Color(0xff3A0CA3).withOpacity(0.55),
              size: 25,
            ),
          ),
          SizedBox(
            height: h * 0.04,
          ),
          textFormField(
            hintText: 'Confirm New Password',
            controller: confirmNewPasswordController,
            validator: (val) {
              return null;
            },
            obscureText: false,
            suffixIcon: Icon(
              Icons.visibility,
              color: const Color(0xff3A0CA3).withOpacity(0.55),
              size: 25,
            ),
          ),
          SizedBox(
            height: h * 0.06,
          ),
          defaultButton(
              title: 'SUBMITTING...',
              onPressed: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPasswordScreen()));
              },
              fontSize: 16,
              height: h * 0.07,
              width: 260,
              color: const Color(0xff3A0CA3),
              textColor: Colors.white,
              margin: EdgeInsets.symmetric(horizontal: w * 0.05),
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
