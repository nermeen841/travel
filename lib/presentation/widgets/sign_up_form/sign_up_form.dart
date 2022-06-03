// ignore_for_file: avoid_print

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel/constants/constants.dart';
import '../../../business_logic/auth_cubit/authenticationcubit_cubit.dart';
import '../../../business_logic/database_helper/app_Cubit.dart';
import '../../../business_logic/database_helper/app_states.dart';
import '../../../generated/locale_keys.dart';

Widget richTextInSignUp() => RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: LocaleKeys.Terms.tr(),
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xff3A0CA3),
            ),
          ),
          TextSpan(
            text: LocaleKeys.AND.tr(),
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              color: Color(0xff3A0CA3),
            ),
          ),
          TextSpan(
            text: ' ' + LocaleKeys.Privacy_Policy.tr(),
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Color(0xff3A0CA3),
            ),
          ),
        ],
      ),
    );

void showGoverMenu({
  required context,
  required double w,
  required List list,
  required RelativeRect positioned,
}) async {
  await showMenu(
    context: context,
    position: positioned, //Map((String choice)
    items: list.map((choice) {
      return PopupMenuItem(
        value: choice.nameEN.toString(),
        child: BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            return InkWell(
              onTap: () async {
                AuthenticationcubitCubit.get(context)
                    .getCity(governorateID: choice.id.toString());
                prefs.setString('governorate_nameEN', choice.nameEN.toString());
                prefs.setString('governorate_nameAR', choice.nameAR.toString());

                AppCubit.get(context).governorate = choice.nameEN.toString();
                AppCubit.get(context)
                    .choseGovernorates(choice.nameEN.toString());
                Navigator.pop(context);
                print("------------------------------------------" +
                    choice.nameEN.toString());
              },
              child: Text(
                choice.nameEN.toString(),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: w * 0.04,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Tajawal'),
              ),
            );
          },
        ),
      );
    }).toList(),
    elevation: 8.0,
  );
}

void showCitysMenu({
  required context,
  required double w,
  required List list,
}) async {
  await showMenu(
    context: context,
    position: const RelativeRect.fromLTRB(300, 380, 0, 100),

    //Map((String choice)
    items: list.map((choice) {
      return PopupMenuItem(
        value: choice.nameEN.toString(),
        child: BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            return InkWell(
              onTap: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                preferences.setInt('city_id', choice.id);
                preferences.setString('city_nameEN', choice.nameEN.toString());
                preferences.setString('city_nameAR', choice.nameAR.toString());

                AppCubit.get(context).city = choice.nameEN.toString();
                AppCubit.get(context).choseCity(choice.nameEN.toString());
                Navigator.pop(context);
                print("------------------------------------------" +
                    choice.nameEN.toString());
              },
              child: Text(
                choice.nameEN.toString(),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: w * 0.04,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Tajawal'),
              ),
            );
          },
        ),
      );
    }).toList(),
    elevation: 8.0,
  );
}

void showCitySearchMenu({
  required context,
  required double w,
  required RelativeRect positioned,
  required List list,
}) async {
  await showMenu(
    context: context,
    position: positioned,
    //Map((String choice)
    items: list.map((choice) {
      return PopupMenuItem(
        value: choice.nameEN.toString(),
        child: BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            return InkWell(
              onTap: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                preferences.setInt('city_id_search', choice.id);
                AppCubit.get(context).city = choice.nameEN.toString();
                AppCubit.get(context).choseCity(choice.nameEN.toString());
                Navigator.pop(context);
                print("------------------------------------------" +
                    choice.nameEN.toString());
              },
              child: Text(
                choice.nameEN.toString(),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: w * 0.04,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Tajawal'),
              ),
            );
          },
        ),
      );
    }).toList(),
    elevation: 8.0,
  );
}

void showCategoryMenu({
  required context,
  required double w,
  required RelativeRect positioned,
  required List list,
}) async {
  await showMenu(
    context: context,
    position: positioned,
    //Map((String choice)
    items: list.map((choice) {
      return PopupMenuItem(
        value: choice.nameEN.toString(),
        child: BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            return InkWell(
              onTap: () {
                prefs.setInt("search_cat", choice.id);
                AppCubit.get(context).categorySelected =
                    choice.nameEN.toString();
                AppCubit.get(context).chooseCategory(choice.nameEN.toString());
                Navigator.pop(context);
              },
              child: Text(
                choice.nameEN.toString(),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: w * 0.04,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Tajawal'),
              ),
            );
          },
        ),
      );
    }).toList(),
    elevation: 8.0,
  );
}
