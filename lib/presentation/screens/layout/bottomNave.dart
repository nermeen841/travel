// ignore_for_file: file_names

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:travel/constants/colors.dart';
import 'package:travel/presentation/screens/favourite/favouriteScreen.dart';
import 'package:travel/presentation/screens/home/homeScreen.dart';
import 'package:travel/presentation/screens/map/mapScreen.dart';
import 'package:travel/presentation/screens/notification/notificationScreen.dart';
import 'package:travel/presentation/screens/search/search.dart';

class BottomNave extends StatefulWidget {
  final int index;
  const BottomNave({Key? key, required this.index}) : super(key: key);

  @override
  _BottomNaveState createState() => _BottomNaveState();
}

class _BottomNaveState extends State<BottomNave> {
  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
  int currentIndex = 0;

  List<Widget> screens = [
    const HomeScreen(),
    const SearchScreen(),
    MapScreen(),
    const NotificationScreen(),
    const FavouriteScreen()
  ];
  getIndex() {
    // ignore: unnecessary_null_comparison
    if (widget.index != null) {
      setState(() {
        currentIndex = widget.index;
      });
    } else {
      setState(() {
        currentIndex = 0;
      });
    }
  }

  @override
  void initState() {
    getIndex();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: h * 0.09,
        buttonBackgroundColor: Colors.white,
        color: MyColors.mainColor,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        letIndexChange: (index) => true,
        index: currentIndex,
        backgroundColor: Colors.transparent,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: [
          Icon(
            Icons.home,
            color: (currentIndex == 0) ? MyColors.mainColor : Colors.white,
          ),
          Icon(
            Icons.search,
            color: (currentIndex == 1) ? MyColors.mainColor : Colors.white,
          ),
          Icon(
            Icons.explore,
            color: (currentIndex == 2) ? MyColors.mainColor : Colors.white,
          ),
          Icon(
            Icons.notifications,
            color: (currentIndex == 3) ? MyColors.mainColor : Colors.white,
          ),
          Icon(
            Icons.favorite,
            color: (currentIndex == 4) ? MyColors.mainColor : Colors.white,
          ),
        ],
      ),
      body: screens[currentIndex],
    );
  }
}
