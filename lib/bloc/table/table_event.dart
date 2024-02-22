// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'table_bloc.dart';

@immutable
sealed class TableEvent {}

// ignore: must_be_immutable
class GetTables extends TableEvent {
  String roomId;
  GetTables({required this.roomId});
}

// ignore: must_be_immutable
class AddNewTable extends TableEvent {
  TableModel table;
  AddNewTable({required this.table});
}
