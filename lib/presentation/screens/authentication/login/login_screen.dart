// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/business_logic/auth_cubit/authenticationcubit_cubit.dart';
import 'package:travel/constants/constants.dart';
import 'package:travel/generated/locale_keys.dart';
import 'package:travel/presentation/screens/authentication/forget_password/forget_password_screen.dart';
import 'package:travel/presentation/widgets/login_form/login_form.dart';

import '../../layout/bottomNave.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  final formKey = GlobalKey<FormState>();
  bool secureText = true;

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
              horizontal: w * 0.07,
            ),
            shrinkWrap: true,
            primary: true,
            children: [
              const SizedBox(
                height: 40,
              ),
              Align(
                  alignment: (prefs.getString('lang') == 'en')
                      ? Alignment.topLeft
                      : Alignment.topRight,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 30,
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
              Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: h * 0.013,
                    ),
                    textFormField(
                      focusNode: emailFocusNode,
                      onEditingComplete: () {
                        emailFocusNode.unfocus();
                        FocusScope.of(context).requestFocus(passwordFocusNode);
                      },
                      hintText: LocaleKeys.Email.tr(),
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return LocaleKeys.EMAIL_REQUIRED.tr();
                        } else if (!val.contains("@") ||
                            !val.contains(".com")) {
                          return LocaleKeys.INVALID_EMAIL.tr();
                        }
                        return null;
                      },
                      obscureText: false,
                    ),
                    SizedBox(
                      height: h * 0.03,
                    ),
                    textFormField(
                      focusNode: passwordFocusNode,
                      onEditingComplete: () {
                        passwordFocusNode.unfocus();
                      },
                      keyboardType: TextInputType.text,
                      hintText: LocaleKeys.Password.tr(),
                      controller: passwordController,
                      validator: (val) {
                        if (val!.length < 8) {
                          return "passord must be at least 8 charachters";
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
                  ],
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
              BlocConsumer<AuthenticationcubitCubit, AuthenticationcubitState>(
                  builder: ((context, state) => defaultButton(
                          title: LocaleKeys.Login.tr(),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              AuthenticationcubitCubit.get(context).login(
                                  context: context,
                                  w: w,
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          fontSize: 16,
                          height: h * 0.07,
                          width: 260,
                          color: Colors.white,
                          textColor: const Color(0xff3A0CA3),
                          margin: EdgeInsets.symmetric(horizontal: w * 0.05),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 5,
                              offset: const Offset(0, 3), // Shadow position
                            ),
                          ])),
                  listener: (context, state) {
                    if (state is LoginSuccessState) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BottomNave(
                                    index: 0,
                                  )),
                          (route) => false);
                    }
                  }),
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
              googleAndFacebookRow(
                  context: context,
                  pressOnGoogle: () {
                    AuthenticationcubitCubit.get(context).googleSignUp(context);
                  }),
              SizedBox(
                height: h * 0.09,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
