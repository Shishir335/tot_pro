import 'dart:convert';

class UserProfileModel {
  final int? id;
  final String? name;
  final String? surname;
  final String? email;
  final dynamic emailVerifiedAt;
  final String? isType;
  final String? phone;
  final String? addressFirstLine;
  final String? addressSecondLine;
  final String? addressThirdLine;
  final String? town;
  final String? postcode;
  final String? country;
  final String? photo;
  final dynamic about;
  final dynamic facebook;
  final dynamic twitter;
  final dynamic google;
  final dynamic linkedin;
  final dynamic whatsapp;
  final String? status;
  final dynamic updatedBy;
  final dynamic createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserProfileModel({
    this.id,
    this.name,
    this.surname,
    this.email,
    this.emailVerifiedAt,
    this.isType,
    this.phone,
    this.addressFirstLine,
    this.addressSecondLine,
    this.addressThirdLine,
    this.town,
    this.postcode,
    this.country,
    this.photo,
    this.about,
    this.facebook,
    this.twitter,
    this.google,
    this.linkedin,
    this.whatsapp,
    this.status,
    this.updatedBy,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  UserProfileModel copyWith({
    int? id,
    String? name,
    String? surname,
    String? email,
    dynamic emailVerifiedAt,
    String? isType,
    String? phone,
    String? addressFirstLine,
    String? addressSecondLine,
    String? addressThirdLine,
    String? town,
    String? postcode,
    String? country,
    String? photo,
    dynamic about,
    dynamic facebook,
    dynamic twitter,
    dynamic google,
    dynamic linkedin,
    dynamic whatsapp,
    String? status,
    dynamic updatedBy,
    dynamic createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      UserProfileModel(
        id: id ?? this.id,
        name: name ?? this.name,
        surname: surname ?? this.surname,
        email: email ?? this.email,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        isType: isType ?? this.isType,
        phone: phone ?? this.phone,
        addressFirstLine: addressFirstLine ?? this.addressFirstLine,
        addressSecondLine: addressSecondLine ?? this.addressSecondLine,
        addressThirdLine: addressThirdLine ?? this.addressThirdLine,
        town: town ?? this.town,
        postcode: postcode ?? this.postcode,
        country: country ?? this.country,
        photo: photo ?? this.photo,
        about: about ?? this.about,
        facebook: facebook ?? this.facebook,
        twitter: twitter ?? this.twitter,
        google: google ?? this.google,
        linkedin: linkedin ?? this.linkedin,
        whatsapp: whatsapp ?? this.whatsapp,
        status: status ?? this.status,
        updatedBy: updatedBy ?? this.updatedBy,
        createdBy: createdBy ?? this.createdBy,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory UserProfileModel.fromRawJson(String str) => UserProfileModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
    id: json["id"],
    name: json["name"],
    surname: json["surname"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    isType: json["is_type"].toString(),
    phone: json["phone"],
    addressFirstLine: json["address_first_line"],
    addressSecondLine: json["address_second_line"],
    addressThirdLine: json["address_third_line"],
    town: json["town"],
    postcode: json["postcode"],
    country: json["country"],
    photo: json["photo"],
    about: json["about"],
    facebook: json["facebook"],
    twitter: json["twitter"],
    google: json["google"],
    linkedin: json["linkedin"],
    whatsapp: json["whatsapp"],
    status: json["status"].toString(),
    updatedBy: json["updated_by"],
    createdBy: json["created_by"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "surname": surname,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "is_type": isType,
    "phone": phone,
    "address_first_line": addressFirstLine,
    "address_second_line": addressSecondLine,
    "address_third_line": addressThirdLine,
    "town": town,
    "postcode": postcode,
    "country": country,
    "photo": photo,
    "about": about,
    "facebook": facebook,
    "twitter": twitter,
    "google": google,
    "linkedin": linkedin,
    "whatsapp": whatsapp,
    "status": status,
    "updated_by": updatedBy,
    "created_by": createdBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
