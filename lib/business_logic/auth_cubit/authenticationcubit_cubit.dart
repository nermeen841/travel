// ignore_for_file: unused_local_variable, avoid_print, avoid_function_literals_in_foreach_calls
import 'package:easy_localization/easy_localization.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel/business_logic/database_helper/database_cubit.dart';
import 'package:travel/constants/network_services.dart';
import 'package:travel/generated/locale_keys.g.dart';
import 'package:travel/models/GetGovernoratesModel.dart';
import '../../models/CityModel.dart';
part 'authenticationcubit_state.dart';

class AuthenticationcubitCubit extends Cubit<AuthenticationcubitState> {
  AuthenticationcubitCubit() : super(AuthenticationcubitInitial());

  static AuthenticationcubitCubit get(context) => BlocProvider.of(context);

  GetGovernoratesModel getGovernoratesModel = GetGovernoratesModel();

  List<GetGovernoratesModel> governorate = [];

  Future<List<GetGovernoratesModel>> getGovernorates(
      {required String countryID}) async {
    governorate = [];
    emit(GetGovernoratesLoadingState());
    try {
      var response = await http
          .get(Uri.parse(BaseUrl + GetGovernorates + "?countryID=$countryID"));
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        for (var item in data) {
          getGovernoratesModel = GetGovernoratesModel.fromJson(item);
          governorate.add(getGovernoratesModel);
        }
        print(data);
        emit(GetGovernoratesSuccessState());
        return governorate;
      }
    } catch (error) {
      emit(GetGovernoratesErrorState(error.toString()));
      print(" errorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr" + error.toString());
    }
    return governorate;
  }

///////////////////////////////////////////////////////////////////////
  CityModel cityModel = CityModel();
  List<CityModel> city = [];

  Future<List<CityModel>> getCity({required String governorateID}) async {
    city = [];
    emit(GetCitiesLoadingState());
    try {
      var response = await http.get(
          Uri.parse(BaseUrl + GetCities + "?governorateID=$governorateID"));
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        for (var item in data) {
          cityModel = CityModel.fromJson(item);
          city.add(cityModel);
        }
        print(data);
        emit(GetCitiesSuccessState());
        print(city[0].nameAR);
        return city;
      }
    } catch (error) {
      emit(GetCitiesErrorState(error.toString()));
      print(" errorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr" + error.toString());
    }
    return city;
  }

/////////////////////////////////////////////////////////////////////////////////
  Future<void> register({
    required String email,
    required String firstName,
    required String password,
    required String phone,
    required String lastName,
    required String confirmPassword,
    required context,
    required double w,
  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final String cityID = preferences.getString('city_id') ?? '';
    String errorData = '';
    emit(RegisterLoadingState());
    try {
      var dob = <String, int>{"year": 0, "month": 0, "day": 0, "dayOfWeek": 0};

      var body = jsonEncode(<String, dynamic>{
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phone": phone,
        'dob': dob,
        "password": password,
        "confirmPassword": confirmPassword,
        "cityID": cityID,
      });
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        "Accept": "text/plain"
      };
      var response = await http.post(
        Uri.parse(BaseUrl + Register),
        body: body,
        headers: headers,
        encoding: Encoding.getByName('utf-8'),
      );
      print(response.statusCode);
      print(response.body);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print(data);
        emit(RegisterSuccessState());
      } else if (response.statusCode == 400) {
        data.forEach((element) {
          errorData += element + '\n';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              errorData,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontSize: w * 0.04),
            ),
            backgroundColor: Colors.black,
          ),
        );
      }
    } catch (error) {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    }
  }

//////////////////////////////////////////////////////////////////////////////////
  Future<void> login(
      {required String email,
      required String password,
      required context,
      required double w}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    emit(LoginLoadingState());
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        "Accept": "text/plain"
      };
      final formData = jsonEncode({"email": email, "password": password});
      var response = await http.post(
        Uri.parse(BaseUrl + Login),
        body: formData,
        headers: headers,
        encoding: Encoding.getByName('utf-8'),
      );
      print(response.body);

      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        DataBaseCubit.get(context).inserttoDatabase(
          email: data['user']['email'],
          userPhone: data['user']['phoneNumber'],
          userId: data['user']['id'],
          firstName: data['user']['firstName'],
          lastName: data['user']['lastName'],
          image: data['user']['avatar'],
        );
        prefs.setString("user_token", data['token']);
        prefs.setBool("is_login", true);
        print(response.body);
        emit(LoginSuccessState());
      } else if (response.statusCode == 401) {
        print("response.body");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              LocaleKeys.LOGIN_ERROR.tr(),
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontSize: w * 0.04),
            ),
            backgroundColor: Colors.black,
          ),
        );
      }
    } catch (error) {
      emit(LoginErrorState(error.toString()));
      print("login error : " + error.toString());
    }
  }
}
