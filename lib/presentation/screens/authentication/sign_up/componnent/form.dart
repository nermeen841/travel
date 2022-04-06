import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/business_logic/auth_cubit/authenticationcubit_cubit.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/constants.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../../widgets/login_form/login_form.dart';
import '../../../layout/bottomNave.dart';

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
                validator: (val) {
                  if (val!.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        "first name is required",
                        style: headingStyle.copyWith(color: Colors.white),
                      ),
                      backgroundColor: Colors.black,
                    ));
                  }
                  return null;
                },
                obscureText: false,
              ),
              SizedBox(
                height: h * 0.025,
              ),
              textFormField(
                hintText: LocaleKeys.Last_Name.tr(),
                controller: lastNameController,
                validator: (val) {
                  if (val!.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        "last name is required",
                        style: headingStyle.copyWith(color: Colors.white),
                      ),
                      backgroundColor: Colors.black,
                    ));
                  }
                  return null;
                },
                obscureText: false,
              ),
              SizedBox(
                height: h * 0.025,
              ),
              textFormField(
                controller: phoneController,
                validator: (val) {
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
                validator: (val) {
                  if (val!.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        "email is required",
                        style: headingStyle.copyWith(color: Colors.white),
                      ),
                      backgroundColor: Colors.black,
                    ));
                  }
                  return null;
                },
                obscureText: false,
              ),
              SizedBox(
                height: h * 0.025,
              ),
              textFormField(
                hintText: LocaleKeys.Password.tr(),
                controller: passwordController,
                validator: (val) {
                  if (val!.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        "password is required",
                        style: headingStyle.copyWith(color: Colors.white),
                      ),
                      backgroundColor: Colors.black,
                    ));
                  }
                  return null;
                },
                obscureText: true,
                suffixIcon: Icon(
                  Icons.visibility,
                  color: const Color(0xff3A0CA3).withOpacity(0.55),
                  size: 25,
                ),
              ),
              SizedBox(
                height: h * 0.025,
              ),
              textFormField(
                hintText: LocaleKeys.Confirm_Password.tr(),
                controller: confirmPasswordController,
                validator: (val) {
                  if (val!.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        "you  must confirm your password",
                        style: headingStyle.copyWith(color: Colors.white),
                      ),
                      backgroundColor: Colors.black,
                    ));
                  } else if (passwordController.text !=
                      confirmPasswordController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        "password not match",
                        style: headingStyle.copyWith(color: Colors.white),
                      ),
                      backgroundColor: Colors.black,
                    ));
                  }
                  return null;
                },
                obscureText: true,
                suffixIcon: Icon(
                  Icons.visibility,
                  color: const Color(0xff3A0CA3).withOpacity(0.55),
                  size: 25,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: h * 0.035,
        ),
        BlocConsumer<AuthenticationcubitCubit, AuthenticationcubitState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
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
                ),
                Row(
                  children: [
                    Text(
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
                )
              ],
            );
          },
        ),
        SizedBox(
          height: h * 0.04,
        ),
        defaultButton(
            title: LocaleKeys.SignUp.tr(),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BottomNave(
                      index: 0,
                    ),
                  ),
                );
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
            ]),
      ],
    );
  }
}
