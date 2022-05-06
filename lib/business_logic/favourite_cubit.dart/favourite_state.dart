part of 'favourite_cubit_cubit.dart';

@immutable
abstract class FavouriteState {}

class FavouriteInitial extends FavouriteState {}

class AddToFavouriteLoadingState extends FavouriteState {}

class AddToFavouriteSuccessState extends FavouriteState {}

class AddToFavouriteErrorState extends FavouriteState {
  final String error;

  AddToFavouriteErrorState(this.error);
}

class RemoveFromFavouriteLoadingState extends FavouriteState {}

class RemoveFromFavouriteSuccessState extends FavouriteState {}

class RemoveFromFavouriteErrorState extends FavouriteState {
  final String error;

  RemoveFromFavouriteErrorState(this.error);
}

class GetFavouriteCategoryLoadingState extends FavouriteState {}

class GetFavouriteCategorySuccessState extends FavouriteState {}

class GetFavouriteCategoryErrorState extends FavouriteState {
  final String error;

  GetFavouriteCategoryErrorState(this.error);
}

class GetFavouritePlacesLoadingState extends FavouriteState {}

class GetFavouritePlacesSuccessState extends FavouriteState {}

class GetFavouritePlacesErrorState extends FavouriteState {
  final String error;

  GetFavouritePlacesErrorState(this.error);
}
