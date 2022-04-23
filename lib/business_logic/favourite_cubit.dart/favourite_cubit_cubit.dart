// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:travel/constants/colors.dart';
import 'package:travel/constants/network_services.dart';

import '../../constants/constants.dart';
part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteInitial());

  static FavouriteCubit get(context) => BlocProvider.of(context);

  Map<int, bool> isFavourite = {};

  Future<void> addToFavourite({required int placeID}) async {
    emit(AddToFavouriteLoadingState());
    final String token = prefs.getString("user_token")!;
    try {
      Map<String, String> headers = {"Authorization": "Bearer $token"};
      var response = await http.get(
          Uri.parse(AddToFavourite + "?placeID=$placeID"),
          headers: headers);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['status'] == "Success") {
        isFavourite[placeID] = true;
        Fluttertoast.showToast(
            msg: data['message'].toString(),
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: MyColors.mainColor,
            textColor: Colors.white,
            fontSize: 16.0);
        emit(AddToFavouriteSuccessState());
      }
    } catch (error) {
      emit(AddToFavouriteErrorState(error.toString()));
      print(error.toString());
    }
  }

  Future<void> removeFromFavourite({required int placeID}) async {
    emit(RemoveFromFavouriteLoadingState());
    final String token = prefs.getString("user_token")!;
    try {
      Map<String, String> headers = {"Authorization": "Bearer $token"};
      var response = await http.get(
          Uri.parse(RemoveFromFavourite + "?placeID=$placeID"),
          headers: headers);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['status'] == "Success") {
        isFavourite[placeID] = false;
        Fluttertoast.showToast(
            msg: data['message'].toString(),
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: MyColors.mainColor,
            textColor: Colors.white,
            fontSize: 16.0);
        emit(RemoveFromFavouriteSuccessState());
      }
    } catch (error) {
      emit(RemoveFromFavouriteErrorState(error.toString()));
      print(error.toString());
    }
  }
}
