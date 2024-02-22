import 'dart:convert';

import 'package:study_cafe/model/model.dart';

class ReservationModel extends Model {
  int? id;
  int? type;
  String? time;
  int? numOfSeats;
  int? roomId;
  int? tableId;
  int? periodOfReservations;
  String? successReservationDelet;

  ReservationModel(
      {this.id,
      this.type,
      this.time,
      this.numOfSeats,
      this.roomId,
      this.tableId,
      this.periodOfReservations,
      this.successReservationDelet});

  ReservationModel copyWith({
    int? id,
    int? type,
    String? time,
    int? numOfSeats,
    int? roomId,
    int? tableId,
    int? periodOfReservations,
  }) =>
      ReservationModel(
        id: id ?? this.id,
        type: type ?? this.type,
        time: time ?? this.time,
        numOfSeats: numOfSeats ?? this.numOfSeats,
        roomId: roomId ?? this.roomId,
        tableId: tableId ?? this.tableId,
        periodOfReservations: periodOfReservations ?? this.periodOfReservations,
      );

  factory ReservationModel.fromJson(String str) =>
      ReservationModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ReservationModel.fromMap(Map<String, dynamic> json) =>
      ReservationModel(
        id: json["id"],
        type: json["type"],
        time: json["time"],
        numOfSeats: json["num_of_seats"],
        roomId: json["room_id"],
        tableId: json["table_id"],
        periodOfReservations: json["period_of_reservations"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "type": type,
        "time": time,
        "num_of_seats": numOfSeats,
        "room_id": roomId,
        "table_id": tableId,
        "period_of_reservations": periodOfReservations,
      };
}
