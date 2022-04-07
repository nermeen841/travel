abstract class HomeState {}

class HomeInitial extends HomeState {}

class RecommendedLoadingState extends HomeState {}

class RecommendedSuccessState extends HomeState {}

class RecommendedErrorState extends HomeState {
  final String error;
  RecommendedErrorState(this.error);
}


class PlaceDetailLoadingState extends HomeState {}

class PlaceDetailSuccessState extends HomeState {}

class PlaceDetailErrorState extends HomeState {
  final String error;
  PlaceDetailErrorState(this.error);
}




