import 'package:flutter/material.dart';
import 'package:travel/constants/constants.dart';
import 'package:travel/presentation/screens/drawer_screens/about_us_screen.dart';

Widget buildDrawerWidget({required context}) {
  double h = MediaQuery.of(context).size.height;
  double w = MediaQuery.of(context).size.width;

  return Container(
    margin: EdgeInsets.only(
      top: h * 0.01,
    ),
    // padding: EdgeInsets.only(top: h * 0.06,),
    width: 330,
    height: h,
    decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), bottomRight: Radius.circular(25))),
    child: ListView(
      padding: EdgeInsets.only(bottom: h * 0.02),
      children: [
        DrawerHeader(
            child: Image.asset(
          'assets/icons/logo.png',
          color: const Color(0xff3A0CA3),
        )),
        buildRowInDrawer(
            title: 'About Us',
            icon: Icons.info_outline,
            onPress: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AboutUsScreen()));
            }),
        SizedBox(
          height: h * 0.04,
        ),
        buildRowInDrawer(
            title: 'Contact Us', icon: Icons.call_outlined, onPress: () {}),
        SizedBox(
          height: h * 0.04,
        ),
        buildRowInDrawer(
            title: 'Help & FAQ',
            icon: Icons.help_outline_outlined,
            onPress: () {}),
        SizedBox(
          height: h * 0.04,
        ),
        buildRowInDrawer(
            title: 'Rate Us', icon: Icons.star_border_outlined, onPress: () {}),
        SizedBox(
          height: h * 0.04,
        ),
        buildRowInDrawer(title: 'Log Out', icon: Icons.logout, onPress: () {}),
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
        SizedBox(
          height: h * 0.05,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.15),
          child: defaultButton(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 5,
                offset: const Offset(0, 3), // Shadow position
              ),
            ],
            title: 'LOG IN',
            onPressed: () {},
            fontSize: 15,
            height: h * 0.055,
            width: 150,
            color: const Color(0xff3A0CA3),
            textColor: Colors.white,
          ),
        ),
        SizedBox(
          height: h * 0.02,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.15),
          child: defaultButton(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(2, 5), // Shadow position
              ),
            ],
            title: 'SIGN UP',
            onPressed: () {},
            fontSize: 15,
            height: h * 0.055,
            width: 150,
            color: Colors.white,
            textColor: const Color(0xff3A0CA3),
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
        ],
      ),
    ),
  );
}
