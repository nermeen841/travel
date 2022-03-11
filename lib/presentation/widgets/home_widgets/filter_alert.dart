import 'package:flutter/material.dart';
import 'package:travel/constants/colors.dart';
import 'package:travel/presentation/screens/filter_result/filter_result.dart';

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
                  "Where to go",
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
                  hintText: "Place",
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Categories",
                    style: headingStyle.copyWith(
                        color: MyColors.mainColor,
                        fontWeight: FontWeight.w400,
                        fontSize: w * 0.04),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: MyColors.mainColor,
                  ),
                ],
              ),
              Divider(
                color: MyColors.mainColor,
              ),
              SizedBox(
                height: h * 0.05,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Gevoernanate",
                    style: headingStyle.copyWith(
                        color: MyColors.mainColor,
                        fontWeight: FontWeight.w400,
                        fontSize: w * 0.04),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: MyColors.mainColor,
                  ),
                ],
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
                  Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const FilterResultScreen()));
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
                            "search",
                            style: headingStyle.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: w * 0.014,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MapTrackScreen())),
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
