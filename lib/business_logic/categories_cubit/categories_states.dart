
abstract class CategoriesState {}

class CategoriesInitial extends CategoriesState {}

class GetCategoriesLoadingState extends CategoriesState {}
class GetCategoriesSuccessState extends CategoriesState {}
class GetCategoriesErrorState extends CategoriesState {
  final String error;
  GetCategoriesErrorState(this.error);
}
