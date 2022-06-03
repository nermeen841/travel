import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:travel/business_logic/home_cubit/home_cubit.dart';
import 'package:travel/business_logic/home_cubit/home_states.dart';
import 'package:travel/constants/colors.dart';
import 'package:travel/presentation/screens/review/review.dart';

import '../../../../constants/constants.dart';
import '../../../../generated/locale_keys.dart';

headerTitle(
    {required double h,
    required double w,
    required String name,
    required String city,
    required double? rate}) {
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
              name,
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
                  city,
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
          initialRating: rate!,
          minRating: 1,
          itemSize: w * 0.065,
          direction: Axis.horizontal,
          allowHalfRating: true,
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

overview({required double w, required double h}) {
  return BlocConsumer<HomeCubit, HomeState>(
      builder: (context, state) {
        return ConditionalBuilder(
            condition: state is! PlaceDetailLoadingState,
            builder: (context) {
              return Text(
                (prefs.getString("lang") == "en")
                    ? HomeCubit.get(context).placeDetailModel.overViewEN!
                    : HomeCubit.get(context).placeDetailModel.overViewAR!,
                style: headingStyle.copyWith(
                    height: h * 0.003, wordSpacing: w * 0.007),
                textAlign: TextAlign.start,
                textHeightBehavior: const TextHeightBehavior(
                    leadingDistribution: TextLeadingDistribution.even,
                    applyHeightToFirstAscent: true,
                    applyHeightToLastDescent: true),
              );
            },
            fallback: (context) => CircularProgressIndicator(
                  color: MyColors.mainColor,
                ));
      },
      listener: (context, state) {});
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

Widget reviews({
  required double h,
  required double w,
  required context,
  required int placeID,
  required String placeString,
}) {
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
                    builder: (context) => AddReviewScreen(
                          placeId: placeID,
                          placeName: placeString,
                        )));
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
            itemBuilder: (context, index) => BlocConsumer<HomeCubit, HomeState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return (HomeCubit.get(context).reviews.isNotEmpty)
                        ? getReviewCard(
                            context: context,
                            rate: HomeCubit.get(context).reviews[index].rate!,
                            userReview: HomeCubit.get(context)
                                .reviews[index]
                                .review
                                .toString(),
                            user: 'Van Ngo')
                        : Center(
                            child: Text('Give Us Your Review',
                                style: headingStyle.copyWith(fontSize: 18)),
                          );
                  },
                ),
            itemCount: HomeCubit.get(context).reviews.length),
      ],
    ),
  );
}

Widget getReviewCard({
  required context,
  required double rate,
  required String userReview,
  required String user,
}) {
  double h = MediaQuery.of(context).size.height;
  double w = MediaQuery.of(context).size.height;
  // var homeCubit = HomeCubit.get(context).reviews;
  return Container(
    margin: EdgeInsets.all(w * 0.02),
    padding: EdgeInsets.symmetric(horizontal: w * 0.03, vertical: h * 0.01),
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
            initialRating: rate,
            minRating: 1,
            itemSize: w * 0.033,
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
          userReview,
          style: headingStyle.copyWith(color: Colors.grey, fontSize: 17),
        ),
        Row(
          children: [
            Container(
              width: w * 0.1,
              height: h * 0.1,
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
                  user,
                  style: headingStyle.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
