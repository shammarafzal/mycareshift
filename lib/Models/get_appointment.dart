// To parse this JSON data, do
//
//     final appointment = appointmentFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Appointment> appointmentFromJson(String str) => List<Appointment>.from(json.decode(str).map((x) => Appointment.fromJson(x)));

String appointmentToJson(List<Appointment> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Appointment {
  Appointment({
    required this.patientId,
    required this.startDate,
    required this.minHourlyRate,
    required this.time,
    required this.visitDuration,
    required this.patient,
  });

  String patientId;
  String startDate;
  String minHourlyRate;
  String time;
  String visitDuration;
  Patient patient;

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
    patientId: json["patient_id"],
    startDate: json["start_date"],
    minHourlyRate: json["min_hourly_rate"],
    time: json["time"],
    visitDuration: json["visit_duration"],
    patient: Patient.fromJson(json["patient"]),
  );

  Map<String, dynamic> toJson() => {
    "patient_id": patientId,
    "start_date": startDate,
    "min_hourly_rate": minHourlyRate,
    "time": time,
    "visit_duration": visitDuration,
    "patient": patient.toJson(),
  };
}

class Patient {
  Patient({
    required this.id,
    required this.patientId,
    required this.dob,
    required this.bloodGroup,
    required this.height,
    required this.weight,
    required this.toiletAssistance,
    required this.personalCare,
    required this.fndInformation,
    required this.houseWork,
    required this.accessInformation,
    required this.carePlan,
    required this.allergies,
    required this.medications,
    required this.immunizations,
    required this.labResults,
    required this.additionalNotes,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  int id;
  String patientId;
  String dob;
  String bloodGroup;
  String height;
  String weight;
  String toiletAssistance;
  String personalCare;
  String fndInformation;
  String houseWork;
  String accessInformation;
  dynamic carePlan;
  dynamic allergies;
  String medications;
  String immunizations;
  String labResults;
  String additionalNotes;
  DateTime createdAt;
  DateTime updatedAt;
  User user;

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
    id: json["id"],
    patientId: json["patient_id"],
    dob: json["dob"],
    bloodGroup: json["blood_group"],
    height: json["height"],
    weight: json["weight"],
    toiletAssistance: json["toilet_assistance"],
    personalCare: json["personal_care"],
    fndInformation: json["fnd_information"],
    houseWork: json["house_work"],
    accessInformation: json["access_information"],
    carePlan: json["care_plan"],
    allergies: json["allergies"],
    medications: json["medications"],
    immunizations: json["immunizations"],
    labResults: json["lab_results"],
    additionalNotes: json["additional_notes"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "patient_id": patientId,
    "dob": dob,
    "blood_group": bloodGroup,
    "height": height,
    "weight": weight,
    "toilet_assistance": toiletAssistance,
    "personal_care": personalCare,
    "fnd_information": fndInformation,
    "house_work": houseWork,
    "access_information": accessInformation,
    "care_plan": carePlan,
    "allergies": allergies,
    "medications": medications,
    "immunizations": immunizations,
    "lab_results": labResults,
    "additional_notes": additionalNotes,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "user": user.toJson(),
  };
}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.address,
    required this.addressLatitude,
    required this.addressLongitude,
    required this.parentId,
    required this.isApproved,
    required this.createdAt,
    required this.updatedAt,
    required this.permission,
    required this.permissions,
    required this.roles,
  });

  int id;
  String name;
  String email;
  String phone;
  dynamic image;
  String address;
  dynamic addressLatitude;
  dynamic addressLongitude;
  String parentId;
  String isApproved;
  DateTime createdAt;
  DateTime updatedAt;
  List<dynamic> permission;
  List<dynamic> permissions;
  List<Role> roles;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    image: json["image"],
    address: json["address"],
    addressLatitude: json["address_latitude"],
    addressLongitude: json["address_longitude"],
    parentId: json["parent_id"],
    isApproved: json["is_approved"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    permission: List<dynamic>.from(json["permission"].map((x) => x)),
    permissions: List<dynamic>.from(json["permissions"].map((x) => x)),
    roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "image": image,
    "address": address,
    "address_latitude": addressLatitude,
    "address_longitude": addressLongitude,
    "parent_id": parentId,
    "is_approved": isApproved,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "permission": List<dynamic>.from(permission.map((x) => x)),
    "permissions": List<dynamic>.from(permissions.map((x) => x)),
    "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
  };
}

class Role {
  Role({
    required this.id,
    required this.name,
    required this.guardName,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
    required this.permissions,
  });

  int id;
  String name;
  String guardName;
  DateTime createdAt;
  DateTime updatedAt;
  Pivot pivot;
  List<dynamic> permissions;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["id"],
    name: json["name"],
    guardName: json["guard_name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    pivot: Pivot.fromJson(json["pivot"]),
    permissions: List<dynamic>.from(json["permissions"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "guard_name": guardName,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "pivot": pivot.toJson(),
    "permissions": List<dynamic>.from(permissions.map((x) => x)),
  };
}

class Pivot {
  Pivot({
    required this.modelId,
    required this.roleId,
    required this.modelType,
  });

  String modelId;
  String roleId;
  String modelType;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    modelId: json["model_id"],
    roleId: json["role_id"],
    modelType: json["model_type"],
  );

  Map<String, dynamic> toJson() => {
    "model_id": modelId,
    "role_id": roleId,
    "model_type": modelType,
  };
}
