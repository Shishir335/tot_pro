import 'dart:convert';

class JobHistoryDetailsModel {
  final int? id;
  final String? userId;
  final DateTime? date;
  final String? name;
  final String? email;
  final String? phone;
  final dynamic houseNumber;
  final String? orderid;
  final String? addressFirstLine;
  final String? addressSecondLine;
  final String? addressThirdLine;
  final String? town;
  final dynamic street;
  final String? postCode;
  final dynamic message;
  final String? status;
  final dynamic updatedBy;
  final dynamic createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Workimage>? workimage;

  JobHistoryDetailsModel({
    this.id,
    this.userId,
    this.date,
    this.name,
    this.email,
    this.phone,
    this.houseNumber,
    this.orderid,
    this.addressFirstLine,
    this.addressSecondLine,
    this.addressThirdLine,
    this.town,
    this.street,
    this.postCode,
    this.message,
    this.status,
    this.updatedBy,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.workimage,
  });

  JobHistoryDetailsModel copyWith({
    int? id,
    String? userId,
    DateTime? date,
    String? name,
    String? email,
    String? phone,
    dynamic houseNumber,
    String? orderid,
    String? addressFirstLine,
    String? addressSecondLine,
    String? addressThirdLine,
    String? town,
    dynamic street,
    String? postCode,
    dynamic message,
    String? status,
    dynamic updatedBy,
    dynamic createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<Workimage>? workimage,
  }) =>
      JobHistoryDetailsModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        date: date ?? this.date,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        houseNumber: houseNumber ?? this.houseNumber,
        orderid: orderid ?? this.orderid,
        addressFirstLine: addressFirstLine ?? this.addressFirstLine,
        addressSecondLine: addressSecondLine ?? this.addressSecondLine,
        addressThirdLine: addressThirdLine ?? this.addressThirdLine,
        town: town ?? this.town,
        street: street ?? this.street,
        postCode: postCode ?? this.postCode,
        message: message ?? this.message,
        status: status ?? this.status,
        updatedBy: updatedBy ?? this.updatedBy,
        createdBy: createdBy ?? this.createdBy,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        workimage: workimage ?? this.workimage,
      );

  factory JobHistoryDetailsModel.fromRawJson(String str) => JobHistoryDetailsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory JobHistoryDetailsModel.fromJson(Map<String, dynamic> json) => JobHistoryDetailsModel(
    id: json["id"],
    userId: json["user_id"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    houseNumber:json["house_number"] ?? '',
    orderid: json["orderid"],
    addressFirstLine: json["address_first_line"] ?? '',
    addressSecondLine:json["address_second_line"] ?? '',
    addressThirdLine:json["address_third_line"] ?? '',
    town: json["town"],
    street: json["street"],
    postCode: json["post_code"],
    message: json["message"],
    status: json["status"],
    updatedBy: json["updated_by"],
    createdBy: json["created_by"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    workimage: json["workimage"] == null ? [] : List<Workimage>.from(json["workimage"]!.map((x) => Workimage.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "name": name,
    "email": email,
    "phone": phone,
    "house_number": houseNumber,
    "orderid": orderid,
    "address_first_line": addressFirstLine,
    "address_second_line": addressSecondLine,
    "address_third_line": addressThirdLine,
    "town": town,
    "street": street,
    "post_code": postCode,
    "message": message,
    "status": status,
    "updated_by": updatedBy,
    "created_by": createdBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "workimage": workimage == null ? [] : List<dynamic>.from(workimage!.map((x) => x.toJson())),
  };
}

class Workimage {
  final int? id;
  final String? workId;
  final String? name;
  final String? description;
  final String? status;
  final dynamic updatedBy;
  final dynamic createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Workimage({
    this.id,
    this.workId,
    this.name,
    this.description,
    this.status,
    this.updatedBy,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  Workimage copyWith({
    int? id,
    String? workId,
    String? name,
    String? description,
    String? status,
    dynamic updatedBy,
    dynamic createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Workimage(
        id: id ?? this.id,
        workId: workId ?? this.workId,
        name: name ?? this.name,
        description: description ?? this.description,
        status: status ?? this.status,
        updatedBy: updatedBy ?? this.updatedBy,
        createdBy: createdBy ?? this.createdBy,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Workimage.fromRawJson(String str) => Workimage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Workimage.fromJson(Map<String, dynamic> json) => Workimage(
    id: json["id"],
    workId: json["work_id"],
    name: json["name"],
    description: json["description"],
    status: json["status"],
    updatedBy: json["updated_by"],
    createdBy: json["created_by"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "work_id": workId,
    "name": name,
    "description": description,
    "status": status,
    "updated_by": updatedBy,
    "created_by": createdBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
