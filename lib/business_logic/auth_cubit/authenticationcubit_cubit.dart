import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:travel/constants/network_services.dart';
import 'package:travel/models/GetGovernoratesModel.dart';
import 'package:travel/network/dio/dio_helper.dart';

import 'package:http/http.dart' as http;
part 'authenticationcubit_state.dart';

class AuthenticationcubitCubit extends Cubit<AuthenticationcubitState> {
  AuthenticationcubitCubit() : super(AuthenticationcubitInitial());

  static AuthenticationcubitCubit get(context) => BlocProvider.of(context);
//const String GetGovernorates = 'api/Cities/GetGovernorates';

  GetGovernoratesModel getGovernoratesModel = GetGovernoratesModel();

  void getGovernorates({required String countryID}) async {
    // contactModel = ContactModel.fromJson(value.data);
    emit(GetGovernoratesLoadingState());
    try {
      var response =
          await http.get(Uri.parse(BaseUrl + GetGovernorates + "?countryID=1"));
      var data = jsonDecode(response.body);
      getGovernoratesModel = GetGovernoratesModel.fromJson(data);
      print(data);
      print('Successsssssssssssssssssssssssssssssssssssssssssss');
      emit(GetGovernoratesSuccessState());
    } catch (error) {
      emit(GetGovernoratesErrorState(error.toString()));
      print(" errorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr" + error.toString());
    }
    // DioHelper.getData(url: GetGovernorates, query: {'countryID': countryID})
    //     .then((value) {
    //   getGovernoratesModel = GetGovernoratesModel.fromJson(value.data);
    //   print(value.data);
    //   print('Successsssssssssssssssssssssssssssssssssssssssssss');
    //   emit(GetGovernoratesSuccessState());
    // }).catchError((error) {
    //   emit(GetGovernoratesErrorState(error.toString()));
    //   print(" errorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr" + error.toString());
    // });
  }
}
