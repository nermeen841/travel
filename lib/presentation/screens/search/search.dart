import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/business_logic/home_cubit/home_cubit.dart';
import 'package:travel/business_logic/search%20history/search_history_cubit.dart';
import 'package:travel/business_logic/search_cubit/search_cubit.dart';
import 'package:travel/constants/colors.dart';
import 'package:travel/generated/locale_keys.g.dart';
import 'package:travel/presentation/screens/search/componnent/componnent.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isSearching = false;
  String? searching;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: Text(
          LocaleKeys.Search.tr(),
          style: headingStyle.copyWith(
              fontWeight: FontWeight.bold, fontSize: w * 0.06),
        ),
      ),
      body: Container(
        width: w,
        height: h,
        padding:
            EdgeInsets.symmetric(vertical: h * 0.025, horizontal: w * 0.05),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocConsumer<SearchCubit, SearchState>(
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
                      cursorColor: MyColors.unslectedIconColor,
                      onEditingComplete: () {
                        if (searching!.isNotEmpty) {
                          setState(() {
                            isSearching = true;
                          });
                        } else {
                          setState(() {
                            isSearching = false;
                          });
                        }
                      },
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          SearchCubit.get(context).searchData.clear();
                          SearchCubit.get(context).searchResult(place: value);
                          setState(() {
                            isSearching = true;
                            searching = value;
                          });
                        } else {
                          setState(() {
                            isSearching = false;
                          });
                        }
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: LocaleKeys.Where_are.tr(),
                        hintStyle: headingStyle.copyWith(
                            color: MyColors.unslectedIconColor),
                        prefixIcon: InkWell(
                            onTap: () {},
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
              ),
              SizedBox(
                height: h * 0.035,
              ),
              (isSearching)
                  ? Container()
                  : BlocConsumer<SearchHistoryCubit, SearchHistoryState>(
                      builder: (context, state) => headerText(
                          h: h,
                          w: w,
                          press: () {
                            SearchHistoryCubit.get(context)
                                .deleteTableContent();
                          }),
                      listener: (context, state) {}),
              SizedBox(
                height: h * 0.015,
              ),
              SizedBox(
                width: w,
                height: h * 0.7,
                child: (isSearching)
                    ? BlocConsumer<SearchCubit, SearchState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          return ConditionalBuilder(
                            condition: state is! GetSearchLoadingState,
                            builder: (context) => (SearchCubit.get(context)
                                    .searchData
                                    .isNotEmpty)
                                ? GridView.builder(
                                    shrinkWrap: true,
                                    primary: true,
                                    itemCount: SearchCubit.get(context)
                                        .searchData
                                        .length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.8,
                                      mainAxisSpacing: w * 0.07,
                                      crossAxisSpacing: h * 0.03,
                                    ),
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          HomeCubit.get(context).getPlaceDetail(
                                              id: SearchCubit.get(context)
                                                  .searchData[index]
                                                  .id!
                                                  .toString(),
                                              context: context);
                                          if (SearchHistoryCubit.get(context)
                                                          .isEsist[
                                                      SearchCubit.get(context)
                                                          .searchData[index]
                                                          .id] ==
                                                  false ||
                                              SearchHistoryCubit.get(context)
                                                          .isEsist[
                                                      SearchCubit.get(context)
                                                          .searchData[index]
                                                          .id!] ==
                                                  null) {
                                            SearchHistoryCubit.get(context)
                                                .inserttoDatabase(
                                                    placeID:
                                                        SearchCubit.get(context)
                                                            .searchData[index]
                                                            .id!,
                                                    nameEn:
                                                        SearchCubit.get(context)
                                                            .searchData[index]
                                                            .nameEN!,
                                                    nameAr:
                                                        SearchCubit.get(context)
                                                            .searchData[index]
                                                            .nameAR!,
                                                    image: "",
                                                    addressEn:
                                                        SearchCubit.get(context)
                                                            .searchData[index]
                                                            .addressEN!,
                                                    addressAr:
                                                        SearchCubit.get(context)
                                                            .searchData[index]
                                                            .addressAR!);
                                          }
                                        },
                                        child: GridTile(
                                          child: Container(
                                            width: w * 0.4,
                                            height: h * 0.3,
                                            decoration: BoxDecoration(
                                              color: MyColors.backgroundColor,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      w * 0.05),
                                              boxShadow: const [
                                                BoxShadow(
                                                    offset: Offset(0, 3),
                                                    color: MyColors
                                                        .backgroundColor,
                                                    spreadRadius: 3,
                                                    blurRadius: 3),
                                              ],
                                              image: const DecorationImage(
                                                  image: NetworkImage(
                                                      "https://img.freepik.com/free-photo/beautiful-tropical-beach-sea-with-chair-blue-sky_74190-7488.jpg?w=740"),
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                          footer: Container(
                                            // height: h * 0.09,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: w * 0.015,
                                                vertical: h * 0.01),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(w * 0.05),
                                                bottomRight:
                                                    Radius.circular(w * 0.05),
                                              ),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  SearchCubit.get(context)
                                                      .searchData[index]
                                                      .nameEN!,
                                                  style: headingStyle.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                    SearchCubit.get(context)
                                                        .searchData[index]
                                                        .addressEN!,
                                                    style: headingStyle),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : Center(
                                    child: Text(
                                      "no search result",
                                      style: headingStyle.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: w * 0.05),
                                    ),
                                  ),
                            fallback: (context) => Center(
                              child: CircularProgressIndicator(
                                color: MyColors.mainColor,
                              ),
                            ),
                          );
                        },
                      )
                    : BlocConsumer<SearchHistoryCubit, SearchHistoryState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          return GridView.builder(
                            shrinkWrap: true,
                            primary: true,
                            itemCount: SearchHistoryCubit.get(context)
                                .searchHistory
                                .length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.8,
                              mainAxisSpacing: w * 0.07,
                              crossAxisSpacing: h * 0.03,
                            ),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  HomeCubit.get(context).getPlaceDetail(
                                      id: SearchHistoryCubit.get(context)
                                          .searchHistory[index]['placeID']
                                          .toString(),
                                      context: context);
                                },
                                child: GridTile(
                                  child: Container(
                                    width: w * 0.4,
                                    height: h * 0.3,
                                    decoration: BoxDecoration(
                                      color: MyColors.backgroundColor,
                                      borderRadius:
                                          BorderRadius.circular(w * 0.05),
                                      boxShadow: const [
                                        BoxShadow(
                                            offset: Offset(0, 3),
                                            color: MyColors.backgroundColor,
                                            spreadRadius: 3,
                                            blurRadius: 3),
                                      ],
                                      image: const DecorationImage(
                                          image: NetworkImage(
                                              "https://img.freepik.com/free-photo/beautiful-tropical-beach-sea-with-chair-blue-sky_74190-7488.jpg?w=740"),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  footer: Container(
                                    // height: h * 0.09,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: w * 0.015,
                                        vertical: h * 0.01),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(w * 0.05),
                                        bottomRight: Radius.circular(w * 0.05),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          SearchHistoryCubit.get(context)
                                              .searchHistory[index]['nameEn'],
                                          style: headingStyle.copyWith(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            SearchHistoryCubit.get(context)
                                                    .searchHistory[index]
                                                ['addressEn'],
                                            style: headingStyle),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
