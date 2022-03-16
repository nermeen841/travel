// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:travel/constants/constants.dart';
import 'package:travel/presentation/widgets/profile_wdgets/profile_widgets.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController emailController =
      TextEditingController(text: 'Emul.ezepboy33@gmail.com');
  TextEditingController usernameController =
      TextEditingController(text: 'Emul_Ezep');
  TextEditingController phoneController =
      TextEditingController(text: '01022952483');
  TextEditingController dateOfBirthController =
      TextEditingController(text: '12-12-1995');
  TextEditingController addressController =
      TextEditingController(text: 'Canberra ACT 2601, Australia');

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 0.0,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: w * 0.06,
        ),
        shrinkWrap: true,
        primary: true,
        children: [
          SizedBox(height: h * 0.02),
          Align(
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 35,
                  color: Color(0xff3A0CA3),
                ),
              )),
          // SizedBox(
          //   height: h * 0.01,
          // ),
          Stack(
            children: [
              Center(
                child: Container(
                  height: h * 0.2,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset('assets/images/Ellipse 110.png'),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: w * 0.54,
                  top: h * 0.14,
                ),
                height: h * 0.05,
                width: w * 0.1,
                decoration: BoxDecoration(
                    color: const Color(0xff3A0CA3),
                    border: Border.all(color: Colors.white, width: 1),
                    shape: BoxShape.circle),
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 23,
                ),
              ),
            ],
          ),
          SizedBox(
            height: h * 0.04,
          ),
          const Text(
            'Profile Details',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              fontFamily: 'Poppins',
              color: Color(0xff3A0CA3),
            ),
          ),
          SizedBox(
            height: h * 0.05,
          ),
          profileFormField(
              controller: usernameController,
              validator: (val) {
                return null;
              },
              obscureText: false,
              hintText: 'Username'),
          SizedBox(
            height: h * 0.023,
          ),
          profileFormField(
              controller: emailController,
              validator: (val) {
                return null;
              },
              obscureText: false,
              hintText: 'Email'),
          SizedBox(
            height: h * 0.02,
          ),
          profileFormField(
              controller: phoneController,
              validator: (val) {
                return null;
              },
              obscureText: false,
              hintText: 'Phone'),
          SizedBox(
            height: h * 0.02,
          ),
          profileFormField(
              controller: dateOfBirthController,
              validator: (val) {
                return null;
              },
              obscureText: false,
              hintText: 'Date Of Birth'),
          SizedBox(
            height: h * 0.02,
          ),
          profileFormField(
              controller: addressController,
              validator: (val) {
                return null;
              },
              obscureText: false,
              hintText: 'Address'),
          SizedBox(
            height: h * 0.05,
          ),
          defaultButton(
            margin: EdgeInsets.symmetric(horizontal: w * 0.13),
            title: 'SAVE',
            onPressed: () {
              Navigator.pop(context);
            },
            fontSize: w * 0.05,
            height: h * 0.06,
            width: 260,
            color: const Color(0xff3A0CA3),
            textColor: Colors.white,
          ),
          SizedBox(
            height: h * 0.03,
          ),
        ],
      ),
    );
  }
}
