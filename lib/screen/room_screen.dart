import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_cafe/bloc/room/room_bloc.dart';
import 'package:study_cafe/model/room_model.dart';
import 'package:study_cafe/screen/reservation_screen.dart';
import 'package:study_cafe/screen/tables_screen.dart';

// ignore: must_be_immutable
class RoomScreen extends StatelessWidget {
  RoomScreen({required this.placeId, super.key});

  TextEditingController chairsNumberController = TextEditingController();
  String placeId;
  TextEditingController categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => RoomBloc()..add(GetRooms()),
        child: Scaffold(
          backgroundColor: const Color(0xFFE2E2ED),
          body: BlocConsumer<RoomBloc, RoomState>(
            listener: (context, state) {
              if (state is SuccessToAddRoom) {
                context.read<RoomBloc>().add(GetRooms());
              }
            },
            builder: (context, state) {
              if (state is SuccessToGetRoom) {
                List<RoomModel> room = state.rooms.model as List<RoomModel>;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Choose The Room",
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TableScreen(
                                        roomId: room[index].id.toString(),
                                      ),
                                    ),
                                  );
                                },
                                leading: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: ShapeDecoration(
                                    color:
                                        const Color.fromARGB(255, 54, 217, 217),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(11),
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.home_filled,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                title: Text(
                                  room[index].id.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: room[index].categoryId == 1
                                    ? const Text('eating')
                                    : room[index].categoryId == 2
                                        ? const Text('smpking')
                                        : const Text('quiet'),
                              ),
                            ),
                          );
                        },
                        itemCount: room.length,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Add a New Room"),
                                      content: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                4,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.2,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                                "Category type \n 1 for eating \t 2 for smpking\n 3 for quiet"),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.2,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  16,
                                              decoration: ShapeDecoration(
                                                color: const Color(0xFFE2E2ED),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                              child: TextField(
                                                controller: categoryController,
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: "Room Category",
                                                  border: OutlineInputBorder(),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  64,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.2,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  16,
                                              decoration: ShapeDecoration(
                                                color: const Color(0xFFE2E2ED),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                              child: TextField(
                                                controller:
                                                    chairsNumberController,
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: "Max Chairs Number",
                                                  border: OutlineInputBorder(),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        InkWell(
                                          onTap: () {
                                            if (categoryController
                                                    .text.isNotEmpty &&
                                                chairsNumberController
                                                    .text.isNotEmpty) {
                                              context.read<RoomBloc>().add(
                                                    AddNewRoom(
                                                      room: RoomModel(
                                                        maxNumOfChairs: int.parse(
                                                            categoryController
                                                                .text),
                                                        status: 4,
                                                        placeId:
                                                            int.parse(placeId),
                                                        categoryId: int.parse(
                                                            categoryController
                                                                .text),
                                                      ),
                                                    ),
                                                  );
                                              Navigator.pop(context);
                                            }
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.3,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                16,
                                            decoration: ShapeDecoration(
                                              color: const Color(0xFF525298),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(32),
                                              ),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                "Done",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 1.5,
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
                          Tooltip(
                            message: "Show Teservation",
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ReservationScreen(
                                        placeId: placeId,
                                      ),
                                    ));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.height / 16,
                                height: MediaQuery.of(context).size.height / 16,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFF525298),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.wysiwyg_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else if (state is ErrorInGettingRoom) {
                return Center(
                  child: ElevatedButton(
                      onPressed: () {
                        RoomBloc().add(GetRooms());
                      },
                      child: const Text("Try Agin")),
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
