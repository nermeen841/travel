// ignore_for_file: use_key_in_widget_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/constants/constants.dart';
import 'package:travel/generated/locale_keys.g.dart';
import 'package:travel/presentation/screens/profile/change_password.dart';
import 'package:travel/presentation/screens/profile/edit_profile.dart';
import 'package:travel/presentation/widgets/profile_wdgets/profile_widgets.dart';

import '../../../business_logic/database_helper/app_states.dart';
import '../../../business_logic/database_helper/database_cubit.dart';

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
      body: BlocConsumer<DataBaseCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          return ListView.builder(
            shrinkWrap: true,
            primary: true,
            itemCount: DataBaseCubit.get(context).userData.length,
            padding: EdgeInsets.symmetric(
              horizontal: w * 0.06,
            ),
            itemBuilder: (context, index) => Column(
              // padding:
              // shrinkWrap: true,
              // primary: true,
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
                Text(
                  LocaleKeys.Profile_Details.tr(),
                  style: const TextStyle(
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
                    context: context,
                    title1: LocaleKeys.Username.tr(),
                    title2: DataBaseCubit.get(context).userData[index]
                        ['firstName']),
                buildProfileRow(
                    context: context,
                    title1: LocaleKeys.Email.tr(),
                    title2: DataBaseCubit.get(context).userData[index]
                        ['email']),
                (DataBaseCubit.get(context).userData[index]['userPhone'] !=
                        "null")
                    ? buildProfileRow(
                        context: context,
                        title1: LocaleKeys.Phone_Number.tr(),
                        title2: DataBaseCubit.get(context).userData[index]
                            ['userPhone'])
                    : Container(),
                (DataBaseCubit.get(context).userData[index]['birthDate'] !=
                        "null")
                    ? buildProfileRow(
                        context: context,
                        title1: LocaleKeys.DateOfBirth.tr(),
                        title2: DataBaseCubit.get(context).userData[index]
                            ['birthDate'])
                    : Container(),
                (DataBaseCubit.get(context).userData[index]['userAddress'] !=
                        "null")
                    ? buildProfileRow(
                        context: context,
                        title1: LocaleKeys.Address.tr(),
                        title2: DataBaseCubit.get(context).userData[index]
                            ['userAddress'])
                    : Container(),
                SizedBox(
                  height: h * 0.06,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ChangePassword()));
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
                  height: h * 0.06,
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
                            builder: (context) => EditProfileScreen()));
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
        },
      ),
    );
  }
}
