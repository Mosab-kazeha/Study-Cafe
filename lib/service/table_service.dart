import 'package:study_cafe/model/error_model.dart';
import 'package:study_cafe/model/list_mode.dart';
import 'package:study_cafe/model/model.dart';
import 'package:study_cafe/model/table_model.dart';
import 'package:study_cafe/service/service.dart';

class TableService extends Service {
  Future<Model> showAllTable({required String roomId}) async {
    try {
      response = await dio.get(url + showTables + roomId);
      if (response.statusCode == 200) {
        dynamic temp = response.data;
        List<TableModel> result = List.generate(
          temp.length,
          (index) => TableModel.fromMap(temp[index]),
        );
        ListModel table = ListModel(model: result);
        return table;
      } else {
        return ErrorModel(
          error: response.statusMessage.toString(),
        );
      }
    } catch (e) {
      return ErrorModel(error: e.toString());
    }
  }

  Future<Model> addNewTable({required TableModel table}) async {
    try {
      response = await dio.post(url + addTable, data: table.toJson());
      if (response.statusCode == 200) {
        dynamic temp = response.data;
        TableModel table = TableModel.fromMap(temp);
        return table;
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
