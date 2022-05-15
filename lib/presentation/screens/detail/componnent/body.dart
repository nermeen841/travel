import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:travel/constants/colors.dart';
import 'package:travel/presentation/screens/detail/componnent/componnent.dart';

import '../../../../generated/locale_keys.dart';

class DetailBody extends StatefulWidget {
  final int placeID;
  final String placeName;
  const DetailBody({Key? key, required this.placeID, required this.placeName})
      : super(key: key);

  @override
  State<DetailBody> createState() => _DetailBodyState();
}

class _DetailBodyState extends State<DetailBody> {
  int currentIndex = 0;
  List<String> text = [
    LocaleKeys.overview.tr(),
    LocaleKeys.Details.tr(),
    LocaleKeys.Reviews.tr(),
  ];

  late PageController pageController;
  @override
  void initState() {
    pageController = PageController(initialPage: currentIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    List<Widget> screens = [
      overview(w: w, h: h),
      details(w: w, h: h),
      reviews(
          w: w,
          h: h,
          context: context,
          placeID: widget.placeID,
          placeString: widget.placeName),
    ];
    return Padding(
      // width: double.infinity,
      // height: h * 0.6,
      padding: EdgeInsets.symmetric(horizontal: w * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
                text.length, (index) => buildDot(index: index, h: h, w: w),
                growable: true),
          ),
          SizedBox(
            height: h * 0.03,
          ),
          SizedBox(
            height: h * 0.6,
            child: PageView.builder(
                controller: pageController,
                itemCount: screens.length,
                onPageChanged: (val) {
                  setState(() {
                    currentIndex = val;
                  });
                },
                itemBuilder: (context, index) {
                  return screens[index];
                }),
          ),
        ],
      ),
    );
  }

  AnimatedContainer buildDot(
      {required int index, required double h, required double w}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: w * 0.01),
      child: InkWell(
        onTap: () {
          pageController.animateToPage(index,
              duration: const Duration(microseconds: 500),
              curve: Curves.fastOutSlowIn);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                text[index],
                style: headingStyle.copyWith(
                    fontSize: w * 0.04,
                    fontWeight: (currentIndex == index)
                        ? FontWeight.w600
                        : FontWeight.w400,
                    color: (currentIndex == index)
                        ? MyColors.mainColor
                        : MyColors.unslectedIconColor),
              ),
            ),
            Center(
              child: Container(
                width: w * 0.02,
                height: h * 0.01,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentIndex == index
                        ? MyColors.mainColor
                        : Colors.transparent),
              ),
            )
          ],
        ),
      ),
    );
  }
}
