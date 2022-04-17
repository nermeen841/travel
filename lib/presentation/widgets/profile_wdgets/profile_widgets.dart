import 'package:flutter/material.dart';
import 'package:travel/constants/colors.dart';

Widget buildProfileRow({
  required String title1,
  required String title2,
  required context,
}) {
  double h = MediaQuery.of(context).size.height;
  double w = MediaQuery.of(context).size.width;
  return Column(
    children: [
      Row(
        children: [
          Text(
            title1,
            style: TextStyle(
                fontSize: w * 0.043,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                color: const Color(0xff3A0CA3)),
          ),
          const Spacer(),
          Text(
            title2,
            style: TextStyle(
                fontSize: w * 0.036,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                color: Colors.black),
          )
        ],
      ),
      SizedBox(
        height: h * 0.015,
      ),
      Divider(
        height: 2,
        color: const Color(
          0xffDFE6E9,
        ).withOpacity(0.8),
        thickness: 2,
      ),
      SizedBox(height: h * 0.03),
    ],
  );
}

Widget profileFormField({
  required String initialValue,
  required FormFieldValidator<String>? validator,
  required ValueChanged<String>? onChange,
  required bool obscureText,
  required String hintText,
  Widget? suffixIcon,
}) =>
    TextFormField(
      initialValue: initialValue,
      validator: validator,
      onChanged: onChange,
      keyboardType: TextInputType.text,
      cursorColor: Colors.grey,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: MyColors.unslectedIconColor)),
        disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: MyColors.unslectedIconColor)),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: MyColors.unslectedIconColor)),
        errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: MyColors.unslectedIconColor)),
        hintText: hintText,
        hintStyle: const TextStyle(
            fontSize: 16,
            fontFamily: 'Poppins',
            color: Colors.black,
            fontWeight: FontWeight.w400),
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: MyColors.unslectedIconColor)),
      ),
    );
