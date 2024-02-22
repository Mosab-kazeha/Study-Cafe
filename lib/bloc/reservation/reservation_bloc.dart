import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:study_cafe/model/error_model.dart';
import 'package:study_cafe/model/list_mode.dart';
import 'package:study_cafe/model/model.dart';
import 'package:study_cafe/model/reservation_model.dart';
import 'package:study_cafe/service/reservation_service.dart';

part 'reservation_event.dart';
part 'reservation_state.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  ReservationBloc() : super(ReservationInitial()) {
    on<GetAllReservation>((event, emit) async {
      emit(LoadingReservation());
      Model reservation = await ReservationServies().showAllReservation();

      if (reservation is ListModel) {
        emit(SuccessToGetReservation(reservation: reservation));
      } else {
        emit(ErrorWithReservation(error: reservation as ErrorModel));
      }
    });

    on<AddNewReservation>((event, emit) async {
      emit(LoadingReservation());
      Model reserve = await ReservationServies().reserveTable(
          reserve: event.reserve, reservetionId: event.reservetionId);
      if (reserve is ReservationModel) {
        emit(SuccessInAddReservation(reserve: reserve));
      } else {
        emit(ErrorWithReservation(error: reserve as ErrorModel));
      }
    });

    on<DeleteTheReservation>((event, emit) async {
      emit(LoadingReservation());
      Model reserve = await ReservationServies()
          .deletYourReservation(reservetionId: event.reservetionId);
      if (reserve is ReservationModel) {
        emit(SuccessInDeleteReservation(reserve: reserve));
        ReservationBloc().add(GetAllReservation());
      } else {
        emit(ErrorWithReservation(error: reserve as ErrorModel));
      }
    });
  }
}
