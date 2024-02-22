// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'room_bloc.dart';

@immutable
sealed class RoomState {}

final class RoomInitial extends RoomState {}

class LoadingRoom extends RoomState {}

// ignore: must_be_immutable
class SuccessToGetRoom extends RoomState {
  ListModel rooms;
  SuccessToGetRoom({required this.rooms});
}

// ignore: must_be_immutable
class ErrorInGettingRoom extends RoomState {
  ErrorModel error;
  ErrorInGettingRoom({required this.error});
}

// ignore: must_be_immutable
class SuccessToAddRoom extends RoomState {
  RoomModel room;
  SuccessToAddRoom({required this.room});
}
