import 'dart:convert';

class CompletedWorkModel {
  final String? image;
  final String? video;

  CompletedWorkModel({
     this.image,
     this.video,
  });

  CompletedWorkModel copyWith({
    String? image,
    String? video,
  }) =>
      CompletedWorkModel(
        image: image ?? this.image,
        video: video ?? this.video,
      );

  factory CompletedWorkModel.fromRawJson(String str) => CompletedWorkModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompletedWorkModel.fromJson(Map<String, dynamic> json) => CompletedWorkModel(
    image: json["image"],
    video: json["video"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "video": video,
  };
}
