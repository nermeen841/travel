// ignore_for_file: file_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:travel/constants/colors.dart';
import 'package:travel/generated/locale_keys.dart';
import 'package:travel/presentation/widgets/notification_widgets/notification_widgets.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Align(
          alignment: Alignment.topRight,
          child: SingleChildScrollView(
            child: Column(
              // padding: EdgeInsets.only(left: w * 0.12),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: h * 0.085,
                ),
                Text(
                  LocaleKeys.Notifications.tr(),
                  style: TextStyle(
                      color: MyColors.mainColor,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins'),
                ),
                SizedBox(
                  height: h * 0.03,
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: w * 0.05,
                  ),
                  height: h * 0.8,
                  width: w * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(w * 0.14))),
                  child: ListView(
                    shrinkWrap: true,
                    primary: true,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '    ${LocaleKeys.NEW.tr()}',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff3A0CA3),
                        ),
                      ),
                      SizedBox(
                        height: h * 0.02,
                      ),
                      ListView.separated(
                          primary: false,
                          shrinkWrap: true,
                          itemBuilder: (context, index) =>
                              buildNotificationCard(
                                  context: context,
                                  name: 'Emul',
                                  massage:
                                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit ut aliquam...',
                                  colorCard: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 3,
                                      spreadRadius: 3,
                                      offset:
                                          const Offset(0, 4), // Shadow position
                                    ),
                                  ]),
                          separatorBuilder: (context, index) => SizedBox(
                                height: h * 0.02,
                              ),
                          itemCount: 4),
                      SizedBox(
                        height: h * 0.03,
                      ),
                      Text(
                        '    ${LocaleKeys.Earlier.tr()}',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff3A0CA3),
                        ),
                      ),
                      SizedBox(
                        height: h * 0.02,
                      ),
                      ListView.separated(
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (context, index) =>
                              buildNotificationCard(
                                context: context,
                                name: 'Emul',
                                massage:
                                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit ut aliquam...',
                                colorCard: const Color(0xffC3C3C3),
                              ),
                          separatorBuilder: (context, index) => SizedBox(
                                height: h * 0.02,
                              ),
                          itemCount: 8),
                      SizedBox(
                        height: h * 0.02,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
