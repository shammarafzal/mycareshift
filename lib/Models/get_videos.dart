
import 'dart:convert';

List<TrainingVideo> trainingVideoFromJson(String str) => List<TrainingVideo>.from(json.decode(str).map((x) => TrainingVideo.fromJson(x)));

String trainingVideoToJson(List<TrainingVideo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TrainingVideo {
  TrainingVideo({
    required this.id,
    required this.title,
    required this.media,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String title;
  String media;
  DateTime createdAt;
  DateTime updatedAt;

  factory TrainingVideo.fromJson(Map<String, dynamic> json) => TrainingVideo(
    id: json["id"],
    title: json["title"],
    media: json["media"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "media": media,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
