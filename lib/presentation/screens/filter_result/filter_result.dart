import 'package:flutter/material.dart';
import 'package:travel/constants/colors.dart';
import 'package:travel/presentation/screens/filter_result/componnent/componnent.dart';

class FilterResultScreen extends StatefulWidget {
  const FilterResultScreen({Key? key}) : super(key: key);

  @override
  State<FilterResultScreen> createState() => _FilterResultScreenState();
}

class _FilterResultScreenState extends State<FilterResultScreen> {
  List<String> text = [
    "Resturants",
    "Hotels",
    "Cafes",
    "Parks",
  ];
  late PageController pageController;
  @override
  void initState() {
    pageController = PageController(initialPage: currentIndex);
    super.initState();
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        toolbarHeight: 0.0,
      ),
      body: Container(
        width: w,
        height: h,
        padding:
            EdgeInsets.symmetric(vertical: h * 0.025, horizontal: w * 0.035),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Image.asset("assets/icons/close.png"),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Hotels",
                style: headingStyle.copyWith(
                    fontWeight: FontWeight.bold, fontSize: w * 0.06),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "In Damietta",
                style: headingStyle.copyWith(
                    fontWeight: FontWeight.w400, fontSize: w * 0.05),
              ),
            ),
            SizedBox(
              height: h * 0.03,
            ),
            Center(
              child: Container(
                height: h * 0.08,
                padding: EdgeInsets.only(top: h * 0.015),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(w * 0.08),
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(0, 3),
                        color: MyColors.backgroundColor,
                        spreadRadius: 3,
                        blurRadius: 3)
                  ],
                ),
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        text.length,
                        (index) => Column(
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
                                buildDot(index: index, h: h, w: w),
                              ],
                            ),
                        growable: true),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: h * 0.03,
            ),
            SizedBox(
              width: w,
              height: h * 0.64,
              child: PageView.builder(
                  controller: pageController,
                  itemCount: text.length,
                  onPageChanged: (val) {
                    setState(() {
                      currentIndex = val;
                    });
                  },
                  itemBuilder: (context, index) {
                    return ListView.separated(
                        shrinkWrap: true,
                        primary: true,
                        itemBuilder: (context, index) => filterCard(w: w, h: h),
                        separatorBuilder: (context, index) => SizedBox(
                              height: h * 0.03,
                            ),
                        itemCount: 5);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot(
      {required int index, required double h, required double w}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: w * 0.02,
      height: h * 0.02,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:
              currentIndex == index ? MyColors.mainColor : Colors.transparent),
      child: InkWell(
          onTap: () {
            pageController.animateToPage(index,
                duration: const Duration(microseconds: 500),
                curve: Curves.fastOutSlowIn);
          },
          child: Container(
            width: w * 0.04,
          )),
    );
  }
}
