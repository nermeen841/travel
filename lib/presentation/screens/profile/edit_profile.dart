// ignore_for_file: use_key_in_widget_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/business_logic/database_helper/app_states.dart';
import 'package:travel/business_logic/database_helper/database_cubit.dart';
import 'package:travel/constants/constants.dart';
import 'package:travel/presentation/widgets/profile_wdgets/profile_widgets.dart';

import '../../../generated/locale_keys.g.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String? emailController;
  String? usernameController;
  String? phoneController;
  String? dateOfBirthController;
  String? addressController;

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
              primary: false,
              shrinkWrap: true,
              itemCount: DataBaseCubit.get(context).userData.length,
              itemBuilder: (context, i) {
                return ListView(
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
                      height: h * 0.05,
                    ),
                    profileFormField(
                        initialValue: DataBaseCubit.get(context).userData[i]
                            ['firstName'],
                        validator: (val) {
                          return null;
                        },
                        obscureText: false,
                        hintText: 'Username',
                        onChange: (String value) {
                          setState(() {
                            usernameController = value;
                          });
                        }),
                    SizedBox(
                      height: h * 0.023,
                    ),
                    profileFormField(
                        validator: (val) {
                          return null;
                        },
                        obscureText: false,
                        hintText: 'Email',
                        initialValue: DataBaseCubit.get(context).userData[i]
                            ['email'],
                        onChange: (String value) {
                          setState(() {
                            emailController = value;
                          });
                        }),
                    SizedBox(
                      height: h * 0.02,
                    ),
                    profileFormField(
                        validator: (val) {
                          return null;
                        },
                        obscureText: false,
                        hintText: 'Phone',
                        initialValue: (DataBaseCubit.get(context).userData[i]
                                    ['userPhone'] !=
                                "null")
                            ? DataBaseCubit.get(context).userData[i]
                                ['userPhone']
                            : '',
                        onChange: (String value) {
                          setState(() {
                            phoneController = value;
                          });
                        }),
                    SizedBox(
                      height: h * 0.02,
                    ),
                    profileFormField(
                        validator: (val) {
                          return null;
                        },
                        obscureText: false,
                        hintText: 'Date Of Birth',
                        initialValue: (DataBaseCubit.get(context).userData[i]
                                    ['birthDate'] !=
                                "null")
                            ? DataBaseCubit.get(context).userData[i]
                                ['birthDate']
                            : "",
                        onChange: (String value) {
                          emailController = value;
                        }),
                    SizedBox(
                      height: h * 0.02,
                    ),
                    profileFormField(
                        validator: (val) {
                          return null;
                        },
                        obscureText: false,
                        hintText: 'Address',
                        initialValue: (DataBaseCubit.get(context).userData[i]
                                    ['userAddress'] !=
                                "null")
                            ? DataBaseCubit.get(context).userData[i]
                                ['userAddress']
                            : '',
                        onChange: (String value) {
                          setState(() {
                            addressController = value;
                          });
                        }),
                    SizedBox(
                      height: h * 0.05,
                    ),
                    defaultButton(
                      margin: EdgeInsets.symmetric(horizontal: w * 0.13),
                      title: LocaleKeys.SAVE.tr(),
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
                );
              });
        },
      ),
    );
  }
}
