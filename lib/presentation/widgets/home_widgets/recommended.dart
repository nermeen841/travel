import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/business_logic/home_cubit/home_cubit.dart';
import 'package:travel/business_logic/home_cubit/home_states.dart';
import 'package:travel/constants/colors.dart';
import 'package:travel/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../generated/locale_keys.dart';

class RecommendedSection extends StatefulWidget {
  const RecommendedSection({Key? key}) : super(key: key);

  @override
  _RecommendedSectionState createState() => _RecommendedSectionState();
}

class _RecommendedSectionState extends State<RecommendedSection> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! RecommendedLoadingState,
          builder: (context) => SizedBox(
            height: h * 0.21,
            child: (HomeCubit.get(context).recommended.isNotEmpty)
                ? ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            HomeCubit.get(context).getPlaceDetail(
                                context: context,
                                id: HomeCubit.get(context)
                                    .recommended[index]
                                    .id
                                    .toString());

                            HomeCubit.get(context).getReviews(
                                id: HomeCubit.get(context)
                                    .recommended[index]
                                    .id!);
                          },
                          child: Container(
                            margin: EdgeInsets.all(w * 0.015),
                            width: w * 0.4,
                            height: h * 0.15,
                            decoration: BoxDecoration(
                              color: MyColors.backgroundColor,
                              borderRadius: BorderRadius.circular(w * 0.05),
                              boxShadow: const [
                                BoxShadow(
                                    offset: Offset(0, 3),
                                    color: MyColors.backgroundColor,
                                    spreadRadius: 3,
                                    blurRadius: 3)
                              ],
                              image: const DecorationImage(
                                  image: NetworkImage(
                                      "https://img.freepik.com/free-photo/egyptian-desert-design_1048-1862.jpg?w=740"),
                                  fit: BoxFit.cover),
                            ),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: h * 0.13,
                                  ),
                                  child: Container(
                                    width: w * 0.4,
                                    height: h * 0.15,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(w * 0.05),
                                      gradient: LinearGradient(
                                        end: Alignment.topCenter,
                                        begin: Alignment.bottomCenter,
                                        colors: [
                                          const Color(0xff3A0CA3)
                                              .withOpacity(0.99),
                                          Colors.transparent,
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: h * 0.12,
                                      left: w * 0.02,
                                      right: w * 0.02),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          (prefs.getString('lang') == 'en')
                                              ? HomeCubit.get(context)
                                                  .recommended[index]
                                                  .nameEN
                                                  .toString()
                                              : HomeCubit.get(context)
                                                  .recommended[index]
                                                  .nameAR
                                                  .toString(),
                                          style: headingStyle.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.location_on_outlined,
                                                  color: Colors.white,
                                                  size: w * 0.035,
                                                ),
                                                (HomeCubit.get(context)
                                                            .recommended[index]
                                                            .city ==
                                                        null)
                                                    ? Text(
                                                        "Cairo",
                                                        style: headingStyle
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .white),
                                                      )
                                                    : HomeCubit.get(context)
                                                        .recommended[index]
                                                        .city
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  HomeCubit.get(context)
                                                      .recommended[index]
                                                      .rate
                                                      .toString(),
                                                  style: headingStyle.copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white),
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.white,
                                                  size: w * 0.035,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    itemCount: HomeCubit.get(context).recommended.length)
                : Center(
                    child: Text(
                      LocaleKeys.NO_PLACES.tr(),
                      style: headingStyle.copyWith(
                          fontWeight: FontWeight.w500, fontSize: w * 0.04),
                    ),
                  ),
          ),
          // ignore: prefer_const_constructors
          fallback: (context) => Center(
              child: CircularProgressIndicator(
            color: MyColors.mainColor,
          )),
        );
      },
    );
  }
}
