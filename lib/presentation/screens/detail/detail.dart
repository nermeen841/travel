import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel/business_logic/home_cubit/home_cubit.dart';
import 'package:travel/business_logic/home_cubit/home_states.dart';
import 'package:travel/constants/colors.dart';
import 'package:travel/presentation/screens/map/map_track.dart';

import '../../../business_logic/database_helper/app_Cubit.dart';
import '../../../business_logic/database_helper/app_states.dart';
import '../../../business_logic/favourite_cubit.dart/favourite_cubit_cubit.dart';
import '../../../constants/constants.dart';
import 'componnent/body.dart';
import 'componnent/componnent.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  List<String> images = [
    "https://img.freepik.com/free-photo/temple-abu-simbel-egypt_134785-242.jpg?w=740",
    "https://img.freepik.com/free-photo/egyptian-desert-design_1048-1862.jpg?w=740",
    "https://img.freepik.com/free-photo/sphinx-pyramids-egypt_414617-6.jpg?w=740"
  ];
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        toolbarHeight: 0.0,
        backgroundColor: MyColors.mainColor,
      ),
      body: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: state is! PlaceDetailLoadingState,
            builder: (context) => SingleChildScrollView(
              child: Column(
                // shrinkWrap: true,
                // primary: true,
                children: [
                  SizedBox(
                    width: w,
                    height: h * 0.5,
                    child: Stack(
                      children: [
                        Swiper(
                          pagination: SwiperPagination(
                              builder: DotSwiperPaginationBuilder(
                                  color:
                                      MyColors.backgroundColor.withOpacity(0.5),
                                  activeColor: MyColors.mainColor),
                              alignment: Alignment.bottomCenter),
                          itemBuilder: (BuildContext context, int i) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                  image: NetworkImage(images[i]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                          itemCount: images.length,
                          autoplay: true,
                          autoplayDelay: 5000,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: h * 0.01, horizontal: w * 0.045),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: h * 0.013),
                                child: InkWell(
                                  onTap: () => Navigator.pop(context),
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                    size: w * 0.08,
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  BlocConsumer<FavouriteCubit, FavouriteState>(
                                    listener: (context, state) {},
                                    builder: (context, state) {
                                      return InkWell(
                                        onTap: () {
                                          final bool isLogin =
                                              prefs.getBool("is_login") ??
                                                  false;
                                          if (isLogin) {
                                            if (FavouriteCubit.get(context)
                                                        .isFavourite[
                                                    HomeCubit.get(context)
                                                        .placeDetailModel
                                                        .id!] ==
                                                true) {
                                              FavouriteCubit.get(context)
                                                  .removeFromFavourite(
                                                      placeID:
                                                          HomeCubit.get(context)
                                                              .placeDetailModel
                                                              .id!);
                                            } else if (FavouriteCubit.get(
                                                                context)
                                                            .isFavourite[
                                                        HomeCubit.get(context)
                                                            .placeDetailModel
                                                            .id!] ==
                                                    false ||
                                                FavouriteCubit.get(context)
                                                            .isFavourite[
                                                        HomeCubit.get(context)
                                                            .placeDetailModel
                                                            .id!] ==
                                                    null) {
                                              FavouriteCubit.get(context)
                                                  .addToFavourite(
                                                      placeID:
                                                          HomeCubit.get(context)
                                                              .placeDetailModel
                                                              .id!);
                                            }
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: "you must login first",
                                                toastLength: Toast.LENGTH_LONG,
                                                gravity: ToastGravity.TOP,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          }
                                        },
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(top: 10),
                                          width: w * 0.09,
                                          height: h * 0.05,
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle),
                                          child: Center(
                                            child: (FavouriteCubit.get(context)
                                                            .isFavourite[
                                                        HomeCubit.get(context)
                                                            .placeDetailModel
                                                            .id!] ==
                                                    true)
                                                ? Icon(
                                                    Icons.favorite,
                                                    color: MyColors.mainColor,
                                                    size: w * 0.06,
                                                  )
                                                : Icon(
                                                    Icons.favorite_outline,
                                                    color: MyColors.mainColor,
                                                    size: w * 0.06,
                                                  ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    height: h * 0.02,
                                  ),
                                  InkWell(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MapTrackScreen(
                                                  latitude:
                                                      HomeCubit.get(context)
                                                          .placeDetailModel
                                                          .locationLat
                                                          .toString(),
                                                  logtitude:
                                                      HomeCubit.get(context)
                                                          .placeDetailModel
                                                          .locationLong
                                                          .toString(),
                                                ))),
                                    child: Container(
                                      width: w * 0.09,
                                      height: h * 0.05,
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle),
                                      child: Center(
                                        child: Icon(
                                          FontAwesomeIcons.locationArrow,
                                          color: MyColors.mainColor,
                                          size: w * 0.05,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  headerTitle(
                      h: h,
                      w: w,
                      city: HomeCubit.get(context)
                          .placeDetailModel
                          .city!
                          .nameEN
                          .toString(),
                      name: HomeCubit.get(context)
                          .placeDetailModel
                          .nameEN
                          .toString(),
                      rate: HomeCubit.get(context).placeDetailModel.rate),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  DetailBody(
                    placeID: HomeCubit.get(context).placeDetailModel.id!,
                    placeName: HomeCubit.get(context).placeDetailModel.nameEN!,
                  )
                ],
              ),
            ),
            fallback: (context) => Center(
                child: CircularProgressIndicator(
              color: MyColors.mainColor,
            )),
          );
        },
      ),
    );
  }
}
