// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'table_bloc.dart';

@immutable
sealed class TableState {}

final class TableInitial extends TableState {}

class LoadingTable extends TableState {}

// ignore: must_be_immutable
class SuccessToGetTable extends TableState {
  ListModel tables;
  SuccessToGetTable({required this.tables});
}

// ignore: must_be_immutable
class ErrorInGettingTable extends TableState {
  ErrorModel error;
  ErrorInGettingTable({required this.error});
}

// ignore: must_be_immutable
class SuccessToAddNewTable extends TableState {
  TableModel table;
  SuccessToAddNewTable({required this.table});
}
