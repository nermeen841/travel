import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel/constants/colors.dart';
import '../../../../constants/constants.dart';
import '../../search/componnent/componnent.dart';

headerTile(
    {required double h,
    required double w,
    required context,
    GestureTapCallback? drawerOnTap,
    GestureTapCallback? profileOnTap}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      InkWell(
          onTap: drawerOnTap,
          child: SizedBox(
            width: w * 0.1,
            height: h * 0.05,
            child: Icon(
              Icons.sort,
              color: Colors.white,
              size: w * 0.1,
            ),
          )),
      (prefs.getBool("is_login") == true)
          ? InkWell(
              onTap: profileOnTap,
              child: Container(
                width: w * 0.1,
                height: h * 0.05,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: MyColors.mainColor,
                  ),
                  color: Colors.white,
                  // borderRadius: BorderRadius.circular(w * 0.02),
                  shape: BoxShape.circle,
                ),
                child: (prefs.getString("user_image") != null)
                    ? customCachedNetworkImage(
                        context: context,
                        fit: BoxFit.cover,
                        url: prefs.getString("user_image")!)
                    : Center(
                        child: Icon(
                          FontAwesomeIcons.fileImage,
                          size: w * 0.2,
                          color: Colors.black,
                        ),
                      ),
              ),
            )
          : Container()
    ],
  );
}

///////////////////////////////////////////////////////////////////////////

introTitle({required double h, required double w}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "The world is yours to ",
        style: headingStyle.copyWith(
          fontSize: w * 0.05,
          fontWeight: FontWeight.w400,
        ),
      ),
      Text(
        'Explore',
        style: headingStyle.copyWith(
            fontSize: w * 0.06, fontWeight: FontWeight.bold),
      ),
    ],
  );
}
/////////////////////////////////////////////////////////////////////////

searchWidget(
    {required double h,
    required double w,
    required context,
    required VoidCallback filter}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(
        width: w * 0.73,
        child: searchButton(w: w, h: h),
      ),
      Padding(
        padding: (prefs.getString('lang') == 'en')
            ? EdgeInsets.only(right: w * 0.03)
            : EdgeInsets.only(left: w * 0.03),
        child: InkWell(
          onTap: filter,
          child: Container(
            width: w * 0.15,
            height: h * 0.13,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  blurRadius: 5,
                  offset: const Offset(0, 2), // Shadow position
                ),
              ],
            ),
            child: Image.asset("assets/icons/Filter.png"),
          ),
        ),
      ),
    ],
  );
}
///////////////////////////////////////////////////////////////////////////////////////

sectionTitle({
  required double h,
  required double w,
  required VoidCallback press,
  required String title,
  required String viewMore,
}) {
  return Row(
    // crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: headingStyle.copyWith(
            fontWeight: FontWeight.bold, fontSize: w * 0.05),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.02),
        child: InkWell(
          onTap: press,
          child: Text(
            viewMore,
            style: headingStyle.copyWith(
                color: MyColors.unslectedIconColor,
                fontWeight: FontWeight.w500,
                fontSize: w * 0.03),
          ),
        ),
      ),
    ],
  );
}

//////////////////////////////////////////////////////////////////////////////////////

categoryCard({
  required double w,
  required double h,
  required String address,
  required String name,
  required double? rate,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: h * 0.02),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(w * 0.05),
      boxShadow: const [
        BoxShadow(
            offset: Offset(0, 3),
            color: MyColors.backgroundColor,
            spreadRadius: 3,
            blurRadius: 3)
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: w * 0.31,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: (prefs.getString('lang') == 'en')
                ? BorderRadius.only(
                    topLeft: Radius.circular(w * 0.05),
                    bottomLeft: Radius.circular(w * 0.05))
                : BorderRadius.only(
                    topRight: Radius.circular(w * 0.05),
                    bottomRight: Radius.circular(w * 0.05)),
            image: const DecorationImage(
              image: NetworkImage(
                  "https://img.freepik.com/free-photo/type-entertainment-complex-popular-resort-with-pools-water-parks-turkey-with-more-than-5-million-visitors-year-amara-dolce-vita-luxury-hotel-resort-tekirova-kemer_146671-18728.jpg?w=740"),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        SizedBox(
          width: w * 0.02,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: h * 0.01,
            ),
            Text(
              name,
              style: headingStyle.copyWith(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: MyColors.unslectedIconColor,
                  size: w * 0.055,
                ),
                SizedBox(
                  width: 100,
                  child: Text(
                    address,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: headingStyle.copyWith(
                        fontWeight: FontWeight.w400,
                        color: MyColors.unslectedIconColor),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: h * 0.02,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "1180 L.E",
                  style: headingStyle.copyWith(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                      fontSize: w * 0.033),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Per night",
                      style: headingStyle.copyWith(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          fontSize: w * 0.034),
                    ),
                    SizedBox(
                      width: w * 0.03,
                    ),
                    RatingBar.builder(
                      ignoreGestures: true,
                      tapOnlyMode: false,
                      initialRating: rate ?? 0.0,
                      minRating: 1,
                      itemSize: w * 0.045,
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
              ],
            ),
          ],
        ),
        SizedBox(
          width: w * 0.03,
        ),
      ],
    ),
  );
}
