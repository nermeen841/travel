import 'package:flutter/material.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/constants.dart';
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
                hintText: 'First Name',
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
                hintText: 'Last Name',
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
                  hintText: "Phone number"),
              SizedBox(
                height: h * 0.025,
              ),
              textFormField(
                hintText: 'Email',
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
                hintText: 'Password',
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
                hintText: 'Confirm Password',
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
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "City",
                  style: headingStyle.copyWith(fontSize: w * 0.05),
                ),
                SizedBox(
                  width: w * 0.01,
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: MyColors.mainColor,
                  size: w * 0.08,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Governete",
                  style: headingStyle.copyWith(fontSize: w * 0.05),
                ),
                SizedBox(
                  width: w * 0.01,
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: MyColors.mainColor,
                  size: w * 0.08,
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: h * 0.04,
        ),
        defaultButton(
            title: 'SIGN UP',
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
