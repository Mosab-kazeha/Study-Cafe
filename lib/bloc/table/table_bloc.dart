import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:study_cafe/model/error_model.dart';
import 'package:study_cafe/model/list_mode.dart';
import 'package:study_cafe/model/model.dart';
import 'package:study_cafe/model/table_model.dart';
import 'package:study_cafe/service/table_service.dart';

part 'table_event.dart';
part 'table_state.dart';

class TableBloc extends Bloc<TableEvent, TableState> {
  TableBloc() : super(TableInitial()) {
    on<GetTables>((event, emit) async {
      emit(LoadingTable());
      Model tables = await TableService().showAllTable(roomId: event.roomId);
      if (tables is ListModel) {
        emit(SuccessToGetTable(tables: tables));
      } else {
        emit(ErrorInGettingTable(error: tables as ErrorModel));
      }
    });

    on<AddNewTable>((event, emit) async {
      emit(LoadingTable());
      Model table = await TableService().addNewTable(table: event.table);
      if (table is TableModel) {
        emit(SuccessToAddNewTable(table: table));
       // TableBloc().add(GetTables(roomId: ));
      } else {
        emit(ErrorInGettingTable(error: table as ErrorModel));
      }
    });
  }
}
