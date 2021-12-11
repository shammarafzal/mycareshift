
import 'dart:convert';

List<Rewards> rewardsFromJson(String str) => List<Rewards>.from(json.decode(str).map((x) => Rewards.fromJson(x)));

String rewardsToJson(List<Rewards> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Rewards {
  Rewards({
    required this.id,
    required this.nurseId,
    required this.referalCode,
    required this.points,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String nurseId;
  String referalCode;
  String points;
  DateTime createdAt;
  DateTime updatedAt;

  factory Rewards.fromJson(Map<String, dynamic> json) => Rewards(
    id: json["id"],
    nurseId: json["nurse_id"],
    referalCode: json["referal_code"],
    points: json["points"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nurse_id": nurseId,
    "referal_code": referalCode,
    "points": points,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
