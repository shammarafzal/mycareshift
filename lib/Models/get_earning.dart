// To parse this JSON data, do
//
//     final earning = earningFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Earning> earningFromJson(String str) => List<Earning>.from(json.decode(str).map((x) => Earning.fromJson(x)));

String earningToJson(List<Earning> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Earning {
  Earning({
    required this.id,
    required this.nurseId,
    required this.appointmentId,
    required this.earning,
    required this.date,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int nurseId;
  int appointmentId;
  String earning;
  String date;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  factory Earning.fromJson(Map<String, dynamic> json) => Earning(
    id: json["id"],
    nurseId: json["nurse_id"],
    appointmentId: json["appointment_id"],
    earning: json["earning"].toString(),
    date: json["date"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nurse_id": nurseId,
    "appointment_id": appointmentId,
    "earning": earning,
    "date": date,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
