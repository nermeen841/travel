// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/network_services.dart';
import '../../models/PlaceDetailModel.dart';
import '../../models/RecommendedModel.dart';
import '../../network/dio/dio_helper.dart';
import '../../presentation/screens/detail/detail.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  RecommendedModel recommendedModel = RecommendedModel();

  List recommended = [];

  getRecommended() async {
    recommended = [];
    emit(RecommendedLoadingState());
    DioHelper.getData(
      url: GetRecommendedPlacesInHome,
    ).then((value) {
      for (var item in value.data) {
        recommendedModel = RecommendedModel.fromJson(item);
        recommended.add(recommendedModel);
      }
      print(value.data);
      print('Successsssssssssssssssssssssssssssssssssssssssssss');
      emit(RecommendedSuccessState());
      return recommended;
    }).catchError((error) {
      emit(RecommendedErrorState(error.toString()));
      print(" errorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr" + error.toString());
    });
  }

  PlaceDetailModel placeDetailModel = PlaceDetailModel();

  getPlaceDetail({required String id, required context}) {
    emit(PlaceDetailLoadingState());
    DioHelper.getData(url: GetPlaceInDetails, query: {
      'id': id,
    }).then((value) {
      placeDetailModel = PlaceDetailModel.fromJson(value.data);
      print(value.data);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const DetailScreen()));
      emit(PlaceDetailSuccessState());
      return placeDetailModel;
    }).catchError((error) {
      print(error.toString());
      emit(PlaceDetailErrorState(error.toString()));
    });
  }
}
