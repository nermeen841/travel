// ignore_for_file: unused_local_variable, avoid_print, avoid_function_literals_in_foreach_calls, unnecessary_null_comparison

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel/constants/colors.dart';
import 'package:travel/constants/constants.dart';
import 'package:travel/constants/network_services.dart';
import 'package:travel/generated/locale_keys.dart';
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
    final int cityID = preferences.getInt('city_id') ?? 0;
    String errorData = '';
    emit(RegisterLoadingState());
    try {
      var body = jsonEncode(<String, dynamic>{
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phone": phone,
        'dob': "1995/1/14",
        "password": password,
        "confirmPassword": confirmPassword,
        "cityID": cityID,
      });
      Map<String, String> headers = {
        'Content-Type': 'application/json',
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
        // encoding: Encoding.getByName('utf-8'),
      );
      print(response.body);

      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        prefs.setString('email', data['user']['email'].toString());
        prefs.setString('phoneNumber', data['user']['phoneNumber'].toString());
        prefs.setString('userId', data['user']['id'].toString());
        prefs.setString('userAddress', "");
        prefs.setString('dateofbirth', "");
        prefs.setString('firstName', data['user']['firstName'].toString());
        prefs.setString('lastName', data['user']['lastName'].toString());
        prefs.setString("user_token", data['token']);
        prefs.setString('user_image', data['user']['avatar']);
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

  /////////////////////////////////////////////////////////////////////////////

  Future<void> resetPasswordToken(
      {required String email, required context}) async {
    prefs.setString('email', email);
    emit(ResetPassordTokenLoadingState());
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        "Accept": "text/plain"
      };
      final body = jsonEncode({"username": email});
      var response = await http.post(
        Uri.parse(RESET_PASS_TOKEN),
        body: body,
        headers: headers,
        encoding: Encoding.getByName('utf-8'),
      );
      var data = jsonDecode(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        prefs.setString('pass_token', data['token']);
        emit(ResetPassordTokenSuccessState());
      } else if (response.statusCode == 400) {
        print(response.body);
      } else if (response.statusCode == 404) {
        print(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              LocaleKeys.LOGIN_ERROR.tr(),
              style: const TextStyle(
                  color: Colors.white, fontFamily: 'Poppins', fontSize: 15),
            ),
            backgroundColor: Colors.black,
          ),
        );
      }
    } catch (e) {
      emit(ResetPassordTokenErrorState(e.toString()));
      print("reset token error : " + e.toString());
    }
  }

////////////////////////////////////////////////////////////////////////

  Future<void> resetPassword({
    required String newPassword,
    required String confirmNewPassword,
    required context,
  }) async {
    final String email = prefs.getString("email").toString();
    final String token = prefs.getString("pass_token").toString();
    emit(ResetPasswordLoadingState());
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        "Accept": "text/plain"
      };
      final body = jsonEncode({
        "username": email,
        "newPassword": newPassword,
        "confirmNewPassword": confirmNewPassword,
        "token": token,
      });
      var response = await http.post(
        Uri.parse(RESET_PASS),
        body: body,
        headers: headers,
        encoding: Encoding.getByName('utf-8'),
      );
      var data = jsonDecode(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Password Updated Successfully',
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Poppins', fontSize: 15),
            ),
            backgroundColor: Colors.black,
          ),
        );
        emit(ResetPasswordSuccessState());
      } else if (response.statusCode == 400) {
        print(response.body);
      } else if (response.statusCode == 404) {
        print(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "please try again later",
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Poppins', fontSize: 15),
            ),
            backgroundColor: Colors.black,
          ),
        );
      }
    } catch (e) {
      emit(ResetPasswordErrorState(e.toString()));
      print("reset token error : " + e.toString());
    }
  }

  //////////////////////////////////////////////////////////////////

  Future<void> changePassword({
    required String newPassword,
    required String email,
    required String currentPassword,
    required String confirmNewPassword,
    required context,
  }) async {
    String errorData = '';
    emit(ChangePasswordLoadingState());
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        "username": email,
        "currentPassword": currentPassword,
        "newPassword": newPassword,
        "confirmNewPassword": confirmNewPassword,
      });
      var response = await http.post(
        Uri.parse(CHANGE_PASS),
        body: body,
        headers: headers,
        encoding: Encoding.getByName('utf-8'),
      );
      var data = jsonDecode(response.body);
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Password Updated Successfully',
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Poppins', fontSize: 15),
            ),
            backgroundColor: Colors.black,
          ),
        );
        emit(ChangePasswordSuccessState());
      } else if (response.statusCode == 500) {
        data.forEach((element) {
          errorData += element['description'] + '\n';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "old password is  " + errorData,
                style: const TextStyle(
                    color: Colors.white, fontFamily: 'Poppins', fontSize: 15),
              ),
              backgroundColor: Colors.black,
            ),
          );
        });
      } else if (response.statusCode == 404) {
        print(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "email doesn't connect with account",
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Poppins', fontSize: 15),
            ),
            backgroundColor: Colors.black,
          ),
        );
      }
    } catch (e) {
      emit(ChangePasswordErrorState(e.toString()));
      print("change password error : " + e.toString());
    }
  }

