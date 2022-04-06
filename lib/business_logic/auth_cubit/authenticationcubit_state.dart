part of 'authenticationcubit_cubit.dart';

@immutable
abstract class AuthenticationcubitState {}

class AuthenticationcubitInitial extends AuthenticationcubitState {}

class LoginLoadingState extends AuthenticationcubitState {}

class LoginSuccessState extends AuthenticationcubitState {}

class LoginErrorState extends AuthenticationcubitState {
  final String error;
  LoginErrorState(this.error);
}

class RegisterLoadingState extends AuthenticationcubitState {}

class RegisterSuccessState extends AuthenticationcubitState {}

class RegisterErrorState extends AuthenticationcubitState {
  final String error;
  RegisterErrorState(this.error);
}

class GetGovernoratesLoadingState extends AuthenticationcubitState {}

class GetGovernoratesSuccessState extends AuthenticationcubitState {}

class GetGovernoratesErrorState extends AuthenticationcubitState {
  final String error;
  GetGovernoratesErrorState(this.error);
}

class GetCitiesLoadingState extends AuthenticationcubitState {}

class GetCitiesSuccessState extends AuthenticationcubitState {}

class GetCitiesErrorState extends AuthenticationcubitState {
  final String error;
  GetCitiesErrorState(this.error);
}
