import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:travel/business_logic/favourite_cubit.dart/favourite_cubit_cubit.dart';
import 'package:travel/constants/colors.dart';
import 'package:travel/constants/constants.dart';

favouriteCard(
    {required double h,
    required double w,
    required int placeId,
    required String name,
    required int categoryId,
    required String address,
    required double rate}) {
  return Container(
    height: h * 0.17,
    margin: EdgeInsets.symmetric(horizontal: w * 0.01),
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
          width: w * 0.3,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: (prefs.getString('lang') == 'en')
                ? BorderRadius.only(
                    topLeft: Radius.circular(w * 0.05),
                    bottomLeft: Radius.circular(w * 0.05))
                : BorderRadius.only(
                    topRight: Radius.circular(w * 0.05),
                    bottomRight: Radius.circular(w * 0.05)),
            image: const DecorationImage(
              image: NetworkImage(
                  "https://img.freepik.com/free-photo/green-city-park_1127-2299.jpg?w=740"),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        SizedBox(
          width: w * 0.02,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: w * 0.02,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                          width: w * 0.4,
                          child: Text(
                            address,
                            maxLines: 2,
                            style: headingStyle.copyWith(
                                fontWeight: FontWeight.w400,
                                color: MyColors.unslectedIconColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // SizedBox(
                //   width: w * 0.1,
                // ),
                BlocConsumer<FavouriteCubit, FavouriteState>(
                  listener: (context, state) {
                    if (state is RemoveFromFavouriteSuccessState) {
                      FavouriteCubit.get(context)
                          .getFavouritePlaces(categoryId: categoryId);
                    }
                  },
                  builder: (context, state) {
                    return Container(
                      width: w * 0.09,
                      height: h * 0.09,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 3),
                              color: MyColors.backgroundColor,
                              spreadRadius: 3,
                              blurRadius: 3)
                        ],
                      ),
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            FavouriteCubit.get(context)
                                .removeFromFavourite(placeID: placeId);
                          },
                          child: Icon(
                            Icons.favorite,
                            size: w * 0.05,
                            color: MyColors.mainColor,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: h * 0.02,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Text(
                //   "1180 L.E",
                //   style: headingStyle.copyWith(fontWeight: FontWeight.bold),
                // ),
                // SizedBox(
                //   width: w * 0.02,
                // ),
                // Text("Per night", style: headingStyle),
                // SizedBox(
                //   width: w * 0.02,
                // ),
                RatingBar.builder(
                  ignoreGestures: true,
                  tapOnlyMode: false,
                  initialRating: rate,
                  minRating: 1,
                  itemSize: w * 0.04,
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
        SizedBox(
          width: w * 0.03,
        ),
      ],
    ),
  );
}
