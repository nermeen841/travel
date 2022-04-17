import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel/presentation/screens/authentication/login_or_signup/login_or_signUp_screen.dart';
import 'package:travel/presentation/screens/layout/bottomNave.dart';
import 'package:travel/presentation/screens/onBoarding/onBoarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Widget screen = OnBoardScreen();
  getScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isOnboarding = prefs.getBool("onBoarding") ?? false;
    final bool isLogin = prefs.getBool("is_login") ?? false;
    if (isOnboarding) {
      if (isLogin) {
        setState(() {
          screen = const BottomNave(index: 0);
        });
      } else {
        setState(() {
          screen = const LoginOrSignUpScreen();
        });
      }
    } else {
      setState(() {
        screen = OnBoardScreen();
      });
    }
  }

  @override
  void initState() {
    getScreen();
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (BuildContext context) => screen),
            ));
    // getScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/background.png',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        Align(
          alignment: Alignment.center,
          child: Image.asset(
            'assets/images/Vector.png',
            fit: BoxFit.contain,
            width: 92,
            height: 55,
          ),
        ),
      ],
    );
  }
}
