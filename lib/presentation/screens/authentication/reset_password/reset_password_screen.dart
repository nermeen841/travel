// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/business_logic/auth_cubit/authenticationcubit_cubit.dart';
import 'package:travel/constants/constants.dart';
import 'package:travel/presentation/screens/authentication/login/login_screen.dart';
import 'package:travel/presentation/widgets/login_form/login_form.dart';

import '../../../../generated/locale_keys.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController confirmNewPasswordController = TextEditingController();

  TextEditingController newPasswordController = TextEditingController();

  bool secureText = true;

  bool secureText2 = true;

  final formKey = GlobalKey<FormState>();

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
        child: Form(
          key: formKey,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: BlocConsumer<AuthenticationcubitCubit,
                AuthenticationcubitState>(
              listener: (context, state) {
                if (state is ResetPasswordSuccessState) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false);
                }
              },
              builder: (context, state) {
                return ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  children: [
                    SizedBox(
                      height: h * 0.08,
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
                      LocaleKeys.Reset_Password.tr(),
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
                      hintText: LocaleKeys.New_Password.tr(),
                      controller: newPasswordController,
                      validator: (val) {
                        if (val!.length < 8) {
                          return LocaleKeys.PASS_LENGTH.tr();
                        }
                        return null;
                      },
                      obscureText: secureText,
                      suffixIcon: (secureText)
                          ? InkWell(
                              onTap: () {
                                setState(() {
                                  secureText = false;
                                });
                              },
                              child: Icon(
                                Icons.visibility_outlined,
                                color:
                                    const Color(0xff3A0CA3).withOpacity(0.55),
                                size: 25,
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                setState(() {
                                  secureText = true;
                                });
                              },
                              child: Icon(
                                Icons.visibility_off_outlined,
                                color:
                                    const Color(0xff3A0CA3).withOpacity(0.55),
                                size: 25,
                              ),
                            ),
                    ),
                    SizedBox(
                      height: h * 0.04,
                    ),
                    textFormField(
                      hintText: LocaleKeys.Confirm_Password.tr(),
                      controller: confirmNewPasswordController,
                      validator: (val) {
                        if (val!.length < 8) {
                          return LocaleKeys.PASS_LENGTH.tr();
                        } else if (newPasswordController.text !=
                            confirmNewPasswordController.text) {
                          return LocaleKeys.PASS_NOT_MATCH.tr();
                        }
                        return null;
                      },
                      obscureText: secureText2,
                      suffixIcon: (secureText2)
                          ? InkWell(
                              onTap: () {
                                setState(() {
                                  secureText2 = false;
                                });
                              },
                              child: Icon(
                                Icons.visibility_outlined,
                                color:
                                    const Color(0xff3A0CA3).withOpacity(0.55),
                                size: 25,
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                setState(() {
                                  secureText2 = true;
                                });
                              },
                              child: Icon(
                                Icons.visibility_off_outlined,
                                color:
                                    const Color(0xff3A0CA3).withOpacity(0.55),
                                size: 25,
                              ),
                            ),
                    ),
                    SizedBox(
                      height: h * 0.06,
                    ),
                    defaultButton(
                        title: LocaleKeys.Submitting.tr(),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            AuthenticationcubitCubit.get(context).resetPassword(
                                newPassword: newPasswordController.text,
                                confirmNewPassword:
                                    confirmNewPasswordController.text,
                                context: context);
                          }
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
