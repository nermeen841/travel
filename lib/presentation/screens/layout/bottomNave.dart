// ignore_for_file: file_names

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:sqflite/sqflite.dart';
import 'package:travel/business_logic/database_helper/database_cubit.dart';
import 'package:travel/constants/colors.dart';
import 'package:travel/presentation/screens/favourite/favouriteScreen.dart';
import 'package:travel/presentation/screens/home/homeScreen.dart';
import 'package:travel/presentation/screens/map/mapScreen.dart';
import 'package:travel/presentation/screens/notification/notificationScreen.dart';
import 'package:travel/presentation/screens/search/search.dart';

class BottomNave extends StatefulWidget {
  static double? startLatitude;
  static double? startLongitude;
  final int index;
  const BottomNave({Key? key, required this.index}) : super(key: key);

  @override
  _BottomNaveState createState() => _BottomNaveState();
}

class _BottomNaveState extends State<BottomNave> {
  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
  int currentIndex = 0;
  final location = Location();

  getLocation() async {
    var _serviceEnabled = await location.serviceEnabled();

    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    var _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();

      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    var currentLocation = await location.getLocation();
    setState(() {
      BottomNave.startLatitude = currentLocation.latitude!;
      BottomNave.startLongitude = currentLocation.longitude!;
      String userLocation = currentLocation.latitude!.toString() +
          ' ' +
          currentLocation.longitude!.toString();
      // ignore: avoid_print
      print(userLocation);
    });
  }

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
    DataBaseCubit.get(context).createDb();
    getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return PreferredSize(
      preferredSize: Size(w, h),
      child: Container(
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
        child: Scaffold(
          backgroundColor: Colors.transparent,
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
        ),
      ),
    );
  }
}
