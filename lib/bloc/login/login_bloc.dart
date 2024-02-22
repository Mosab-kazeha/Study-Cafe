// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:study_cafe/model/error_model.dart';
import 'package:study_cafe/model/model.dart';
import 'package:study_cafe/model/place_model.dart';
import 'package:study_cafe/service/place_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<SingIn>((event, emit) async {
      emit(LoadingLogin());

      Model loginData = await PlaceService().getPlace(placeId: event.placeId);
      if (loginData is PlaceModel) {
        emit(SuccessToLogin(place: loginData));
      } else {
        emit(ErrorinLogin(error: loginData as ErrorModel));
      }
    });
  }
}
