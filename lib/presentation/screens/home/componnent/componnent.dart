import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:travel/constants/colors.dart';

headerTile({required double h, required double w}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      InkWell(
        onTap: () {},
        child: Image.asset(
          "assets/icons/Menu.png",
          color: Colors.black,
        ),
      ),
      Container(
        width: w * 0.1,
        height: h * 0.06,
        padding:
            EdgeInsets.symmetric(vertical: h * 0.009, horizontal: w * 0.01),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(w * 0.02),
        ),
        child: Container(
          width: w * 0.09,
          height: h * 0.05,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(w * 0.02),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(w * 0.02),
            child: Image.network(
              "https://img.freepik.com/free-photo/handsome-confident-smiling-man-with-hands-crossed-chest_176420-18743.jpg?w=740",
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    ],
  );
}

///////////////////////////////////////////////////////////////////////////

introTitle({required double h, required double w}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(
        "The world is yours to",
        style: headingStyle.copyWith(
            fontSize: w * 0.07, fontWeight: FontWeight.w400),
      ),
      Text(
        "Explore",
        style: headingStyle.copyWith(
            fontSize: w * 0.08, fontWeight: FontWeight.bold),
      ),
    ],
  );
}
/////////////////////////////////////////////////////////////////////////

searchWidget({required double h, required double w}) {
  return InkWell(
    onTap: () {},
    child: Container(
      padding: EdgeInsets.symmetric(vertical: h * 0.03, horizontal: w * 0.03),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(w * 0.1),
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
          Image.asset("assets/icons/search.png"),
          SizedBox(
            width: w * 0.02,
          ),
          Text(
            "Where are you going ? ",
            style: headingStyle.copyWith(color: MyColors.unslectedIconColor),
          )
        ],
      ),
    ),
  );
}
///////////////////////////////////////////////////////////////////////////////////////

sectionTitle(
    {required double h,
    required double w,
    required VoidCallback press,
    required String title}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: headingStyle.copyWith(
            fontWeight: FontWeight.bold, fontSize: w * 0.05),
      ),
      Text(
        "View more",
        style: headingStyle.copyWith(
            color: MyColors.unslectedIconColor,
            fontWeight: FontWeight.w500,
            fontSize: w * 0.04),
      ),
    ],
  );
}

//////////////////////////////////////////////////////////////////////////////////////

categoryCard({
  required double w,
  required double h,
}) {
  return Container(
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
          width: w * 0.27,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius:
                // (lang == 'en')
                //     ?
                BorderRadius.only(
                    topLeft: Radius.circular(w * 0.05),
                    bottomLeft: Radius.circular(w * 0.05)),
            // : BorderRadius.only(
            //     topRight: Radius.circular(w * 0.05),
            //     bottomRight: Radius.circular(w * 0.05)),
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
              "Hotel Burj Alarab",
              style: headingStyle.copyWith(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: MyColors.unslectedIconColor,
                  size: w * 0.055,
                ),
                Text(
                  "Umm Sequim 3",
                  style: headingStyle.copyWith(
                      fontWeight: FontWeight.w400,
                      color: MyColors.unslectedIconColor),
                ),
              ],
            ),
            SizedBox(
              height: h * 0.05,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "1180 L.E",
                  style: headingStyle.copyWith(fontWeight: FontWeight.bold),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Per night", style: headingStyle),
                    SizedBox(
                      width: w * 0.03,
                    ),
                    RatingBar.builder(
                      ignoreGestures: true,
                      tapOnlyMode: false,
                      initialRating: 4,
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
