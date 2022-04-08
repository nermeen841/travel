// ignore_for_file: avoid_print

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel/business_logic/appCubit/app_Cubit.dart';
import 'package:travel/business_logic/appCubit/app_states.dart';
import '../../../business_logic/auth_cubit/authenticationcubit_cubit.dart';
import '../../../generated/locale_keys.g.dart';

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
            text: LocaleKeys.Privacy_Policy.tr(),
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 16,
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
}) async {
  await showMenu(
    context: context,
    position:
        const RelativeRect.fromLTRB(300, 380, 0, 100), //Map((String choice)
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
    position:
        const RelativeRect.fromLTRB(0, 380, 300, 100), //Map((String choice)
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
                preferences.setString('city_id', choice.id.toString());
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
