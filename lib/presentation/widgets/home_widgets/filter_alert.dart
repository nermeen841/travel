import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/business_logic/categories_cubit/categories_cubit.dart';
import 'package:travel/business_logic/categories_cubit/categories_states.dart';
import 'package:travel/constants/colors.dart';
import 'package:travel/constants/constants.dart';
import 'package:travel/generated/locale_keys.dart';
import 'package:travel/presentation/screens/layout/bottomNave.dart';
import 'package:travel/presentation/widgets/sign_up_form/sign_up_form.dart';
import '../../../business_logic/database_helper/app_Cubit.dart';
import '../../../business_logic/database_helper/app_states.dart';
import '../../../business_logic/search_cubit/search_cubit.dart';
import '../../screens/map/map_track.dart';

TextEditingController filter = TextEditingController();

filterAlert({required double h, required double w, required context}) {
  showDialog(
      barrierDismissible: true,
      useSafeArea: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(w * 0.05),
          ),
          title: Column(
            children: [
              Center(
                child: Text(
                  LocaleKeys.Where_to_go.tr(),
                  style: headingStyle.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: h * 0.03,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: filter,
                textAlign: TextAlign.start,
                cursorColor: MyColors.unslectedIconColor,
                decoration: InputDecoration(
                  hintText: LocaleKeys.Place.tr(),
                  helperStyle: headingStyle.copyWith(
                      color: MyColors.mainColor, fontWeight: FontWeight.w400),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: MyColors.mainColor),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: MyColors.mainColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: MyColors.mainColor),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: MyColors.mainColor),
                  ),
                  focusedErrorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: MyColors.mainColor),
                  ),
                  disabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: MyColors.mainColor),
                  ),
                ),
              ),
              SizedBox(
                height: h * 0.05,
              ),
              BlocConsumer<CategoriesCubit, CategoriesState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return InkWell(
                    onTap: () {
                      showCategoryMenu(
                          context: context,
                          w: w,
                          positioned:
                              const RelativeRect.fromLTRB(170, 470, 50, 100),
                          list: CategoriesCubit.get(context).category);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BlocConsumer<AppCubit, AppState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            return Text(
                              (AppCubit.get(context).categorySelected != null)
                                  ? AppCubit.get(context).categorySelected!
                                  : LocaleKeys.Categories.tr(),
                              style: headingStyle.copyWith(
                                  color: MyColors.mainColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: w * 0.04),
                            );
                          },
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: MyColors.mainColor,
                        ),
                      ],
                    ),
                  );
                },
              ),
              Divider(
                color: MyColors.mainColor,
              ),
              SizedBox(
                height: h * 0.05,
              ),
              BlocConsumer<SearchCubit, SearchState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return InkWell(
                    onTap: () {
                      showCitySearchMenu(
                          positioned:
                              const RelativeRect.fromLTRB(170, 470, 50, 100),
                          context: context,
                          w: w,
                          list: SearchCubit.get(context).citySearch);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BlocConsumer<AppCubit, AppState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            return (AppCubit.get(context).city != null)
                                ? Text(
                                    AppCubit.get(context).city!,
                                    style: headingStyle.copyWith(
                                        color: MyColors.mainColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: w * 0.04),
                                  )
                                : Text(
                                    LocaleKeys.City.tr(),
                                    style: headingStyle.copyWith(
                                        color: MyColors.mainColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: w * 0.04),
                                  );
                          },
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: MyColors.mainColor,
                        ),
                      ],
                    ),
                  );
                },
              ),
              Divider(
                color: MyColors.mainColor,
              ),
              // SizedBox(
              //   height: h * 0.05,
              // ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocConsumer<SearchCubit, SearchState>(
                    listener: (context, state) {
                      if (state is GetSearchSuccessState) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: ((context) =>
                                  const BottomNave(index: 1))),
                        );
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    builder: (context, state) {
                      return Center(
                        child: InkWell(
                          onTap: () {
                            final int cityId =
                                prefs.getInt("city_id_search") ?? 0;
                            final int catId = prefs.getInt("search_cat") ?? 0;
                            SearchCubit.get(context).searchResult(
                                place: filter.text,
                                cityId: cityId,
                                categoryId: catId);
                          },
                          child: Container(
                            width: w * 0.5,
                            height: h * 0.07,
                            decoration: BoxDecoration(
                              color: MyColors.mainColor,
                              borderRadius: BorderRadius.circular(w * 0.1),
                              boxShadow: const [
                                BoxShadow(
                                    offset: Offset(0, 3),
                                    color: MyColors.backgroundColor,
                                    spreadRadius: 3,
                                    blurRadius: 3)
                              ],
                            ),
                            child: Center(
                              child: Text(
                                LocaleKeys.Search.tr(),
                                style: headingStyle.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    width: w * 0.014,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MapTrackScreen(
                                    latitude: "",
                                    logtitude: "",
                                  ))),
                      child: Container(
                        width: w * 0.13,
                        height: h * 0.13,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 3),
                                color: MyColors.backgroundColor,
                                spreadRadius: 3,
                                blurRadius: 3),
                          ],
                        ),
                        child: Icon(
                          Icons.explore_outlined,
                          color: MyColors.mainColor,
                          size: 30,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      });
}
