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
