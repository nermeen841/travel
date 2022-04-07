import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel/business_logic/appCubit/app_Cubit.dart';
import 'package:travel/business_logic/appCubit/app_states.dart';
import 'package:travel/business_logic/auth_cubit/authenticationcubit_cubit.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/constants.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../../widgets/login_form/login_form.dart';
import '../../../../widgets/sign_up_form/sign_up_form.dart';
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
    return BlocConsumer<AuthenticationcubitCubit,AuthenticationcubitState>(
      listener: (context,state){},
      builder: (context,state){
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
                  ),
                  SizedBox(
                    height: h * 0.025,
                  ),
                  textFormField(
                    hintText: LocaleKeys.Last_Name.tr(),
                    controller: lastNameController,
                       obscureText: false,
                  ),
                  SizedBox(
                    height: h * 0.025,
                  ),
                  textFormField(
                    controller: phoneController,
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
                  ),
                  SizedBox(
                    height: h * 0.025,
                  ),
                  textFormField(
                    hintText: LocaleKeys.Password.tr(),
                    controller: passwordController,
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
                    InkWell(
                      onTap: () async{
                        showCitysMenu(context: context, w: w, list: AuthenticationcubitCubit.get(context).city);
                      },
                      child: BlocConsumer<AppCubit,AppState>(
                          listener: (context,state){},
                          builder: (context,state) {
                            return Row(
                              children: [
                                (AppCubit.get(context).city== null)?Text(
                                  LocaleKeys.City.tr(),
                                  style: headingStyle.copyWith(fontSize: 16),
                                ):Text(
                                  AppCubit.get(context).city!,
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
                          }
                      ),
                    ),




                    InkWell(
                      onTap: () {
                        showGoverMenu(context:context,w: w,list: AuthenticationcubitCubit.get(context).governorate);
                      },

                      child: BlocConsumer<AppCubit,AppState>(
                        listener: (context,state){},
                        builder: (context,state){

                          return Row(
                            children: [
                              (AppCubit.get(context).governorate != null)? Text(
                                AppCubit.get(context).governorate!,
                                style: headingStyle.copyWith(fontSize: 16),
                              ) : Text(
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
                          );
                        },
                      ),
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
                  //
                  // if (formKey.currentState!.validate()) {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => const BottomNave(
                  //         index: 0,
                  //       ),
                  //     ),
                  //   );
                  // }
                  AuthenticationcubitCubit.get(context).register(
                      email: emailController.text,
                      firstName: firstNameController.text,
                      password: passwordController.text,
                      phone: phoneController.text,
                      lastName: lastNameController.text,
                      confirmPassword: confirmPasswordController.text,
                  );
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
      },
      // child: ,
    );
  }
}
