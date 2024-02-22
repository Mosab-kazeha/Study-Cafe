import 'dart:convert';

import 'package:study_cafe/model/model.dart';

class RoomModel extends Model {
  int? id;
  int maxNumOfChairs;
  int status;
  int placeId;
  int categoryId;

  RoomModel({
    this.id,
    required this.maxNumOfChairs,
    required this.status,
    required this.placeId,
    required this.categoryId,
  });

  RoomModel copyWith({
    int? id,
    int? maxNumOfChairs,
    int? status,
    int? placeId,
    int? categoryId,
  }) =>
      RoomModel(
        id: id ?? this.id,
        maxNumOfChairs: maxNumOfChairs ?? this.maxNumOfChairs,
        status: status ?? this.status,
        placeId: placeId ?? this.placeId,
        categoryId: categoryId ?? this.categoryId,
      );

  factory RoomModel.fromJson(String str) => RoomModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RoomModel.fromMap(Map<String, dynamic> json) => RoomModel(
        id: json["id"],
        maxNumOfChairs: json["max_num_of_chairs"],
        status: json["status"],
        placeId: json["placeId"],
        categoryId: json["category_id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "max_num_of_chairs": maxNumOfChairs,
        "status": status,
        "placeId": placeId,
        "category_id": categoryId,
      };
}
