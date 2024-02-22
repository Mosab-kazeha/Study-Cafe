import 'dart:convert';

import 'package:study_cafe/model/model.dart';

class TableModel extends Model {
  int? id;
  int status;
  List<bool> availableSeats;
  int categoryId;
  int roomId;
  dynamic message;

  TableModel({
    this.id,
    required this.status,
    required this.availableSeats,
    required this.categoryId,
    required this.roomId,
    required this.message,
  });

  TableModel copyWith({
    int? id,
    int? status,
    List<bool>? availableSeats,
    int? categoryId,
    int? roomId,
    dynamic message,
  }) =>
      TableModel(
        id: id ?? this.id,
        status: status ?? this.status,
        availableSeats: availableSeats ?? this.availableSeats,
        categoryId: categoryId ?? this.categoryId,
        roomId: roomId ?? this.roomId,
        message: message ?? this.message,
      );

  factory TableModel.fromJson(String str) =>
      TableModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TableModel.fromMap(Map<String, dynamic> json) => TableModel(
        id: json["id"],
        status: json["status"],
        availableSeats: List<bool>.from(json["available_seats"].map((x) => x)),
        categoryId: json["category_id"],
        roomId: json["room_id"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "status": status,
        "available_seats": List<dynamic>.from(availableSeats.map((x) => x)),
        "category_id": categoryId,
        "room_id": roomId,
        "message": message,
      };
}
