// ignore_for_file: use_key_in_widget_constructors, deprecated_member_use, avoid_print

import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel/business_logic/auth_cubit/authenticationcubit_cubit.dart';
import 'package:travel/business_logic/database_helper/app_states.dart';
import 'package:travel/business_logic/database_helper/database_cubit.dart';
import 'package:travel/constants/constants.dart';
import 'package:travel/presentation/widgets/profile_wdgets/profile_widgets.dart';

import '../../../generated/locale_keys.g.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String? emailController;
  String? usernameController;
  String? lastnameController;
  String? phoneController;
  String? dateOfBirthController;
  String? addressController;

  File? image;
  String image1 = "";

  Future getImage() async {
    ImagePicker picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image1 = pickedFile.path;
        image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

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
      body: SingleChildScrollView(
        primary: true,
        child: BlocConsumer<DataBaseCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            return ListView.builder(
                primary: false,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: DataBaseCubit.get(context).userData.length,
                itemBuilder: (context, i) {
                  return ListView(
                    padding: EdgeInsets.symmetric(
                      horizontal: w * 0.06,
                    ),
                    shrinkWrap: true,
                    primary: false,
                    physics: const NeverScrollableScrollPhysics(),
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
                              child: (image == null)
                                  ? Image.asset('assets/images/Ellipse 110.png')
                                  : Image.file(image!),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              await getImage();
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                left: w * 0.54,
                                top: h * 0.14,
                              ),
                              height: h * 0.05,
                              width: w * 0.1,
                              decoration: BoxDecoration(
                                  color: const Color(0xff3A0CA3),
                                  border:
                                      Border.all(color: Colors.white, width: 1),
                                  shape: BoxShape.circle),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 23,
                              ),
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
                          initialValue: DataBaseCubit.get(context).userData[i]
                              ['lastName'],
                          validator: (val) {
                            return null;
                          },
                          obscureText: false,
                          hintText: 'last name',
                          onChange: (String value) {
                            setState(() {
                              lastnameController = value;
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
                      BlocConsumer<AuthenticationcubitCubit,
                              AuthenticationcubitState>(
                          builder: (context, state) {
                            return defaultButton(
                              margin:
                                  EdgeInsets.symmetric(horizontal: w * 0.13),
                              title: LocaleKeys.SAVE.tr(),
                              onPressed: () {
                                AuthenticationcubitCubit.get(context)
                                    .updateProfile(
                                        email:
                                            emailController ??
                                                DataBaseCubit
                                                        .get(context)
                                                    .userData[i]['email'],
                                        firstName:
                                            usernameController ??
                                                DataBaseCubit
                                                        .get(context)
                                                    .userData[i]['firstName'],
                                        phone:
                                            phoneController ??
                                                DataBaseCubit
                                                        .get(context)
                                                    .userData[i]['userPhone'],
                                        image: image1,
                                        lastName: lastnameController ??
                                            DataBaseCubit.get(context)
                                                .userData[i]['lastName'],
                                        context: context,
                                        w: w);
                              },
                              fontSize: w * 0.05,
                              height: h * 0.06,
                              width: 260,
                              color: const Color(0xff3A0CA3),
                              textColor: Colors.white,
                            );
                          },
                          listener: (context, state) {}),
                      SizedBox(
                        height: h * 0.03,
                      ),
                    ],
                  );
                });
          },
        ),
      ),
    );
  }
}
