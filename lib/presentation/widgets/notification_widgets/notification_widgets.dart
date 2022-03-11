import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildNotificationCard({
  required context,
  required String name,
  required String massage,
  required Color colorCard,
  List<BoxShadow>? boxShadow,
}) {
  double h = MediaQuery.of(context).size.height;
  double w = MediaQuery.of(context).size.width;
  return Container(
    padding: EdgeInsets.symmetric(vertical: h * 0.013, horizontal: w * 0.032),
    margin: EdgeInsets.only(left: w * 0.01),
    height: h * 0.13,
    width: w,
    decoration: BoxDecoration(
        color: colorCard,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
        boxShadow: boxShadow),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hi ' + name + '!',
          style: const TextStyle(
              color: Color(0xff222222),
              fontWeight: FontWeight.w500,
              fontSize: 16,
              fontFamily: 'Poppins'),
        ),
        SizedBox(
          height: h * 0.01,
        ),
        Text(
          massage,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xff686868)),
        ),
      ],
    ),
  );
}
