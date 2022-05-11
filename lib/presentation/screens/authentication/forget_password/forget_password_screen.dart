// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/business_logic/auth_cubit/authenticationcubit_cubit.dart';
import 'package:travel/constants/constants.dart';
import 'package:travel/generated/locale_keys.dart';
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: SingleChildScrollView(
          child: Column(
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
                ),
              ),
              Image.asset(
                'assets/images/Waiting.png',
                width: w * 0.4,
                // height: h * 0.32,
                fit: BoxFit.contain,
              ),
              Text(
                LocaleKeys.Forgot_Password.tr(),
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
                  child: Text(
                    LocaleKeys.Do_not_worry.tr(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
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
                hintText: LocaleKeys.Email.tr(),
                controller: emailController,
                obscureText: false,
              ),
              SizedBox(
                height: h * 0.065,
              ),
              BlocConsumer<AuthenticationcubitCubit, AuthenticationcubitState>(
                listener: (context, state) {
                  if (state is ResetPassordTokenSuccessState) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResetPasswordScreen()),
                    );
                  }
                },
                builder: (context, state) {
                  return defaultButton(
                      title: LocaleKeys.Submit.tr(),
                      onPressed: () {
                        if (emailController.text.isNotEmpty) {
                          AuthenticationcubitCubit.get(context)
                              .resetPasswordToken(
                                  email: emailController.text,
                                  context: context);
                        } else {
                          if (emailController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  LocaleKeys.EMAIL_REQUIRED.tr(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontSize: w * 0.04),
                                ),
                                backgroundColor: Colors.black,
                              ),
                            );
                          } else if (!emailController.text.contains("@") ||
                              !emailController.text.contains(".com")) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  LocaleKeys.INVALID_EMAIL.tr(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontSize: w * 0.04),
                                ),
                                backgroundColor: Colors.black,
                              ),
                            );
                          }
                        }
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
                      ]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
