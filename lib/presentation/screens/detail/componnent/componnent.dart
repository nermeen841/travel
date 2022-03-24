import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:travel/constants/colors.dart';
import 'package:travel/presentation/screens/review/review.dart';

import '../../../../generated/locale_keys.g.dart';

headerTitle({required double h, required double w}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: w * 0.03),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pyramids",
              style: headingStyle.copyWith(
                  fontWeight: FontWeight.bold, fontSize: w * 0.054),
            ),
            SizedBox(
              height: h * 0.01,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/icons/location.png",
                  width: w * 0.025,
                ),
                SizedBox(
                  width: w * 0.01,
                ),
                Text(
                  "Giza",
                  textAlign: TextAlign.start,
                  style: headingStyle.copyWith(
                      fontWeight: FontWeight.w400, fontSize: w * 0.04),
                ),
              ],
            ),
          ],
        ),
        RatingBar.builder(
          ignoreGestures: true,
          tapOnlyMode: false,
          initialRating: 4,
          minRating: 1,
          itemSize: w * 0.065,
          direction: Axis.horizontal,
          allowHalfRating: false,
          itemCount: 5,
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: MyColors.mainColor,
          ),
          onRatingUpdate: (rating) {},
        ),
      ],
    ),
  );
}

////////////////////////////////////////////////////////////////////////////////

Widget overview({required double w, required double h}) {
  return Text(
    "Giza, Egypt The Great Pyramid of Giza is the oldest and largest of the three pyramids in the Giza Necropolis bordering what is now El Giza, Egypt. It is the oldest of the Seven Wonders of the Ancient World, and the only one to remain largely intact",
    style: headingStyle.copyWith(height: h * 0.003, wordSpacing: w * 0.007),
    textAlign: TextAlign.start,
    textHeightBehavior: const TextHeightBehavior(
        leadingDistribution: TextLeadingDistribution.even,
        applyHeightToFirstAscent: true,
        applyHeightToLastDescent: true),
  );
}

////////////////////////////////////////////////////////////////////////////////

Widget details({required double h, required double w}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Row(
        children: [
          Icon(
            Icons.location_on_outlined,
            color: MyColors.mainColor,
          ),
          SizedBox(
            width: w * 0.02,
          ),
          Text(
            "Nazlet El-Semman, Al-haram, Giza",
            style: headingStyle,
          ),
        ],
      ),
      SizedBox(
        height: h * 0.02,
      ),
      Row(
        children: [
          Icon(
            Icons.watch_later_outlined,
            color: MyColors.mainColor,
            size: w * 0.05,
          ),
          SizedBox(
            width: w * 0.02,
          ),
          Text(
            "Open 24 hours",
            style: headingStyle.copyWith(color: MyColors.colorGreen),
          ),
          SizedBox(
            width: w * 0.01,
          ),
          Icon(
            Icons.keyboard_arrow_down,
            color: MyColors.colorGreen,
            size: w * 0.05,
          ),
        ],
      ),
      SizedBox(
        height: h * 0.02,
      ),
      Row(
        children: [
          Icon(
            Icons.call_outlined,
            color: MyColors.mainColor,
          ),
          SizedBox(
            width: w * 0.02,
          ),
          Text(
            "+9055 867 1621",
            style: headingStyle,
          ),
        ],
      ),
      SizedBox(
        height: h * 0.02,
      ),
      Row(
        children: [
          Icon(
            Icons.public_outlined,
            color: MyColors.mainColor,
          ),
          SizedBox(
            width: w * 0.02,
          ),
          Text(
            "WWW.Pyramids.com",
            style: headingStyle,
          ),
        ],
      ),
    ],
  );
}

///////////////////////////////////////////////////////////////////////////////////

Widget reviews({required double h, required double w, required context}) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddReviewScreen()));
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: w * 0.15,
                height: h * 0.15,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://img.freepik.com/free-photo/handsome-confident-smiling-man-with-hands-crossed-chest_176420-18743.jpg?w=740"),
                      fit: BoxFit.cover),
                ),
              ),
              SizedBox(
                width: w * 0.03,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.RateAnd.tr(),
                    style: headingStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                  RatingBar.builder(
                    ignoreGestures: true,
                    tapOnlyMode: false,
                    initialRating: 0,
                    minRating: 1,
                    itemSize: w * 0.07,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemBuilder: (context, _) => Icon(
                      Icons.star_border_outlined,
                      color: MyColors.mainColor,
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                  Text(
                    LocaleKeys.Share.tr(),
                    style: headingStyle.copyWith(
                        fontWeight: FontWeight.w500, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: w * 0.3, right: w * 0.3),
          child: Divider(
            color: MyColors.mainColor,
          ),
        ),
        ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.all(w * 0.02),
                  padding: EdgeInsets.symmetric(
                      horizontal: w * 0.03, vertical: h * 0.01),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(w * 0.05),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: MyColors.backgroundColor,
                          spreadRadius: 3,
                          blurRadius: 3,
                          offset: Offset(0, 3),
                        )
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: h * 0.02,
                      ),
                      Center(
                        child: RatingBar.builder(
                          ignoreGestures: true,
                          tapOnlyMode: false,
                          initialRating: 3,
                          minRating: 1,
                          itemSize: w * 0.045,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: MyColors.mainColor,
                          ),
                          onRatingUpdate: (rating) {},
                        ),
                      ),
                      Text(
                        "Aliqua id fugiat nostrud irure ex duis ea quis id quis ad et. Sunt qui esse pariatur duis ",
                        style: headingStyle.copyWith(color: Colors.grey),
                      ),
                      Row(
                        children: [
                          Container(
                            width: w * 0.15,
                            height: h * 0.15,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://img.freepik.com/free-photo/portrait-beautiful-young-woman-standing-grey-wall_231208-10760.jpg?w=740"),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          SizedBox(
                            width: w * 0.015,
                          ),
                          Column(
                            children: [
                              Text(
                                "Von Ngo",
                                style: headingStyle.copyWith(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "sdsdg",
                                style: headingStyle.copyWith(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            itemCount: 10),
      ],
    ),
  );
}
