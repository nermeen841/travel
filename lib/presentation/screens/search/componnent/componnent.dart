import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:travel/constants/colors.dart';
import 'package:travel/generated/locale_keys.g.dart';

searchButton({required double w, required double h}) {
  return Material(
    elevation: 5,
    shadowColor: MyColors.backgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(w * 0.5),
    ),
    child: TextFormField(
      keyboardType: TextInputType.text,
      cursorColor: MyColors.unslectedIconColor,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: LocaleKeys.Where_are.tr(),
        hintStyle: headingStyle.copyWith(color: MyColors.unslectedIconColor),
        prefixIcon: Image.asset("assets/icons/search.png"),
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
