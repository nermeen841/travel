// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/constants/network_services.dart';
import '../../models/GetCategoriesModel.dart';
import '../../network/dio/dio_helper.dart';
import 'categories_states.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());

  static CategoriesCubit get(context) => BlocProvider.of(context);
  //
  CategoryModel categoryModel = CategoryModel();

  List category = [];

  getCategory() async {
    category = [];
    emit(GetCategoriesLoadingState());
    DioHelper.getData(
      url: VIewMoreCategories,
    ).then((value) {
      for (var item in value.data) {
        categoryModel = CategoryModel.fromJson(item);
        category.add(categoryModel);
      }
      print(value.data);
      print(' categoryModelSuccesssssssssssssssssssssssssssssssssssssssssssss');
      emit(GetCategoriesSuccessState());
      return category;
    }).catchError((error) {
      emit(GetCategoriesErrorState(error.toString()));
      print(" errorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr" + error.toString());
    });
  }
}
