// ignore_for_file: file_names

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/business_logic/favourite_cubit.dart/favourite_cubit_cubit.dart';
import 'package:travel/business_logic/home_cubit/home_cubit.dart';
import 'package:travel/constants/colors.dart';
import 'package:travel/generated/locale_keys.dart';
import 'package:travel/presentation/screens/favourite/componnent/componnent.dart';

import '../../../constants/constants.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
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
      backgroundColor: Colors.transparent,
      body: (prefs.getBool("is_login") == true)
          ? BlocConsumer<FavouriteCubit, FavouriteState>(
              listener: (context, state) {
                if (state is GetFavouriteCategorySuccessState &&
                    FavouriteCubit.get(context).favouriteCategory.isNotEmpty) {
                  FavouriteCubit.get(context).getFavouritePlaces(
                      categoryId:
                          FavouriteCubit.get(context).favouriteCategory[0].id!);
                }
              },
              builder: (context, state) {
                return ConditionalBuilder(
                    condition: state is! GetFavouriteCategoryLoadingState,
                    builder: (context) => Container(
                          width: w,
                          height: h,
                          padding: EdgeInsets.symmetric(
                              vertical: h * 0.01, horizontal: w * 0.035),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: h * 0.08,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    LocaleKeys.Favourites.tr(),
                                    style: headingStyle.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: w * 0.06),
                                  ),
                                ),
                                SizedBox(
                                  height: h * 0.03,
                                ),
                                Center(
                                  child: (FavouriteCubit.get(context)
                                          .favouriteCategory
                                          .isNotEmpty)
                                      ? Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          height: h * 0.08,
                                          padding:
                                              EdgeInsets.only(top: h * 0.02),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(w * 0.08),
                                            boxShadow: const [
                                              BoxShadow(
                                                  offset: Offset(0, 3),
                                                  color:
                                                      MyColors.backgroundColor,
                                                  spreadRadius: 3,
                                                  blurRadius: 3)
                                            ],
                                          ),
                                          child: Center(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: List.generate(
                                                  FavouriteCubit.get(context)
                                                      .favouriteCategory
                                                      .length,
                                                  (index) => buildDot(
                                                      index: index,
                                                      categoryId: FavouriteCubit
                                                              .get(context)
                                                          .favouriteCategory[
                                                              index]
                                                          .id!,
                                                      h: h,
                                                      w: w,
                                                      text: FavouriteCubit.get(
                                                              context)
                                                          .favouriteCategory[
                                                              index]
                                                          .nameEN!),
                                                  growable: true),
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),
                                ),
                                SizedBox(
                                  height: h * 0.03,
                                ),
                                SizedBox(
                                  width: w,
                                  height: h * 0.63,
                                  child: BlocConsumer<FavouriteCubit,
                                      FavouriteState>(
                                    listener: (context, state) {},
                                    builder: (context, state) {
                                      return (FavouriteCubit.get(context)
                                              .favouritePlaces
                                              .isNotEmpty)
                                          ? PageView.builder(
                                              controller: pageController,
                                              itemCount:
                                                  FavouriteCubit.get(context)
                                                      .favouriteCategory
                                                      .length,
                                              onPageChanged: (val) {
                                                setState(() {
                                                  currentIndex = val;
                                                });
                                              },
                                              itemBuilder: (context, index) {
                                                return ConditionalBuilder(
                                                    condition: state
                                                        is! GetFavouritePlacesLoadingState,
                                                    builder: (context) =>
                                                        ListView.separated(
                                                            shrinkWrap: true,
                                                            primary: true,
                                                            itemBuilder:
                                                                (context,
                                                                        index) =>
                                                                    InkWell(
                                                                      child: favouriteCard(
                                                                          placeId: FavouriteCubit.get(context)
                                                                              .favouritePlaces[
                                                                                  index]
                                                                              .id!,
                                                                          address: FavouriteCubit.get(context)
                                                                              .favouritePlaces[
                                                                                  index]
                                                                              .addressEN!,
                                                                          categoryId: FavouriteCubit.get(context)
                                                                              .favouritePlaces[
                                                                                  index]
                                                                              .categoryID!,
                                                                          name: FavouriteCubit.get(context)
                                                                              .favouritePlaces[
                                                                                  index]
                                                                              .nameEN!,
                                                                          w: w,
                                                                          h: h,
                                                                          rate: FavouriteCubit.get(context)
                                                                              .favouritePlaces[index]
                                                                              .rate!),
                                                                      onTap:
                                                                          () {
                                                                        HomeCubit.get(context).getPlaceDetail(
                                                                            id: FavouriteCubit.get(context).favouritePlaces[index].id!.toString(),
                                                                            context: context);
                                                                      },
                                                                    ),
                                                            separatorBuilder:
                                                                (context,
                                                                        index) =>
                                                                    SizedBox(
                                                                      height: h *
                                                                          0.03,
                                                                    ),
                                                            itemCount: FavouriteCubit
                                                                    .get(
                                                                        context)
                                                                .favouritePlaces
                                                                .length),
                                                    fallback: (context) =>
                                                        Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: MyColors
                                                                .mainColor,
                                                          ),
                                                        ));
                                              })
                                          : Center(
                                              child: Text(
                                                "No places here  ",
                                                style: headingStyle.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: w * 0.05),
                                              ),
                                            );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    fallback: (context) => Center(
                          child: CircularProgressIndicator(
                            color: MyColors.mainColor,
                          ),
                        ));
              },
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "you must login first ",
                    style: headingStyle.copyWith(
                        fontWeight: FontWeight.bold, fontSize: w * 0.05),
                  ),
                ),
              ],
            ),
    );
  }

  AnimatedContainer buildDot(
      {required int index,
      required int categoryId,
      required double h,
      required double w,
      required String text}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: w * 0.01),
      child: InkWell(
        onTap: () {
          pageController.animateToPage(index,
              duration: const Duration(microseconds: 500),
              curve: Curves.fastOutSlowIn);
          FavouriteCubit.get(context)
              .getFavouritePlaces(categoryId: categoryId);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                text,
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
