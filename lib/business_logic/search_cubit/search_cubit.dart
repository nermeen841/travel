import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../constants/network_services.dart';
import '../../models/CitySearchModel.dart';
import 'package:http/http.dart' as http;

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  //  static HomeCubit get(context) => BlocProvider.of(context);

  static SearchCubit get(context) => BlocProvider.of(context);

  CitySearchModel citySearchModel = CitySearchModel();

  List<CitySearchModel> citySearch = [];

  Future<List<CitySearchModel>> getcitySearch() async {
    citySearch = [];
    emit(CitySearchLoadingState());
    try {
      var response = await http.get(Uri.parse(GetCitySearch));
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        for (var item in data) {
          print(data);
          print(
              'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
          citySearchModel = CitySearchModel.fromJson(item);
          citySearch.add(citySearchModel);
        }

        emit(CitySearchSuccessState());
        return citySearch;
      }
    } catch (e) {
      emit(CitySearchErrorState(e.toString()));
      print("errroro : " + e.toString());
    }
    return citySearch;
  }
}
