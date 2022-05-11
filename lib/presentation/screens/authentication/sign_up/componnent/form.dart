import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/business_logic/auth_cubit/authenticationcubit_cubit.dart';
import 'package:travel/business_logic/database_helper/app_Cubit.dart';
import 'package:travel/business_logic/database_helper/app_states.dart';
import 'package:travel/presentation/screens/authentication/login/login_screen.dart';
import 'package:travel/presentation/widgets/sign_up_form/sign_up_form.dart';
import '../../../../../constants/colors.dart';
import '../../../../../constants/constants.dart';
import '../../../../../generated/locale_keys.dart';
import '../../../../widgets/login_form/login_form.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool secureText = true;
  bool secureText2 = true;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              textFormField(
                hintText: LocaleKeys.First_Name.tr(),
                controller: firstNameController,
                obscureText: false,
                validator: (val) {
                  if (val!.isEmpty) {
                    return LocaleKeys.FIRSTNAME_REQUIRED.tr();
                  } else if (val.length < 3) {
                    return LocaleKeys.FIRSTNAME_LENGTH.tr();
                  }
                  return null;
                },
              ),
              SizedBox(
                height: h * 0.025,
              ),
              textFormField(
                hintText: LocaleKeys.Last_Name.tr(),
                controller: lastNameController,
                obscureText: false,
                validator: (val) {
                  if (val!.isEmpty) {
                    return LocaleKeys.LASTNAME_REQUIRED.tr();
                  } else if (val.length < 3) {
                    return LocaleKeys.LAST_NAME_LENGTH.tr();
                  }
                  return null;
                },
              ),
              SizedBox(
                height: h * 0.025,
              ),
              textFormField(
                controller: phoneController,
                validator: (val) {
                  if (val!.isNotEmpty) {
                    if (val.length != 11) {
                      return LocaleKeys.PHONE_INVALID.tr();
                    }
                  } else {
                    return null;
                  }
                  return null;
                },
                obscureText: false,
                hintText: LocaleKeys.Phone_Number.tr(),
              ),
              SizedBox(
                height: h * 0.025,
              ),
              textFormField(
                hintText: LocaleKeys.Email.tr(),
                controller: emailController,
                obscureText: false,
                validator: (val) {
                  if (val!.isEmpty) {
                    return LocaleKeys.EMAIL_REQUIRED.tr();
                  } else if (!val.contains("@") || !val.contains(".com")) {
                    return LocaleKeys.INVALID_EMAIL.tr();
                  }
                  return null;
                },
              ),
              SizedBox(
                height: h * 0.025,
              ),
              textFormField(
                hintText: LocaleKeys.Password.tr(),
                controller: passwordController,
                obscureText: secureText,
                validator: (val) {
                  if (val!.length < 8) {
                    return LocaleKeys.PASS_LENGTH.tr();
                  }
                  return null;
                },
                suffixIcon: (secureText)
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            secureText = false;
                          });
                        },
                        child: Icon(
                          Icons.visibility_outlined,
                          color: const Color(0xff3A0CA3).withOpacity(0.55),
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
                          color: const Color(0xff3A0CA3).withOpacity(0.55),
                          size: 25,
                        ),
                      ),
              ),
              SizedBox(
                height: h * 0.025,
              ),
              textFormField(
                hintText: LocaleKeys.Confirm_Password.tr(),
                controller: confirmPasswordController,
                obscureText: secureText2,
                validator: (val) {
                  if (val!.length < 8) {
                    return LocaleKeys.PASS_LENGTH.tr();
                  } else if (passwordController.text !=
                      confirmPasswordController.text) {
                    return LocaleKeys.PASS_NOT_MATCH.tr();
                  }
                  return null;
                },
                suffixIcon: (secureText2)
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            secureText2 = false;
                          });
                        },
                        child: Icon(
                          Icons.visibility_outlined,
                          color: const Color(0xff3A0CA3).withOpacity(0.55),
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
                          color: const Color(0xff3A0CA3).withOpacity(0.55),
                          size: 25,
                        ),
                      ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: h * 0.035,
        ),
        BlocConsumer<AuthenticationcubitCubit, AuthenticationcubitState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    showCitysMenu(
                        positioned:
                            const RelativeRect.fromLTRB(0, 380, 300, 100),
                        context: context,
                        w: w,
                        list: AuthenticationcubitCubit.get(context).city);
                  },
                  child: BlocConsumer<AppCubit, AppState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return Row(
                        children: [
                          (AppCubit.get(context).city != null)
                              ? Text(
                                  AppCubit.get(context).city!,
                                  style: headingStyle.copyWith(fontSize: 16),
                                )
                              : Text(
                                  LocaleKeys.City.tr(),
                                  style: headingStyle.copyWith(fontSize: 16),
                                ),
                          SizedBox(
                            width: w * 0.01,
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: MyColors.mainColor,
                            size: w * 0.065,
                          ),
                        ],
                      );
                    },
                  ),
                ),
                InkWell(
                  onTap: () {
                    showGoverMenu(
                        context: context,
                        w: w,
                        list:
                            AuthenticationcubitCubit.get(context).governorate);
                  },
                  child: Row(
                    children: [
                      (AppCubit.get(context).governorate != null)
                          ? Text(
                              AppCubit.get(context).governorate!,
                              style: headingStyle.copyWith(fontSize: 16),
                            )
                          : Text(
                              LocaleKeys.Governorate.tr(),
                              style: headingStyle.copyWith(fontSize: 16),
                            ),
                      SizedBox(
                        width: w * 0.01,
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: MyColors.mainColor,
                        size: w * 0.065,
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
        SizedBox(
          height: h * 0.04,
        ),
        BlocConsumer<AuthenticationcubitCubit, AuthenticationcubitState>(
            builder: (context, state) {
          return defaultButton(
              title: LocaleKeys.SignUp.tr(),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  AuthenticationcubitCubit.get(context).register(
                      context: context,
                      w: w,
                      email: emailController.text,
                      firstName: firstNameController.text,
                      password: passwordController.text,
                      phone: phoneController.text,
                      lastName: lastNameController.text,
                      confirmPassword: confirmPasswordController.text);
                }
              },
              fontSize: 16,
              height: h * 0.07,
              width: 260,
              color: Colors.white,
              textColor: const Color(0xff3A0CA3),
              margin: EdgeInsets.symmetric(horizontal: w * 0.06),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade500,
                  blurRadius: 5,
                  offset: const Offset(0, 5), // Shadow position
                ),
              ]);
        }, listener: (context, state) {
          if (state is RegisterSuccessState) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: ((context) => LoginScreen())));
          }
        }),
      ],
    );
  }
}
