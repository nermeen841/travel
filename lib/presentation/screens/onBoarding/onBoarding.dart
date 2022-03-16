// ignore_for_file: use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travel/constants/colors.dart';
import 'package:travel/presentation/widgets/onBoarding_content/onBoarding_content.dart';

class OnBoardScreen extends StatefulWidget {
  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  var boardController = PageController();

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    List<Widget> onboardItem = [
      buildFirstOnboard(h: h, w: w),
      buildSecondOnboard(h: h, w: w),
      buildThirdOnboard(h: h, w: w, context: context),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.03, vertical: h * 0.02),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index) {
                  if (index == onboardItem.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) => onboardItem[index],
                itemCount: onboardItem.length,
              ),
            ),

            // SizedBox(
            //   height: h * 0.02,
            // ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: onboardItem.length,
                  effect: ExpandingDotsEffect(
                    dotColor: MyColors.mainColor,
                    dotHeight: 7,
                    dotWidth: 12,
                    spacing: 7.0,
                    expansionFactor: 4,
                    activeDotColor: MyColors.mainColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
