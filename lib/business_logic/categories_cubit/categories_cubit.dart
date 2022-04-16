// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/constants/network_services.dart';
import '../../models/GetCategoriesModel.dart';
import 'categories_states.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());

  static CategoriesCubit get(context) => BlocProvider.of(context);

  CategoryModel categoryModel = CategoryModel();

  List<CategoryModel> category = [];

  Future<List<CategoryModel>> getCategory() async {
    category = [];
    emit(GetCategoriesLoadingState());
    try {
      var response = await http.get(Uri.parse(BaseUrl + VIewMoreCategories));
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        for (var item in data) {
          categoryModel = CategoryModel.fromJson(item);
          category.add(categoryModel);
        }
        emit(GetCategoriesSuccessState());
        return category;
      }
    } catch (e) {
      emit(GetCategoriesErrorState(e.toString()));
      print(" errorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr" + e.toString());
    }
    return category;
  }
}
