// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/constants.dart';
import '../../constants/network_services.dart';
import '../../models/PlaceDetailModel.dart';
import '../../models/RecommendedModel.dart';
import '../../models/getReviews.dart';
import '../../models/home_category.dart';
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

//////////////////////////////////////////////////////////////////////////////////
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

///////////////////////////////////////////////////////////////////////////
  HomeCategoryModel homeCategory = HomeCategoryModel();
  List<HomeCategoryModel> categoryInHome = [];

  Future<List<HomeCategoryModel>> getHomeCategory() async {
    categoryInHome = [];

    emit(GetHomeCategoryLoadingState());
    try {
      var response = await http.get(Uri.parse(GetTopCategories));
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        for (var item in data) {
          homeCategory = HomeCategoryModel.fromJson(item);
          categoryInHome.add(homeCategory);
        }

        emit(GetHomeCategorySuccessState());
        return categoryInHome;
      }
    } catch (error) {
      print(error.toString());
      emit(GetHomeCategoryErrorState(error.toString()));
    }
    return categoryInHome;
  }

  //////////////////////////////////////////////////////////////////////////////
  Future addReview({
    required String review,
    required int placeID,
    required double rate,
    required context,
  }) async {
    final String token = prefs.getString("user_token") ?? "";
    emit(AddRReviewLoadingState());

    try {
      Map<String, String> headers = {
        "Authorization": "Bearer $token",
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        "placeID": placeID,
        "rate": rate,
        "review": review,
      });
      var response = await http.post(
        Uri.parse(PostReview),
        body: body,
        headers: headers,
      );

      var data = jsonDecode(response.body);

      print(data);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'You Added Review Successfully',
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Poppins', fontSize: 15),
            ),
            backgroundColor: Colors.black,
          ),
        );
        getReviews(id: placeID);
        emit(AddRReviewSuccessState());
      } else if (response.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Please Write Review And Add Rate...',
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Poppins', fontSize: 15),
            ),
            backgroundColor: Colors.black,
          ),
        );
        emit(AddRReviewSuccessState());
      }
    } catch (e) {
      emit(AddRReviewErrorState(e.toString()));
      print(e.toString());
    }
  }
///////////////////////////////////////////////////////////

  GetReviewsModel getReviewsModel = GetReviewsModel();

  List<GetReviewsModel> reviews = [];

  Future<List<GetReviewsModel>> getReviews({required int id}) async {
    reviews = [];
    emit(GetReviewLoadingState());
    try {
      var response =
          await http.get(Uri.parse(GetPlaceReviews + "?placeID=$id"));
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        for (var item in data) {
          getReviewsModel = GetReviewsModel.fromJson(item);
          reviews.add(getReviewsModel);
        }

        emit(GetReviewSuccessState());
        print(data);
        return reviews;
      }
    } catch (e) {
      emit(GetReviewErrorState(e.toString()));
      print("errroro : " + e.toString());
    }
    return reviews;
  }
}
