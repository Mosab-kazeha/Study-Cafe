import 'package:study_cafe/model/error_model.dart';
import 'package:study_cafe/model/list_mode.dart';
import 'package:study_cafe/model/model.dart';
import 'package:study_cafe/model/reservation_model.dart';
import 'package:study_cafe/service/service.dart';

class ReservationServies extends Service {
  Future<Model> showAllReservation() async {
    try {
      response = await dio.get(url + showReservation);
      if (response.statusCode == 200) {
        dynamic temp = response.data;
        List<ReservationModel> result = List.generate(
          temp.length,
          (index) => ReservationModel.fromMap(temp[index]),
        );
        ListModel reservatin = ListModel(model: result);
        return reservatin;
      } else {
        return ErrorModel(
          error: response.statusMessage.toString(),
        );
      }
    } catch (e) {
      return ErrorModel(error: e.toString());
    }
  }

  Future<Model> reserveTable(
      {required ReservationModel reserve,
      required String reservetionId}) async {
    try {
      response = await dio.post(url + addReservation + reservetionId,
          data: reserve.toJson());
      if (response.statusCode == 200) {
        dynamic temp = response.data;
        ReservationModel reserve = ReservationModel.fromMap(temp);
        return reserve;
      } else {
        return ErrorModel(
          error: response.statusMessage.toString(),
        );
      }
    } catch (e) {
      return ErrorModel(error: e.toString());
    }
  }

  Future<Model> deletYourReservation({required String reservetionId}) async {
    try {
      response = await dio.delete(url + deletReservation + reservetionId);
      if (response.statusCode == 200) {
        dynamic temp = response.data;
        ReservationModel reserve =
            ReservationModel(successReservationDelet: temp);
        return reserve;
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
