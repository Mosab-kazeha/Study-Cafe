import 'dart:convert';

import 'package:study_cafe/model/model.dart';

class PlaceModel extends Model {
  int id;
  String name;
  List<String> locations;

  PlaceModel({
    required this.id,
    required this.name,
    required this.locations,
  });

  PlaceModel copyWith({
    int? id,
    String? name,
    List<String>? locations,
  }) =>
      PlaceModel(
        id: id ?? this.id,
        name: name ?? this.name,
        locations: locations ?? this.locations,
      );

  factory PlaceModel.fromJson(String str) =>
      PlaceModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlaceModel.fromMap(Map<String, dynamic> json) => PlaceModel(
        id: json["id"],
        name: json["name"],
        locations: List<String>.from(json["locations"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "locations": List<dynamic>.from(locations.map((x) => x)),
      };
}
