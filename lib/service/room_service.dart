import 'package:study_cafe/model/error_model.dart';
import 'package:study_cafe/model/list_mode.dart';
import 'package:study_cafe/model/model.dart';
import 'package:study_cafe/model/room_model.dart';
import 'package:study_cafe/service/service.dart';

class RoomService extends Service {
  Future<Model> showRooms() async {
    try {
      print('start get data');
      response = await dio.get(url + showAllRoom);
      print("finish get data");
      print(response);
      if (response.statusCode == 200) {
        print("data is here");
        dynamic temp = response.data;
        List<RoomModel> result = List.generate(
          temp.length,
          (index) => RoomModel.fromMap(temp[index]),
        );
        ListModel room = ListModel(model: result);
        return room;
      } else {
        return ErrorModel(
          error: response.statusMessage.toString(),
        );
      }
    } catch (e) {
      return ErrorModel(error: e.toString());
    }
  }

  Future<Model> addNewRoom({required RoomModel room}) async {
    try {
      response = await dio.post(url + addRoom, data: room.toJson());
      if (response.statusCode == 200) {
        dynamic temp = response.data;
        RoomModel room = RoomModel.fromMap(temp);
        return room;
      } else {
        return ErrorModel(
          error: response.statusMessage.toString(),
        );
      }
    } catch (e) {
      return ErrorModel(error: e.toString());
    }
  }
}
