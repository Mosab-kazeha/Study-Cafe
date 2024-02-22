import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_cafe/bloc/reservation/reservation_bloc.dart';
import 'package:study_cafe/model/reservation_model.dart';
import 'package:study_cafe/screen/room_screen.dart';

// ignore: must_be_immutable
class ReservationScreen extends StatelessWidget {
  ReservationScreen({required this.placeId, super.key});

  String placeId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => ReservationBloc()..add(GetAllReservation()),
        child: Scaffold(
          backgroundColor: const Color(0xFFE2E2ED),
          body: BlocConsumer<ReservationBloc, ReservationState>(
            listener: (context, state) {
              if (state is SuccessInDeleteReservation) {
                ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                  duration: Duration(seconds: 10),
                  content: Text('Cansel Done Successfully'),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ));
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RoomScreen(
                              placeId: placeId,
                            )));
              }
            },
            builder: (context, state) {
              if (state is SuccessToGetReservation) {
                List<ReservationModel> reservation =
                    state.reservation.model as List<ReservationModel>;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Shoes The Reservation \n To Cansel",
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
                                      DeleteTheReservation(
                                          reservetionId: reservation[index]
                                              .id
                                              .toString()));
                                },
                                leading: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: ShapeDecoration(
                                    color:
                                        const Color.fromARGB(255, 50, 167, 226),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(11),
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.star,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                title: Text(
                                  "Reservation ${reservation[index].id.toString()}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                    "Table ${reservation[index].tableId.toString()}"),
                                trailing:
                                    Text(reservation[index].time.toString()),
                              ),
                            ),
                          );
                        },
                        itemCount: reservation.length,
                      ),
                    ),
                  ],
                );
              } else if (state is ErrorWithReservation) {
                return Center(
                  child: ElevatedButton(
                      onPressed: () {
                        context
                            .read<ReservationBloc>()
                            .add(GetAllReservation());
                      },
                      child: Text("Try Agin")),
                );
              } else {
                return Center(
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
