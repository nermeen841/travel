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
import 'package:travel/business_logic/database_helper/database_cubit.dart';
import 'package:travel/constants/colors.dart';
import 'package:travel/constants/constants.dart';
import 'package:travel/presentation/widgets/profile_wdgets/profile_widgets.dart';

import '../../../generated/locale_keys.dart';

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
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xff3A0CA3).withOpacity(0.99),
                Colors.white70,
                Colors.white,
                Colors.white,
                Colors.white,
              ],
            ),
          ),
          child: SingleChildScrollView(
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
                                  height: h * 0.21,
                                  // width: w * 0.23,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: (prefs.getString("user_image") !=
                                              null &&
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
                                  margin: EdgeInsets.only(
                                    left: w * 0.54,
                                    top: h * 0.14,
                                  ),
                                  height: h * 0.05,
                                  width: w * 0.1,
                                  decoration: BoxDecoration(
                                      color: const Color(0xff3A0CA3),
                                      border: Border.all(
                                          color: Colors.white, width: 1),
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
                              readOnly: false,
                              enabled: true,
                              initialValue: DataBaseCubit.get(context)
                                  .userData[i]['firstName'],
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
                              readOnly: false,
                              enabled: true,
                              initialValue: DataBaseCubit.get(context)
                                  .userData[i]['lastName'],
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
                              enabled: true,
                              readOnly: false,
                              validator: (val) {
                                return null;
                              },
                              obscureText: false,
                              hintText: 'Email',
                              initialValue: DataBaseCubit.get(context)
                                  .userData[i]['email'],
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
                              initialValue: (DataBaseCubit.get(context)
                                          .userData[i]['userPhone'] !=
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
                                        : (DataBaseCubit.get(context)
                                                    .userData[i]['birthDate'] !=
                                                "null")
                                            ? DataBaseCubit.get(context)
                                                .userData[i]['birthDate']
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
                              initialValue: (DataBaseCubit.get(context)
                                          .userData[i]['userAddress'] !=
                                      "null")
                                  ? DataBaseCubit.get(context).userData[i]
                                      ['userAddress']
                                  : '',
                              onChange: (String value) {
                                setState(() {
                                  addressController = value.toString();
                                });
                              }),
                          SizedBox(
                            height: h * 0.05,
                          ),
                          BlocConsumer<AuthenticationcubitCubit,
                                  AuthenticationcubitState>(
                              builder: (context, state) {
                                return defaultButton(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: w * 0.13),
                                  title: LocaleKeys.SAVE.tr(),
                                  onPressed: () {
                                    AuthenticationcubitCubit.get(context)
                                        .updateProfile(
                                            address: addressController ??
                                                DataBaseCubit.get(context).userData[i]
                                                    ['userAddress'],
                                            userId: DataBaseCubit.get(context).userData[i]
                                                ['userId'],
                                            email: emailController ??
                                                DataBaseCubit.get(context).userData[i]
                                                    ['email'],
                                            firstName: usernameController ??
                                                DataBaseCubit.get(context).userData[i]
                                                    ['firstName'],
                                            phone: (DataBaseCubit.get(context).userData[i]
                                                        ['userPhone'] !=
                                                    "null")
                                                ? DataBaseCubit.get(context).userData[i]
                                                    ['userPhone']
                                                : (phoneController != null)
                                                    ? phoneController
                                                    : "",
                                            image: (image1 == '')
                                                ? DataBaseCubit.get(context).userData[i]
                                                    ['image']
                                                : image1,
                                            birthDate: (birthDate != null)
                                                ? birthDate
                                                : DataBaseCubit.get(context).userData[i]
                                                    ['birthDate'],
                                            lastName: lastnameController ?? DataBaseCubit.get(context).userData[i]['lastName'],
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
        ),
      ),
    );
  }
}
