// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'reservation_bloc.dart';

@immutable
sealed class ReservationEvent {}

class GetAllReservation extends ReservationEvent {}

// ignore: must_be_immutable
class DeleteTheReservation extends ReservationEvent {
  String reservetionId;
  DeleteTheReservation({required this.reservetionId});
}

// ignore: must_be_immutable
class AddNewReservation extends ReservationEvent {
  String reservetionId;
  ReservationModel reserve;
  AddNewReservation({required this.reservetionId, required this.reserve});
}
