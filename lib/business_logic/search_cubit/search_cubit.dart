// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:travel/constants/constants.dart';
import '../../constants/network_services.dart';
import '../../models/CitySearchModel.dart';
import 'package:http/http.dart' as http;

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

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

  Future<List<CitySearchModel>> searchData(
      {required String place, int? categoryId, String? cityId}) async {
    emit(GetSearchLoadingState());
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      var body = jsonEncode(<String, dynamic>{
        "place": place,
        "catID": categoryId ?? 0,
        "lastName": cityId ?? 0,
      });
      var response = await http.post(
        Uri.parse(SEARCH_DATA),
        body: body,
        headers: headers,
        encoding: Encoding.getByName('utf-8'),
      );
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print(data);
        emit(GetSearchSuccessState());
        return citySearch;
      }
    } catch (e) {
      emit(GetSearchErrorState(e.toString()));
      print("errroro : " + e.toString());
    }
    return citySearch;
  }
}
