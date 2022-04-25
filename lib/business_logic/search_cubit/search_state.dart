part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

//CitySearchModel
class SearchInitial extends SearchState {}

class CitySearchLoadingState extends SearchState {}

class CitySearchSuccessState extends SearchState {}

class CitySearchErrorState extends SearchState {
  final String error;

  CitySearchErrorState(this.error);
}

class GetSearchLoadingState extends SearchState {}

class GetSearchSuccessState extends SearchState {}

class GetSearchErrorState extends SearchState {
  final String error;

  GetSearchErrorState(this.error);
}