//////////////////////////////////////////////////////////////////////////////

  Future<void> updateProfile({
    required String email,
    required String firstName,
    required String phone,
    required String image,
    required String lastName,
    required String address,
    String? birthDate,
    required context,
    required double w,
    required userId,
  }) async {
    final String token = prefs.getString("user_token") ?? "";
    final int cityID = prefs.getInt('city_id')!;
    emit(UpdateProfileLoadingState());

    try {
      Map<String, String> headers = {
        "Authorization": "Bearer $token",
      };
      FormData formData = FormData.fromMap({
        "avatar": await MultipartFile.fromFile(image),
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phone": phone,
        'dob': (birthDate != null) ? birthDate : "",
        "cityID": cityID,
      });

      Response response = await Dio().post(EDIT_USER_PROFILE,
          data: formData, options: Options(headers: headers));
      if (response.statusCode == 200) {
        print(response.data);
        if (response.data['status'] == "Success") {
          Fluttertoast.showToast(
              msg: LocaleKeys.UPDATE_PROFILE.tr(),
              gravity: ToastGravity.TOP,
              backgroundColor: MyColors.mainColor,
              toastLength: Toast.LENGTH_LONG,
              textColor: Colors.white);
          prefs.setString('email', email);
          prefs.setString('phoneNumber', phone);
          prefs.setString('userId', userId);
          prefs.setString('userAddress', address);
          prefs.setString('dateofbirth', birthDate.toString());
          prefs.setString('firstName', firstName);
          prefs.setString('lastName', lastName);
          prefs.setString('user_image', image);

          emit(UpdateProfileSuccessState());
        }

        emit(UpdateProfileSuccessState());
      } else if (response.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              response.data['message'],
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontSize: w * 0.04),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      print(error.toString());
      emit(UpdateProfileErrorState(error.toString()));
    }
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> googleSignUp(BuildContext context) async {
    emit(GoogleAuthniticationLoadingState());
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);

        // Getting users credential
        UserCredential result = await auth.signInWithCredential(authCredential);
        User? user = result.user;

        if (result != null) {
          print('sssssssssssssssssssssssssssssssssssssssss');
          print('gggggggggggggggggggggggg  : ' +
              result.user!.email!.split('@')[0].toString());
          prefs.setString('email', result.user!.email!);
          prefs.setString(
              'firstName', result.user!.email!.split('@')[0].toString());
          prefs.setString('userAddress', "");
          prefs.setString('dateofbirth', "");
          prefs.setString('lastName', "");

          emit(GoogleAuthniticationSuccessState());
        } else {
          print('fffffffffffffffffffffffffffffffffffff');
        }
      }
    } catch (e) {
      print(e.toString());
      emit(GoogleAuthniticationErrorState(e.toString()));
    }
  }
}
