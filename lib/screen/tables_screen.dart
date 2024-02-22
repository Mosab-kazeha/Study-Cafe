import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_cafe/bloc/reservation/reservation_bloc.dart';
import 'package:study_cafe/bloc/table/table_bloc.dart';
import 'package:study_cafe/model/reservation_model.dart';
import 'package:study_cafe/model/table_model.dart';

// ignore: must_be_immutable
class TableScreen extends StatelessWidget {
  TableScreen({required this.roomId, super.key});

  String roomId;
  DateTime now = DateTime.now();
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TableBloc()..add(GetTables(roomId: roomId)),
          ),
          BlocProvider(
            create: (context) => ReservationBloc(),
          ),
        ],
        child: Scaffold(
          backgroundColor: const Color(0xFFE2E2ED),
          body: BlocConsumer<TableBloc, TableState>(
            listener: (context, state) {
              if (state is SuccessInAddReservation) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  duration: Duration(seconds: 10),
                  content: Text('Reserve Done Successfully'),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ));
                context.read<TableBloc>().add(GetTables(roomId: roomId));
              }
              if (state is ErrorWithReservation) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  duration: Duration(seconds: 10),
                  content: Text('Sorry Thir an Error With Reservation'),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                ));
                context.read<TableBloc>().add(GetTables(roomId: roomId));
              }
              if (state is SuccessToAddNewTable) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  duration: Duration(seconds: 10),
                  content: Text('Add New Table Successfully'),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ));
                context.read<TableBloc>().add(GetTables(roomId: roomId));
              }
            },
            builder: (context, state) {
              if (state is SuccessToGetTable) {
                List<TableModel> table = state.tables.model as List<TableModel>;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Choose The Table",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 22, vertical: 10),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 10,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                              child: ListTile(
                                onTap: () {
                                  context.read<ReservationBloc>().add(
                                        AddNewReservation(
                                          reservetionId:
                                              table[index].id.toString(),
                                          reserve: ReservationModel(
                                            type: 2,
                                            time:
                                                "${now.hour}:+${now.minute}:+${now.second}",
                                            numOfSeats: 5,
                                            roomId: int.tryParse(roomId),
                                            tableId: table[index].id,
                                            periodOfReservations: 1,
                                          ),
                                        ),
                                      );
                                },
                                leading: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: ShapeDecoration(
                                    color: const Color.fromARGB(
                                        255, 148, 113, 246),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(11),
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.weekend,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                title: Text(
                                  "Table ${table[index].id.toString()}",
                                  style:const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: const Text('Table category'),
                              ),
                            ),
                          );
                        },
                        itemCount: table.length,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: InkWell(
                        onTap: () {
                          context.read<TableBloc>().add(
                                AddNewTable(
                                  table: TableModel(
                                      status: 4,
                                      availableSeats: [true, true, true, true],
                                      categoryId: 1,
                                      roomId: int.parse(roomId),
                                      message: 'message'),
                                ),
                              );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.3,
                          height: MediaQuery.of(context).size.height / 16,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF525298),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              "Add New Table ",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else if (state is ErrorInGettingTable) {
                return Center(
                  child: ElevatedButton(
                    onPressed: () {
                      TableBloc().add(GetTables(roomId: roomId));
                    },
                    child:const Text("Try Agin"),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
