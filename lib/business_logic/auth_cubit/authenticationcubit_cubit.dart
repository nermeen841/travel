import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:travel/constants/network_services.dart';
import 'package:travel/models/GetGovernoratesModel.dart';
import 'package:travel/network/dio/dio_helper.dart';

import '../../models/CityModel.dart';
part 'authenticationcubit_state.dart';

class AuthenticationcubitCubit extends Cubit<AuthenticationcubitState> {
  AuthenticationcubitCubit() : super(AuthenticationcubitInitial());

  static AuthenticationcubitCubit get(context) => BlocProvider.of(context);

  GetGovernoratesModel getGovernoratesModel = GetGovernoratesModel();

  List governorate = [];

  void getGovernorates({required String countryID}) async {
    governorate = [];
    emit(GetGovernoratesLoadingState());
    DioHelper.getData(url: GetGovernorates, query: {'countryID': countryID})
        .then((value) {
      for (var item in value.data) {
        getGovernoratesModel = GetGovernoratesModel.fromJson(item);
        governorate.add(getGovernoratesModel);
      }

      print(value.data);
      print('Successsssssssssssssssssssssssssssssssssssssssssss');
      emit(GetGovernoratesSuccessState());
      return governorate;
    }).catchError((error) {
      emit(GetGovernoratesErrorState(error.toString()));
      print(" errorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr" + error.toString());
    });
  }


  CityModel cityModel = CityModel();
  List city = [];

   getCity({required String governorateID}) async {
    city = [];
    emit(GetCitiesLoadingState());
    DioHelper.getData(url: GetCities, query: {'governorateID': governorateID})
        .then((value) {
      for (var item in value.data) {
        cityModel = CityModel.fromJson(item);
        city.add(cityModel);
      }

      print(value.data);

      print('Successsssssssssssssssssssssssssssssssssssssssssss111111111111111111111');
      emit(GetCitiesSuccessState());
      print(city[0].nameAR);

      return city;
    }).catchError((error) {
      emit(GetCitiesErrorState(error.toString()));
      print(" errorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr" + error.toString());
    });
  }



}
