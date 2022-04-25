// ignore_for_file: file_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:travel/constants/colors.dart';
import 'package:travel/generated/locale_keys.g.dart';
import 'package:travel/presentation/screens/home/componnent/componnent.dart';
import 'package:travel/presentation/screens/layout/bottomNave.dart';
import 'package:travel/presentation/screens/more/more.dart';
import 'package:travel/presentation/screens/profile/user_profile.dart';
import 'package:travel/presentation/widgets/drawer_widget/drawer_widget.dart';
import 'package:travel/presentation/widgets/home_widgets/filter_alert.dart';
import 'package:travel/presentation/widgets/home_widgets/home_category.dart';
import 'package:travel/presentation/widgets/home_widgets/popular_destination.dart';
import 'package:travel/presentation/widgets/home_widgets/recommended.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> images = [
    "https://img.freepik.com/free-photo/tasty-pepperoni-pizza-with-mushrooms-olives_79782-1976.jpg?w=900",
    "https://img.freepik.com/free-photo/plate-with-cutlery-well-decorated-with-napkin-tied-with-golden-bow_1220-609.jpg?w=740",
    "https://img.freepik.com/free-photo/beautiful-luxury-outdoor-swimming-pool-hotel-resort_74190-7433.jpg?w=740",
    "https://img.freepik.com/free-photo/close-up-twin-welcome-coffee-cup-white-bed-hotel-room-hotel-well-hospitality-vacation-travel-concept_1150-13594.jpg?w=740"
  ];
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      key: scaffoldKey,
      drawer: buildDrawerWidget(context: context),
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
              EdgeInsets.symmetric(vertical: h * 0.025, horizontal: w * 0.03),
          children: [
            headerTile(
                h: h,
                w: w,
                drawerOnTap: () {
                  scaffoldKey.currentState!.openDrawer();
                },
                profileOnTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserProfileScreen()));
                }),
            SizedBox(
              height: h * 0.03,
            ),
            introTitle(h: h, w: w),
            SizedBox(
              height: h * 0.02,
            ),
            searchWidget(
              h: h,
              w: w * 1.04,
              context: context,
              filter: () => filterAlert(h: h, w: w, context: context),
            ),
            SizedBox(
              height: h * 0.02,
            ),
            SizedBox(
              width: w,
              height: h * 0.3,
              child: Swiper(
                pagination: SwiperPagination(
                    builder: DotSwiperPaginationBuilder(
                        color: MyColors.backgroundColor.withOpacity(0.5),
                        activeColor: MyColors.mainColor),
                    alignment: Alignment.bottomCenter),
                itemBuilder: (BuildContext context, int i) {
                  return InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(w * 0.05),
                        image: DecorationImage(
                          image: NetworkImage(images[i]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    focusColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    // overlayColor: ,
                    onTap: () async {},
                  );
                },
                itemCount: images.length,
                autoplay: true,
                autoplayDelay: 5000,
              ),
            ),
            SizedBox(
              height: h * 0.03,
            ),
            sectionTitle(
                h: h,
                w: w,
                viewMore: LocaleKeys.More.tr(),
                press: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewMoreScreen(
                              title: LocaleKeys.Categories.tr(),
                            ))),
                title: LocaleKeys.Categories.tr()),
            SizedBox(
              height: h * 0.03,
            ),
            const HomeCategory(),
            SizedBox(
              height: h * 0.015,
            ),
            sectionTitle(
                h: h,
                w: w,
                viewMore: '',
                press: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewMoreScreen(
                              title: LocaleKeys.Recommended.tr(),
                            ))),
                title: LocaleKeys.Recommended.tr()),
            SizedBox(
              height: h * 0.02,
            ),
            const RecommendedSection(),
            SizedBox(
              height: h * 0.02,
            ),
            sectionTitle(
                h: h,
                w: w,
                viewMore: '',
                press: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewMoreScreen(
                              title: LocaleKeys.Popular.tr(),
                            ))),
                title: LocaleKeys.Popular.tr()),
            SizedBox(
              height: h * 0.025,
            ),
            const PopularDestinations(),
            SizedBox(
              height: h * 0.03,
            ),
          ],
        ),
      ),
    );
  }
}
