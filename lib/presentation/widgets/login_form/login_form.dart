import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget textFormField(
        {required TextEditingController? controller,
        FormFieldValidator<String>? validator,
        required bool obscureText,
        required String hintText,
        Widget? suffixIcon,
        required TextInputType? keyboardType}) =>
    TextFormField(
      // focusNode: FocusScopeNode(skipTraversal: true),
      controller: controller,

      validator: validator,
      keyboardType: keyboardType,
      cursorColor: Colors.grey,
      obscureText: obscureText,

      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xff3A0CA3))),
        disabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xff3A0CA3))),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xff3A0CA3))),
        errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xff3A0CA3))),
        hintText: hintText,
        hintStyle: const TextStyle(
            fontSize: 14, fontFamily: 'Poppins', color: Color(0xff3A0CA3)),
        border: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xff3A0CA3))),
      ),
    );

Widget googleAndFacebookRow({
  GestureTapCallback? pressOnGoogle,
  GestureTapCallback? pressOnFacebook,
  required context,
}) {
  double h = MediaQuery.of(context).size.height;
  double w = MediaQuery.of(context).size.width;

  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      InkWell(
        onTap: pressOnGoogle,
        child: Container(
          padding: EdgeInsets.only(left: w * 0.03, right: w * 0.04),
          height: h * 0.06,
          width: w * 0.34,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 3,
                offset: const Offset(0, 2), // Shadow position
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset('assets/images/google icon 1.png'),
              const Text(
                'Google',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins',
                  color: Color(0xff3498DB),
                ),
              ),
            ],
          ),
        ),
      ),
      InkWell(
        onTap: pressOnFacebook,
        child: Container(
          padding: EdgeInsets.only(left: w * 0.01, right: w * 0.01),
          height: h * 0.06,
          width: w * 0.34,
          decoration: BoxDecoration(
            color: const Color(0xff3498DB),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 3,
                offset: const Offset(0, 2), // Shadow position
              ),
            ],
          ),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Icon(
                FontAwesomeIcons.facebookF,
                color: Colors.white,
              ),
              Text(
                ' Facebook',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
