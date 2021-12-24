// To parse this JSON data, do
//
//     final me = meFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Me> meFromJson(String str) => List<Me>.from(json.decode(str).map((x) => Me.fromJson(x)));

String meToJson(List<Me> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Me {
  Me({
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
  String image;
  String address;
  String addressLatitude;
  String addressLongitude;
  int parentId;
  String isApproved;
  DateTime createdAt;
  DateTime updatedAt;
  List<dynamic> permission;
  List<dynamic> permissions;
  List<Role> roles;

  factory Me.fromJson(Map<String, dynamic> json) => Me(
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

  int modelId;
  int roleId;
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
