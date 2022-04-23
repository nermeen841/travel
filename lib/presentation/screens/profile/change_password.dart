import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/business_logic/auth_cubit/authenticationcubit_cubit.dart';
import 'package:travel/constants/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../constants/constants.dart';
import '../../../generated/locale_keys.g.dart';
import '../../widgets/login_form/login_form.dart';

class ChangePassword extends StatefulWidget {
  final String email;
  const ChangePassword({Key? key, required this.email}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final formKey = GlobalKey<FormState>();
  TextEditingController confirmNewPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController currentPasswordController = TextEditingController();
  bool secureText = true;
  bool secureText2 = true;
  bool secureText3 = true;
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0.0,
        iconTheme: IconThemeData(color: MyColors.mainColor),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: w * 0.03, vertical: h * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: h * 0.03,
                ),
                textFormField(
                  hintText: "current password",
                  controller: currentPasswordController,
                  obscureText: secureText,
                  validator: (val) {
                    if (val!.length < 8) {
                      return "passord must be at least 8 charachters";
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
                            Icons.visibility_off_outlined,
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
                            Icons.visibility_outlined,
                            color: const Color(0xff3A0CA3).withOpacity(0.55),
                            size: 25,
                          ),
                        ),
                ),
                SizedBox(
                  height: h * 0.04,
                ),
                textFormField(
                  hintText: "new password",
                  controller: newPasswordController,
                  obscureText: secureText2,
                  validator: (val) {
                    if (val!.length < 8) {
                      return "passord must be at least 8 charachters";
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
                            Icons.visibility_off_outlined,
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
                            Icons.visibility_outlined,
                            color: const Color(0xff3A0CA3).withOpacity(0.55),
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
                  obscureText: secureText3,
                  validator: (val) {
                    if (val!.length < 8) {
                      return "passord must be at least 8 charachters";
                    } else if (newPasswordController.text !=
                        confirmNewPasswordController.text) {
                      return "password not match";
                    }
                    return null;
                  },
                  suffixIcon: (secureText3)
                      ? InkWell(
                          onTap: () {
                            setState(() {
                              secureText3 = false;
                            });
                          },
                          child: Icon(
                            Icons.visibility_off_outlined,
                            color: const Color(0xff3A0CA3).withOpacity(0.55),
                            size: 25,
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            setState(() {
                              secureText3 = true;
                            });
                          },
                          child: Icon(
                            Icons.visibility_outlined,
                            color: const Color(0xff3A0CA3).withOpacity(0.55),
                            size: 25,
                          ),
                        ),
                ),
                SizedBox(
                  height: h * 0.06,
                ),
                BlocConsumer<AuthenticationcubitCubit,
                    AuthenticationcubitState>(
                  builder: (context, state) {
                    return defaultButton(
                      margin: EdgeInsets.symmetric(horizontal: w * 0.13),
                      title: "save",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          AuthenticationcubitCubit.get(context).changePassword(
                              email: widget.email,
                              newPassword: newPasswordController.text,
                              currentPassword: currentPasswordController.text,
                              confirmNewPassword:
                                  confirmNewPasswordController.text,
                              context: context);
                        }
                      },
                      fontSize: w * 0.05,
                      height: h * 0.06,
                      width: 260,
                      color: const Color(0xff3A0CA3),
                      textColor: Colors.white,
                    );
                  },
                  listener: (context, state) {
                    if (state is ChangePasswordSuccessState) {
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
