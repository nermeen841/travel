// ignore_for_file: use_key_in_widget_constructors, deprecated_member_use, avoid_print

import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel/business_logic/auth_cubit/authenticationcubit_cubit.dart';
import 'package:travel/business_logic/database_helper/app_states.dart';
import 'package:travel/constants/colors.dart';
import 'package:travel/constants/constants.dart';
import 'package:travel/presentation/screens/layout/bottomNave.dart';
import 'package:travel/presentation/screens/profile/change_password.dart';
import 'package:travel/presentation/widgets/profile_wdgets/profile_widgets.dart';
import '../../../business_logic/database_helper/app_Cubit.dart';
import '../../../generated/locale_keys.dart';
import '../../widgets/sign_up_form/sign_up_form.dart';

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
  String? birthDate;

  File? image;
  String image1 = "";

  cropImage(PickedFile picked) async {
    try {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: picked.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: '',
            toolbarColor: MyColors.mainColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
        ],
      );

      if (croppedFile != null) {
        setState(() {
          image = File(croppedFile.path);
          image1 = croppedFile.path;
        });
      } else {
        setState(() {
          image = File(picked.path);
          image1 = picked.path;
        });
      }
    } catch (e) {
      print('piker error:' + e.toString());
    }
  }

  Future getImage() async {
    ImagePicker picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        cropImage(pickedFile);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return PreferredSize(
      preferredSize: Size(w, h),
      child: Scaffold(
        backgroundColor: Colors.white70,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xff3A0CA3).withOpacity(0.4),
                Colors.white70,
                Colors.white,
                Colors.white,
                Colors.white,
              ],
            ),
          ),
          child: SingleChildScrollView(
            primary: true,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: w * 0.05, vertical: h * 0.02),
              child: Column(
                children: [
                  SizedBox(height: h * 0.035),
                  (prefs.getString('lang') == 'en')
                      ? Align(
                          alignment: Alignment.topLeft,
                          child: InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 30,
                              color: const Color(0xff3A0CA3).withOpacity(0.5),
                            ),
                          ),
                        )
                      : Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 30,
                              color: const Color(0xff3A0CA3).withOpacity(0.5),
                            ),
                          ),
                        ),
                  SizedBox(height: h * 0.02),
                  Stack(
                    children: [
                      Center(
                        child: Container(
                          height: h * 0.21,
                          // width: w * 0.23,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: (prefs.getString("user_image") != null &&
                                  image == null)
                              ? CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 180,
                                  backgroundImage: NetworkImage(
                                      prefs.getString("user_image")!),
                                )
                              : (image != null)
                                  ? CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 180,
                                      backgroundImage: FileImage(
                                        image!,
                                      ),
                                    )
                                  : Center(
                                      child: Icon(
                                        FontAwesomeIcons.fileImage,
                                        size: w * 0.2,
                                        color: Colors.black,
                                      ),
                                    ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          await getImage();
                        },
                        child: Container(
                          margin: (prefs.getString('lang') == 'en')
                              ? EdgeInsets.only(
                                  left: w * 0.54,
                                  top: h * 0.14,
                                )
                              : EdgeInsets.only(
                                  right: w * 0.54,
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
                      ),
                    ],
                  ),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  Text(
                    LocaleKeys.EDIT_PROFILE.tr(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins',
                      color: Color(0xff3A0CA3),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: w * 0.4,
                        child: profileFormField(
                            readOnly: false,
                            enabled: true,
                            initialValue:
                                prefs.getString('firstName').toString(),
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
                      ),
                      SizedBox(
                        width: w * 0.4,
                        child: profileFormField(
                            readOnly: false,
                            enabled: true,
                            initialValue:
                                prefs.getString('lastName').toString(),
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
                      ),
                    ],
                  ),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  profileFormField(
                      enabled: true,
                      readOnly: false,
                      validator: (val) {
                        return null;
                      },
                      obscureText: false,
                      hintText: 'Email',
                      initialValue: prefs.getString('email').toString(),
                      onChange: (String value) {
                        setState(() {
                          emailController = value;
                        });
                      }),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  profileFormField(
                      enabled: true,
                      readOnly: false,
                      validator: (val) {
                        return null;
                      },
                      obscureText: false,
                      hintText: 'Phone',
                      initialValue: (prefs.getString('phoneNumber') != "null")
                          ? prefs.getString('phoneNumber').toString()
                          : '',
                      onChange: (String value) {
                        setState(() {
                          phoneController = value;
                        });
                      }),
                  SizedBox(
                    height: h * 0.04,
                  ),
                  InkWell(
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime(1995, 1, 1),
                        firstDate: DateTime(1995, 1, 1),
                        lastDate: DateTime(2022, 1, 1),
                        initialDatePickerMode: DatePickerMode.year,
                        builder: (context, child) {
                          return Theme(
                              data: ThemeData(
                                primaryColor: MyColors.mainColor,
                                accentColor: MyColors.mainColor,
                              ),
                              child: child ?? Container());
                        },
                      );
                      if (date != null) {
                        var formatter = DateFormat('yyyy/MM/dd');

                        setState(() {
                          birthDate = formatter.format(date);
                          print(birthDate);
                        });
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (birthDate != null)
                                ? birthDate!
                                : (prefs.getString('dateofbirth') != "")
                                    ? prefs.getString('dateofbirth').toString()
                                    : "Date Of Birth",
                            style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: h * 0.01,
                          ),
                          Divider(
                            color: MyColors.unslectedIconColor,
                            thickness: 1,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  profileFormField(
                      readOnly: false,
                      enabled: true,
                      validator: (val) {
                        return null;
                      },
                      obscureText: false,
                      hintText: 'Address',
                      initialValue: (prefs.getString('userAddress') != "null")
                          ? prefs.getString('userAddress').toString()
                          : '',
                      onChange: (String value) {
                        setState(() {
                          addressController = value.toString();
                        });
                      }),
                  SizedBox(
                    height: h * 0.03,
                  ),
                  BlocConsumer<AuthenticationcubitCubit,
                      AuthenticationcubitState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      print(prefs.getString('governorate_nameEN').toString());
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              showGoverMenu(
                                  positioned: const RelativeRect.fromLTRB(
                                      0, 380, 300, 100),
                                  context: context,
                                  w: w,
                                  list: AuthenticationcubitCubit.get(context)
                                      .governorate);
                            },
                            child: Row(
                              children: [
                                (AppCubit.get(context).governorate != null)
                                    ? Text(
                                        AppCubit.get(context).governorate!,
                                        style:
                                            headingStyle.copyWith(fontSize: 16),
                                      )
                                    : (prefs
                                                .getString('governorate_nameEN')
                                                .toString() !=
                                            'null')
                                        ? Text(
                                            '${prefs.getString('governorate_nameEN')}',
                                            style: headingStyle.copyWith(
                                                fontSize: 16),
                                          )
                                        : Text(
                                            LocaleKeys.Governorate.tr(),
                                            style: headingStyle.copyWith(
                                                fontSize: 16),
                                          ),
                                SizedBox(
                                  width: w * 0.01,
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: MyColors.mainColor,
                                  size: w * 0.065,
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              showCitysMenu(
                                  context: context,
                                  w: w,
                                  list: AuthenticationcubitCubit.get(context)
                                      .city);
                            },
                            child: BlocConsumer<AppCubit, AppState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                return Row(
                                  children: [
                                    (AppCubit.get(context).city != null)
                                        ? Text(
                                            AppCubit.get(context).city!,
                                            style: headingStyle.copyWith(
                                                fontSize: 16),
                                          )
                                        : (prefs
                                                    .getString('city_nameEN')
                                                    .toString() !=
                                                'null')
                                            ? Text(
                                                '${prefs.getString('city_nameEN')}',
                                                style: headingStyle.copyWith(
                                                    fontSize: 16),
                                              )
                                            : Text(
                                                LocaleKeys.City.tr(),
                                                style: headingStyle.copyWith(
                                                    fontSize: 16),
                                              ),
                                    SizedBox(
                                      width: w * 0.01,
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_down,
                                      color: MyColors.mainColor,
                                      size: w * 0.065,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(
                    height: h * 0.03,
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
                    child: Text(
                      LocaleKeys.Change_Password.tr(),
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins',
                        color: Color(0xff3A0CA3),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.03,
                  ),
                  BlocConsumer<AuthenticationcubitCubit,
                      AuthenticationcubitState>(
                    builder: (context, state) {
                      return defaultButton(
                        margin: EdgeInsets.symmetric(horizontal: w * 0.13),
                        title: LocaleKeys.SAVE.tr(),
                        onPressed: () {
                          AuthenticationcubitCubit.get(context).updateProfile(
                              address: addressController ??
                                  prefs.getString('userAddress').toString(),
                              userId: prefs.getString('userId').toString(),
                              email: emailController ??
                                  prefs.getString('email').toString(),
                              firstName: usernameController ??
                                  prefs.getString('firstName').toString(),
                              phone: (prefs.getString('phoneNumber') != "null")
                                  ? prefs.getString('phoneNumber').toString()
                                  : (phoneController != null)
                                      ? phoneController!
                                      : "",
                              image: (image1 == '')
                                  ? prefs.getString('user_image').toString()
                                  : image1,
                              birthDate: (birthDate != null)
                                  ? birthDate
                                  : prefs.getString('dateofbirth'),
                              lastName: lastnameController ??
                                  prefs.getString('lastName').toString(),
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
                    listener: (context, state) {
                      if (state is UpdateProfileSuccessState) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const BottomNave(index: 0)),
                            (route) => false);
                      }
                    },
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
