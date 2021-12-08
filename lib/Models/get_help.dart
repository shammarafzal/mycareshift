
import 'dart:convert';

List<Help> helpFromJson(String str) => List<Help>.from(json.decode(str).map((x) => Help.fromJson(x)));

String helpToJson(List<Help> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Help {
  Help({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String description;
  DateTime createdAt;
  DateTime updatedAt;

  factory Help.fromJson(Map<String, dynamic> json) => Help(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
