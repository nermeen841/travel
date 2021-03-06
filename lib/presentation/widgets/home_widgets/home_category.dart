import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/business_logic/categories_cubit/categories_states.dart';
import 'package:travel/business_logic/home_cubit/home_cubit.dart';
import 'package:travel/constants/colors.dart';
import 'package:travel/constants/constants.dart';
import 'package:travel/generated/locale_keys.dart';
import 'package:travel/presentation/screens/home/componnent/componnent.dart';
import '../../../business_logic/categories_cubit/categories_cubit.dart';
import '../../../business_logic/home_cubit/home_states.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeCategory extends StatefulWidget {
  const HomeCategory({Key? key}) : super(key: key);

  @override
  _HomeCategoryState createState() => _HomeCategoryState();
}

class _HomeCategoryState extends State<HomeCategory> {
  late PageController pageController;
  @override
  void initState() {
    pageController = PageController(initialPage: currentIndex);
    super.initState();
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final homeCategory = HomeCubit.get(context).categoryInHome;
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is GetHomeCategorySuccessState) {
          CategoriesCubit.get(context).getTopCategory(
              categoryID:
                  HomeCubit.get(context).categoryInHome[0].id.toString());
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                  homeCategory.length,
                  (index) => buildDot(
                      categoryID: homeCategory[index].id.toString(),
                      title: (prefs.getString('lang') == 'en')
                          ? homeCategory[index].nameEN.toString()
                          : homeCategory[index].nameAR.toString(),
                      index: index,
                      h: h,
                      w: w),
                  growable: true),
            ),
            Container(
              width: w,
              height: h * 0.2,
              color: Colors.transparent,
              child: PageView.builder(
                itemCount: homeCategory.length,
                controller: pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: w,
                    height: h * 0.2,
                    child: BlocConsumer<CategoriesCubit, CategoriesState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        final toCategory =
                            CategoriesCubit.get(context).topCategory;
                        return (CategoriesCubit.get(context)
                                .topCategory
                                .isNotEmpty)
                            ? ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => InkWell(
                                      onTap: () {
                                        HomeCubit.get(context).getPlaceDetail(
                                            context: context,
                                            id: toCategory[index]
                                                .id
                                                .toString());
                                      },
                                      child: categoryCard(
                                        w: w,
                                        h: h,
                                        address:
                                            (prefs.getString('lang') == 'en')
                                                ? toCategory[index]
                                                    .addressEN
                                                    .toString()
                                                : toCategory[index]
                                                    .addressAR
                                                    .toString(),
                                        name: (prefs.getString('lang') == 'en')
                                            ? toCategory[index]
                                                .nameEN
                                                .toString()
                                            : toCategory[index]
                                                .nameAR
                                                .toString(),
                                        rate: toCategory[index].rate,
                                      ),
                                    ),
                                separatorBuilder: (context, index) => SizedBox(
                                      width: w * 0.025,
                                    ),
                                itemCount: toCategory.length)
                            : Center(
                                child: Text(LocaleKeys.NO_PLACES.tr(),
                                    style: headingStyle.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: w * 0.04)));
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  AnimatedContainer buildDot(
      {required int index,
      required double h,
      required double w,
      required String categoryID,
      required String title}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: w * 0.01),
      child: InkWell(
        onTap: () {
          pageController.animateToPage(index,
              duration: const Duration(microseconds: 500),
              curve: Curves.fastOutSlowIn);
          CategoriesCubit.get(context).getTopCategory(categoryID: categoryID);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                title,
                style: headingStyle.copyWith(
                    fontSize: w * 0.04,
                    fontWeight: (currentIndex == index)
                        ? FontWeight.w600
                        : FontWeight.w400,
                    color: (currentIndex == index)
                        ? MyColors.mainColor
                        : MyColors.unslectedIconColor),
              ),
            ),
            Center(
              child: Container(
                width: w * 0.02,
                height: h * 0.01,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentIndex == index
                        ? MyColors.mainColor
                        : Colors.transparent),
              ),
            )
          ],
        ),
      ),
    );
  }
}
