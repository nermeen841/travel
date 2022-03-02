import 'package:flutter/material.dart';
import 'package:travel/presentation/screens/home/componnent/componnent.dart';
import 'package:travel/presentation/widget/home_category.dart';
import 'package:travel/presentation/widget/popular_destination.dart';
import 'package:travel/presentation/widget/recommended.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        toolbarHeight: 0.0,
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          primary: true,
          shrinkWrap: true,
          padding:
              EdgeInsets.symmetric(vertical: h * 0.02, horizontal: w * 0.02),
          children: [
            headerTile(h: h, w: w),
            SizedBox(
              height: h * 0.03,
            ),
            introTitle(h: h, w: w),
            SizedBox(
              height: h * 0.03,
            ),
            searchWidget(h: h, w: w),
            SizedBox(
              height: h * 0.03,
            ),
            sectionTitle(h: h, w: w, press: () {}, title: "Categories"),
            SizedBox(
              height: h * 0.03,
            ),
            const HomeCategory(),
            SizedBox(
              height: h * 0.04,
            ),
            sectionTitle(h: h, w: w, press: () {}, title: "Recommended"),
            SizedBox(
              height: h * 0.03,
            ),
            const RecommendedSection(),
            SizedBox(
              height: h * 0.04,
            ),
            sectionTitle(
                h: h, w: w, press: () {}, title: "Popular Destinations"),
            SizedBox(
              height: h * 0.03,
            ),
            const PopularDestinations()
          ],
        ),
      ),
    );
  }
}
