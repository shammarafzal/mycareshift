import 'dart:convert';

List<BookingDetails> bookingDetailsFromJson(String str) => List<BookingDetails>.from(json.decode(str).map((x) => BookingDetails.fromJson(x)));

String bookingDetailsToJson(List<BookingDetails> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookingDetails {
  BookingDetails({
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
    required this.patient,
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
  Patient patient;

  factory BookingDetails.fromJson(Map<String, dynamic> json) => BookingDetails(
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
    patient: Patient.fromJson(json["patient"]),
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
  String allergies;
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
  String addressLatitude;
  String addressLongitude;
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
