// ignore_for_file: file_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_states.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  String? governorate;
  String? city;

  void choseGovernorates(String value) {
    governorate = value;
    emit(GovernoratesChoseSuccessState());
  }

  void choseCity(String value) {
    city = value;
    emit(CityChoseSuccessState());
  }
}
