import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:study_cafe/model/error_model.dart';
import 'package:study_cafe/model/list_mode.dart';
import 'package:study_cafe/model/model.dart';
import 'package:study_cafe/model/room_model.dart';
import 'package:study_cafe/service/room_service.dart';

part 'room_event.dart';
part 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  RoomBloc() : super(RoomInitial()) {
    on<GetRooms>((event, emit) async {
      emit(LoadingRoom());
      Model roomData = await RoomService().showRooms();
      if (roomData is ListModel) {
        emit(SuccessToGetRoom(rooms: roomData));
      } else {
        emit(ErrorInGettingRoom(error: roomData as ErrorModel));
      }
    });

    //!//! when will data caming we will not be in SuccessToGetRoom
    on<AddNewRoom>((event, emit) async {
      emit(LoadingRoom());
      Model roomData = await RoomService().addNewRoom(room: event.room);
      if (roomData is RoomModel) {
        emit(SuccessToAddRoom(room: roomData));
        RoomBloc().add(GetRooms());
        /*Model roomsData = await RoomService().showRooms();
        if (roomsData is ListModel) {
          emit(SuccessToGetRoom(rooms: roomsData));
        } else {
          emit(ErrorInGettingRoom(error: roomData as ErrorModel));
        } */
      } else {
        emit(ErrorInGettingRoom(error: roomData as ErrorModel));
      }
    });
  }
}
