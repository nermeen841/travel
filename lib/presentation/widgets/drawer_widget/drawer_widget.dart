// ignore_for_file: prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:travel/constants/colors.dart';
import 'package:travel/constants/constants.dart';
import 'package:travel/generated/locale_keys.dart';
import 'package:travel/presentation/screens/authentication/login/login_screen.dart';
import 'package:travel/presentation/screens/authentication/sign_up/sign_up_screen.dart';
import 'package:travel/presentation/screens/drawer_screens/about_us_screen.dart';
import 'package:travel/presentation/screens/profile/user_profile.dart';
import 'package:travel/presentation/screens/splash/splash_screen.dart';

import '../../../constants/localization_constant.dart';
import '../../../main.dart';

Widget buildDrawerWidget({required context}) {
  double h = MediaQuery.of(context).size.height;
  double w = MediaQuery.of(context).size.width;

  return Container(
    margin: EdgeInsets.only(
      top: h * 0.01,
    ),
    width: 300,
    height: h,
    decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xff3A0CA3).withOpacity(0.99),
            Colors.white,
            Colors.white,
          ],
        ),
        borderRadius: (prefs.getString('lang') == 'en')
            ? BorderRadius.only(
                topRight: Radius.circular(30), bottomRight: Radius.circular(25))
            : BorderRadius.only(
                topLeft: Radius.circular(30), bottomLeft: Radius.circular(25))),
    child: ListView(
      padding: EdgeInsets.only(bottom: h * 0.02),
      children: [
        DrawerHeader(
            child: Image.asset(
          'assets/icons/logo.png',
          color: Colors.white,
        )),
        buildRowInDrawer(
            title: LocaleKeys.About_Us.tr(),
            icon: Icons.info_outline,
            onPress: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AboutUsScreen()));
            }),
        SizedBox(
          height: h * 0.04,
        ),
        buildRowInDrawer(
            title: LocaleKeys.Contact_Us.tr(),
            icon: Icons.call_outlined,
            onPress: () {}),
        SizedBox(
          height: h * 0.04,
        ),
        buildRowInDrawer(
            title: LocaleKeys.Help.tr(),
            icon: Icons.help_outline_outlined,
            onPress: () {}),
        SizedBox(
          height: h * 0.04,
        ),
        buildRowInDrawer(
            title: LocaleKeys.Rate.tr(),
            icon: Icons.star_border_outlined,
            onPress: () {}),
        SizedBox(
          height: h * 0.03,
        ),
        buildRowInDrawer(
            title: LocaleKeys.LANGUEG.tr(),
            icon: Icons.language,
            widget: PopupMenuButton(
                icon: Icon(Icons.arrow_drop_down_circle_outlined,
                    color: MyColors.mainColor),
                itemBuilder: (context) => [
                      PopupMenuItem(
                        onTap: () async {
                          // ignore: deprecated_member_use
                          context.locale = await setLocale('en');
                          MyApp.setLocale(context, context.locale);

                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SplashScreen()),
                              (route) => false);
                        },
                        child: const Text(
                          "English",
                        ),
                        value: 1,
                      ),
                      PopupMenuItem(
                        onTap: () async {
                          // ignore: deprecated_member_use
                          context.locale = await setLocale('ar');
                          MyApp.setLocale(context, context.locale);
                          // prefs.setString('lang', 'ar');
                          // // setState(() {
                          // context.locale = const Locale('ar', '');
                          // // });
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SplashScreen()),
                              (route) => false);
                        },
                        child: const Text("اللغة العربية"),
                        value: 2,
                      )
                    ]),
            onPress: () {}),
        SizedBox(
          height: h * 0.03,
        ),
        (prefs.getBool("is_login") == true)
            ? buildRowInDrawer(
                title: LocaleKeys.LOG_OUT.tr(),
                icon: Icons.logout,
                onPress: () {
                  prefs.remove('user_token');
                  prefs.remove('user_image');
                  prefs.remove('is_login');
                  prefs.remove('email');
                  prefs.remove('userId');
                  prefs.remove('userAddress');
                  prefs.remove('phoneNumber');
                  prefs.remove('dateofbirth');
                  prefs.remove('firstName');
                  prefs.remove('lastName');
                  prefs.remove('pass_token');
                  prefs.remove('city_id_search');
                  prefs.remove('search_cat');

                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const SplashScreen())),
                      (route) => false);
                },
              )
            : Container(),
        SizedBox(
          height: h * 0.07,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 60),
          child: Divider(
            height: 1,
            thickness: 1,
            color: Color(0xffE5E5E5),
          ),
        ),
        (prefs.getBool("is_login") == false)
            ? SizedBox(
                height: h * 0.05,
              )
            : const SizedBox(),
        (prefs.getBool("is_login") == false)
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.15),
                child: defaultButton(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 5,
                      offset: const Offset(0, 3), // Shadow position
                    ),
                  ],
                  title: LocaleKeys.Login.tr(),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  fontSize: 15,
                  height: h * 0.055,
                  width: 150,
                  color: const Color(0xff3A0CA3),
                  textColor: Colors.white,
                ),
              )
            : Container(),
        SizedBox(
          height: h * 0.02,
        ),
        (prefs.getBool("is_login") == false)
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.15),
                child: defaultButton(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(2, 5), // Shadow position
                    ),
                  ],
                  title: LocaleKeys.SignUp.tr(),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpScreen()));
                  },
                  fontSize: 15,
                  height: h * 0.055,
                  width: 150,
                  color: Colors.white,
                  textColor: const Color(0xff3A0CA3),
                ),
              )
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.03),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserProfileScreen()));
                      },
                      child: CircleAvatar(
                        radius: w * 0.065,
                        backgroundColor: MyColors.mainColor,
                        child: CircleAvatar(
                          radius: w * 0.06,
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(
                              prefs.getString("user_image").toString()),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: w * 0.02,
                    ),
                    Text(
                      prefs.getString('firstName').toString() +
                          " " +
                          prefs.getString('lastName').toString(),
                      style: headingStyle.copyWith(
                          color: Colors.black,
                          fontSize: w * 0.03,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
      ],
    ),
  );
}

Widget buildRowInDrawer({
  required IconData icon,
  required String title,
  required GestureTapCallback onPress,
  Widget? widget,
}) {
  return InkWell(
    onTap: onPress,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xff3A0CA3),
            size: 25,
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xff3A0CA3),
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
              fontSize: 16,
            ),
          ),
          Spacer(),
          (widget != null) ? widget : SizedBox(),
        ],
      ),
    ),
  );
}
