import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/business_logic/search_cubit/search_cubit.dart';
import 'package:travel/constants/colors.dart';
import 'package:travel/generated/locale_keys.g.dart';

import '../../layout/bottomNave.dart';

TextEditingController search = TextEditingController();

searchButton({
  required double w,
  required double h,
}) {
  return BlocConsumer<SearchCubit, SearchState>(
    listener: (context, state) {},
    builder: (context, state) {
      return Material(
        elevation: 5,
        shadowColor: MyColors.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(w * 0.5),
        ),
        child: TextFormField(
          keyboardType: TextInputType.text,
          controller: search,
          cursorColor: MyColors.unslectedIconColor,
          onChanged: (value) {
            SearchCubit.get(context).searchResult(place: search.text);
          },
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: LocaleKeys.Where_are.tr(),
            hintStyle:
                headingStyle.copyWith(color: MyColors.unslectedIconColor),
            prefixIcon: InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BottomNave(index: 1)),
                      (route) => false);
                },
                child: Image.asset("assets/icons/search.png")),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(w * 0.5),
              borderSide: const BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(w * 0.5),
              borderSide: const BorderSide(color: Colors.white),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(w * 0.5),
              borderSide: const BorderSide(color: Colors.white),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(w * 0.5),
              borderSide: const BorderSide(color: Colors.white),
            ),
          ),
        ),
      );
    },
  );
}

////////////////////////////////////////////////////////////////////////////////////////////

headerText(
    {required double h, required double w, required VoidCallback press}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        LocaleKeys.Last_Searched.tr(),
        style: headingStyle.copyWith(
            fontWeight: FontWeight.bold, fontSize: w * 0.05),
      ),
      InkWell(
        onTap: press,
        child: Text(
          LocaleKeys.Clear.tr(),
          style: headingStyle.copyWith(
              color: MyColors.unslectedIconColor,
              fontWeight: FontWeight.w500,
              fontSize: w * 0.04),
        ),
      ),
    ],
  );
}
