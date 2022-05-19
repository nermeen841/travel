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

class GetHomeCategoryLoadingState extends HomeState {}

class GetHomeCategorySuccessState extends HomeState {}

class GetHomeCategoryErrorState extends HomeState {
  final String error;
  GetHomeCategoryErrorState(this.error);
}

class AddRReviewLoadingState extends HomeState {}

class AddRReviewSuccessState extends HomeState {}

class AddRReviewErrorState extends HomeState {
  final String error;
  AddRReviewErrorState(this.error);
}

class GetReviewLoadingState extends HomeState {}

class GetReviewSuccessState extends HomeState {}

class GetReviewErrorState extends HomeState {
  final String error;
  GetReviewErrorState(this.error);
}
