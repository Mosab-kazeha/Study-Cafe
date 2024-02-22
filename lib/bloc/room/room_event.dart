// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'room_bloc.dart';

@immutable
sealed class RoomEvent {}

class GetRooms extends RoomEvent {}

// ignore: must_be_immutable
class AddNewRoom extends RoomEvent {
  RoomModel room;
  AddNewRoom({required this.room});
}
