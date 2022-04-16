// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/network_services.dart';
import '../../models/PlaceDetailModel.dart';
import '../../models/RecommendedModel.dart';
import '../../presentation/screens/detail/detail.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  RecommendedModel recommendedModel = RecommendedModel();

  List<RecommendedModel> recommended = [];

  Future<List<RecommendedModel>> getRecommended() async {
    recommended = [];
    emit(RecommendedLoadingState());
    try {
      var response =
          await http.get(Uri.parse(BaseUrl + GetRecommendedPlacesInHome));
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        for (var item in data) {
          recommendedModel = RecommendedModel.fromJson(item);
          recommended.add(recommendedModel);
        }

        emit(RecommendedSuccessState());
        return recommended;
      }
    } catch (e) {
      emit(RecommendedErrorState(e.toString()));
      print("errroro : " + e.toString());
    }
    return recommended;
  }

  PlaceDetailModel placeDetailModel = PlaceDetailModel();

  Future<PlaceDetailModel> getPlaceDetail(
      {required String id, required context}) async {
    emit(PlaceDetailLoadingState());
    try {
      var response =
          await http.get(Uri.parse(BaseUrl + GetPlaceInDetails + "?id=$id"));
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        placeDetailModel = PlaceDetailModel.fromJson(data);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const DetailScreen()));
        emit(PlaceDetailSuccessState());
        return placeDetailModel;
      }
    } catch (error) {
      print(error.toString());
      emit(PlaceDetailErrorState(error.toString()));
    }
    return placeDetailModel;
  }
}
