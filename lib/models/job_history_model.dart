import 'dart:convert';

class JobHistoryModel {
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
  final dynamic addressThirdLine;
  final String? town;
  final dynamic street;
  final String? postCode;
  final dynamic message;
  final String? status;
  final String? isNew;
  final dynamic updatedBy;
  final String? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Transaction>? transactions;
  final List<Invoice>? invoice;
  final List<Workimage>? workimage;


  JobHistoryModel({
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
    this.isNew,
    this.updatedBy,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.transactions,
    this.invoice,
    this.workimage,
  });

  JobHistoryModel copyWith({
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
    dynamic addressThirdLine,
    String? town,
    dynamic street,
    String? postCode,
    dynamic message,
    String? status,
    String? isNew,
    dynamic updatedBy,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<Transaction>? transactions,
    List<Invoice>? invoice,
    List<Workimage>? workimage,
  }) =>
      JobHistoryModel(
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
        isNew: isNew ?? this.isNew,
        updatedBy: updatedBy ?? this.updatedBy,
        createdBy: createdBy ?? this.createdBy,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        transactions: transactions ?? this.transactions,
        invoice: invoice ?? this.invoice,
        workimage: workimage ?? this.workimage,
      );

  factory JobHistoryModel.fromRawJson(String str) => JobHistoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory JobHistoryModel.fromJson(Map<String, dynamic> json) => JobHistoryModel(
    id: json["id"],
    userId: json["user_id"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    houseNumber: json["house_number"],
    orderid: json["orderid"],
    addressFirstLine: json["address_first_line"],
    addressSecondLine: json["address_second_line"],
    addressThirdLine: json["address_third_line"],
    town: json["town"],
    street: json["street"],
    postCode: json["post_code"],
    message: json["message"],
    status: json["status"],
    isNew: json["is_new"],
    updatedBy: json["updated_by"],
    createdBy: json["created_by"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    transactions: json["transactions"] == null ? [] : List<Transaction>.from(json["transactions"]!.map((x) => Transaction.fromJson(x))),
    invoice: json["invoice"] == null ? [] : List<Invoice>.from(json["invoice"]!.map((x) => Invoice.fromJson(x))),
   // invoice: json["invoice"] == null ?  [] : Invoice.fromJson(json["invoice"]),
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
    "is_new": isNew,
    "updated_by": updatedBy,
    "created_by": createdBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "transactions": transactions == null ? [] : List<dynamic>.from(transactions!.map((x) => x.toJson())),
    "invoice": invoice == null ? [] : List<dynamic>.from(invoice!.map((x) => x.toJson())),
    //"invoice": invoice?.toJson(),
    "workimage": workimage == null ? [] : List<dynamic>.from(workimage!.map((x) => x.toJson())),
  };
}

class Invoice {
  final int? id;
  final String? workId;
  final String? invoiceid;
  final DateTime? date;
  final String? amount;
  final String? img;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Invoice({
    this.id,
    this.workId,
    this.invoiceid,
    this.date,
    this.amount,
    this.img,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Invoice copyWith({
    int? id,
    String? workId,
    String? invoiceid,
    DateTime? date,
    String? amount,
    String? img,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Invoice(
        id: id ?? this.id,
        workId: workId ?? this.workId,
        invoiceid: invoiceid ?? this.invoiceid,
        date: date ?? this.date,
        amount: amount ?? this.amount,
        img: img ?? this.img,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Invoice.fromRawJson(String str) => Invoice.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
    id: json["id"],
    workId: json["work_id"],
    invoiceid: json["invoiceid"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    amount: json["amount"],
    img: json["img"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "work_id": workId,
    "invoiceid": invoiceid,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "amount": amount,
    "img": img,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Transaction {
  final int? id;
  final DateTime? date;
  final String? userId;
  final String? workId;
  final String? tranid;
  final String? amount;
  final String? discount;
  final String? additionalExpense;
  final String? dueAmount;
  final String? netAmount;
  final String? status;
  final dynamic updatedBy;
  final dynamic createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Transaction({
    this.id,
    this.date,
    this.userId,
    this.workId,
    this.tranid,
    this.amount,
    this.discount,
    this.additionalExpense,
    this.dueAmount,
    this.netAmount,
    this.status,
    this.updatedBy,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  Transaction copyWith({
    int? id,
    DateTime? date,
    String? userId,
    String? workId,
    String? tranid,
    String? amount,
    String? discount,
    String? additionalExpense,
    String? dueAmount,
    String? netAmount,
    String? status,
    dynamic updatedBy,
    dynamic createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Transaction(
        id: id ?? this.id,
        date: date ?? this.date,
        userId: userId ?? this.userId,
        workId: workId ?? this.workId,
        tranid: tranid ?? this.tranid,
        amount: amount ?? this.amount,
        discount: discount ?? this.discount,
        additionalExpense: additionalExpense ?? this.additionalExpense,
        dueAmount: dueAmount ?? this.dueAmount,
        netAmount: netAmount ?? this.netAmount,
        status: status ?? this.status,
        updatedBy: updatedBy ?? this.updatedBy,
        createdBy: createdBy ?? this.createdBy,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Transaction.fromRawJson(String str) => Transaction.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    id: json["id"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    userId: json["user_id"],
    workId: json["work_id"],
    tranid: json["tranid"],
    amount: json["amount"],
    discount: json["discount"],
    additionalExpense: json["additional_expense"],
    dueAmount: json["due_amount"],
    netAmount: json["net_amount"],
    status: json["status"],
    updatedBy: json["updated_by"],
    createdBy: json["created_by"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "user_id": userId,
    "work_id": workId,
    "tranid": tranid,
    "amount": amount,
    "discount": discount,
    "additional_expense": additionalExpense,
    "due_amount": dueAmount,
    "net_amount": netAmount,
    "status": status,
    "updated_by": updatedBy,
    "created_by": createdBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
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
