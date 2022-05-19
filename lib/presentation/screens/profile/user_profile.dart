// ignore_for_file: use_key_in_widget_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel/constants/constants.dart';
import 'package:travel/generated/locale_keys.dart';
import 'package:travel/presentation/screens/profile/change_password.dart';
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
    return PreferredSize(
      preferredSize: Size(w, h),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xff3A0CA3).withOpacity(0.99),
                Colors.white70,
                Colors.white,
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: w * 0.05, vertical: h * 0.02),
              child: Column(
                children: [
                  SizedBox(height: h * 0.08),
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
                  Container(
                    height: h * 0.2,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: (prefs.getString('user_image') != null)
                        ? CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 180,
                            backgroundImage: NetworkImage(
                                prefs.getString('user_image').toString()),
                          )
                        : Center(
                            child: Icon(
                              FontAwesomeIcons.fileImage,
                              size: w * 0.2,
                              color: Colors.black,
                            ),
                          ),
                  ),
                  SizedBox(
                    height: h * 0.06,
                  ),
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      LocaleKeys.Profile_Details.tr(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins',
                        color: Color(0xff3A0CA3),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.04,
                  ),
                  buildProfileRow(
                      context: context,
                      title1: LocaleKeys.Username.tr(),
                      title2: prefs.getString('firstName').toString() +
                          " " +
                          prefs.getString('lastName')!),
                  buildProfileRow(
                      context: context,
                      title1: LocaleKeys.Email.tr(),
                      title2: prefs.getString('email').toString()),
                  (prefs.getString('phoneNumber') != "null")
                      ? buildProfileRow(
                          context: context,
                          title1: LocaleKeys.Phone_Number.tr(),
                          title2: prefs.getString('phoneNumber')!)
                      : Container(),
                  (prefs.getString('dateofbirth') != "")
                      ? buildProfileRow(
                          context: context,
                          title1: LocaleKeys.DateOfBirth.tr(),
                          title2: prefs.getString('dateofbirth').toString())
                      : Container(),

                  (prefs.getString('userAddress') != "")
                      ? buildProfileRow(
                          context: context,
                          title1: LocaleKeys.Address.tr(),
                          title2: prefs.getString('userAddress')!)
                      : Container(),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangePassword(
                                    email: prefs.getString('email').toString(),
                                  )));
                    },
                    child: const Text(
                      "Change Passord",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins',
                        color: Color(0xff3A0CA3),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  defaultButton(
                    margin: EdgeInsets.symmetric(horizontal: w * 0.13),
                    title: LocaleKeys.EDIT.tr(),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditProfileScreen()));
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
            ),
          ),
        ),
      ),
    );
  }
}
