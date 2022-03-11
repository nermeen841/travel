// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:travel/constants/constants.dart';
import 'package:travel/presentation/screens/profile/edit_profile.dart';
import 'package:travel/presentation/widgets/profile_wdgets/profile_widgets.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
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
          SizedBox(
            height: h * 0.01,
          ),
          Container(
            height: h * 0.2,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: Image.asset('assets/images/Ellipse 110.png'),
          ),
          SizedBox(
            height: h * 0.06,
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
            height: h * 0.06,
          ),
          buildProfileRow(
              context: context, title1: 'Username', title2: 'Emul_Ezep'),
          buildProfileRow(
              context: context,
              title1: 'Email',
              title2: 'Emul.ezepboy33@gmail.com'),
          buildProfileRow(
              context: context, title1: 'Phone', title2: '0102295283'),
          buildProfileRow(
              context: context, title1: 'Date Of Birth', title2: '12-12-1995'),
          buildProfileRow(
              context: context,
              title1: 'Address',
              title2: 'Canberra ACT 2601, Australia'),
          SizedBox(
            height: h * 0.02,
          ),
          defaultButton(
            margin: EdgeInsets.symmetric(horizontal: w * 0.13),
            title: 'EDIT',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditProfileScreen()));
            },
            fontSize: w * 0.05,
            height: h * 0.06,
            width: 260,
            color: const Color(0xff3A0CA3),
            textColor: Colors.white,
          ),
          SizedBox(
            height: h * 0.02,
          ),
        ],
      ),
    );
  }
}
