import 'package:study_cafe/model/error_model.dart';
import 'package:study_cafe/model/model.dart';
import 'package:study_cafe/model/place_model.dart';
import 'package:study_cafe/service/service.dart';

class PlaceService extends Service {
  Future<Model> getPlace({required String placeId}) async {
    try {
      response = await dio.get(url + place + placeId);
      if (response.statusCode == 200) {
        dynamic temp = response.data;
        PlaceModel place = PlaceModel.fromMap(temp);

        return place;
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
