// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:travel/constants/colors.dart';
import 'package:travel/presentation/screens/favourite/favouriteScreen.dart';
import 'package:travel/presentation/screens/home/homeScreen.dart';
import 'package:travel/presentation/screens/map/mapScreen.dart';
import 'package:travel/presentation/screens/notification/notificationScreen.dart';

class BottomNave extends StatefulWidget {
  const BottomNave({Key? key}) : super(key: key);

  @override
  _BottomNaveState createState() => _BottomNaveState();
}

class _BottomNaveState extends State<BottomNave> {
  int currentIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    MapScreen(),
    const NotificationScreen(),
    const FavouriteScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        currentIndex: currentIndex,
        backgroundColor: Colors.white,
        selectedItemColor: MyColors.mainColor,
        unselectedItemColor: MyColors.unslectedIconColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: ''),
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.explore),
              icon: Icon(Icons.explore_outlined),
              label: ''),
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.notifications),
              icon: Icon(Icons.notifications_outlined),
              label: ''),
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.favorite),
              icon: Icon(Icons.favorite_outline),
              label: ''),
        ],
      ),
      body: screens[currentIndex],
    );
  }
}
