import 'dart:convert';

class PaymentModel {
  final int id;
  final DateTime date;
  final dynamic userId;
  final dynamic workId;
  final dynamic tranid;
  final dynamic amount;
  final dynamic discount;
  final dynamic additionalExpense;
  final dynamic dueAmount;
  final dynamic netAmount;
  final dynamic status;
  final String updatedBy;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  PaymentModel({
    required this.id,
    required this.date,
    required this.userId,
    required this.workId,
    required this.tranid,
    required this.amount,
    required this.discount,
    required this.additionalExpense,
    required this.dueAmount,
    required this.netAmount,
    required this.status,
    required this.updatedBy,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  PaymentModel copyWith({
    int? id,
    DateTime? date,
    dynamic userId,
    dynamic workId,
    dynamic tranid,
    dynamic amount,
    dynamic discount,
    dynamic additionalExpense,
  dynamic dueAmount,
    dynamic netAmount,
    dynamic status,
    String? updatedBy,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      PaymentModel(
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

  factory PaymentModel.fromRawJson(String str) => PaymentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
    id: json["id"],
    date: DateTime.parse(json["date"]),
    userId: json["user_id"],
    workId: json["work_id"],
    tranid: json["tranid"],
    amount: json["amount"],
    discount: json["discount"],
    additionalExpense: json["additional_expense"],
    dueAmount: json["due_amount"],
    netAmount: json["net_amount"],
    status: json["status"],
    updatedBy: json["updated_by"] ?? '',
    createdBy: json["created_by"]==null?'':json["updated_by"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
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
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
