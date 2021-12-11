// To parse this JSON data, do
//
//     final booking = bookingFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Booking> bookingFromJson(String str) => List<Booking>.from(json.decode(str).map((x) => Booking.fromJson(x)));

String bookingToJson(List<Booking> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Booking {
  Booking({
    required this.id,
    required this.patientId,
    required this.companyId,
    required this.startDate,
    required this.day,
    required this.repeat,
    required this.time,
    required this.specificTime,
    required this.visitDuration,
    required this.noOfCarers,
    required this.hoistRequired,
    required this.visitInformation,
    required this.maxHourlyRate,
    required this.minHourlyRate,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String patientId;
  String companyId;
  String startDate;
  String day;
  String repeat;
  String time;
  dynamic specificTime;
  String visitDuration;
  String noOfCarers;
  String hoistRequired;
  String visitInformation;
  String maxHourlyRate;
  String minHourlyRate;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
    id: json["id"],
    patientId: json["patient_id"],
    companyId: json["company_id"],
    startDate: json["start_date"],
    day: json["day"],
    repeat: json["repeat"],
    time: json["time"],
    specificTime: json["specific_time"],
    visitDuration: json["visit_duration"],
    noOfCarers: json["no_of_carers"],
    hoistRequired: json["hoist_required"],
    visitInformation: json["visit_information"],
    maxHourlyRate: json["max_hourly_rate"],
    minHourlyRate: json["min_hourly_rate"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "patient_id": patientId,
    "company_id": companyId,
    "start_date": startDate,
    "day": day,
    "repeat": repeat,
    "time": time,
    "specific_time": specificTime,
    "visit_duration": visitDuration,
    "no_of_carers": noOfCarers,
    "hoist_required": hoistRequired,
    "visit_information": visitInformation,
    "max_hourly_rate": maxHourlyRate,
    "min_hourly_rate": minHourlyRate,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
