// To parse this JSON data, do
//
//     final addressModel = addressModelFromJson(jsonString);

import 'dart:convert';

AddressModel addressModelFromJson(String str) =>
    AddressModel.fromJson(json.decode(str));

String addressModelToJson(AddressModel data) => json.encode(data.toJson());

class AddressModel {
  String? id;
  String? suggestion;
  int? udprn;
  Urls? urls;

  AddressModel({
    this.id,
    this.suggestion,
    this.udprn,
    this.urls,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    id: json["id"],
    suggestion: json["suggestion"],
    udprn: json["udprn"],
    urls: json["urls"] == null ? null : Urls.fromJson(json["urls"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "suggestion": suggestion,
    "udprn": udprn,
    "urls": urls?.toJson(),
  };
}

class Urls {
  String? udprn;

  Urls({
    this.udprn,
  });

  factory Urls.fromJson(Map<String, dynamic> json) => Urls(
    udprn: json["udprn"],
  );

  Map<String, dynamic> toJson() => {
    "udprn": udprn,
  };
}