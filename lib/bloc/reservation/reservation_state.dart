// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'reservation_bloc.dart';

@immutable
sealed class ReservationState {}

final class ReservationInitial extends ReservationState {}

class LoadingReservation extends ReservationState {}

// ignore: must_be_immutable
class SuccessToGetReservation extends ReservationState {
  ListModel reservation;
  SuccessToGetReservation({required this.reservation});
}

// ignore: must_be_immutable
class SuccessInAddReservation extends ReservationState {
  ReservationModel reserve;
  SuccessInAddReservation({required this.reserve});
}

// ignore: must_be_immutable
class SuccessInDeleteReservation extends ReservationState {
  ReservationModel reserve;
  SuccessInDeleteReservation({required this.reserve});
}

// ignore: must_be_immutable
class ErrorWithReservation extends ReservationState {
  ErrorModel error;
  ErrorWithReservation({required this.error});
}
