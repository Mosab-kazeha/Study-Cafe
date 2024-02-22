// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class LoadingLogin extends LoginState {}

// ignore: must_be_immutable
class SuccessToLogin extends LoginState {
  PlaceModel place;
  SuccessToLogin({required this.place});
}
// ignore: must_be_immutable
class ErrorinLogin extends LoginState {
  ErrorModel error;
  ErrorinLogin({required this.error});
}
