import 'dart:convert';

class TransactionModel {
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

  TransactionModel({
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

  TransactionModel copyWith({
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
      TransactionModel(
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

  factory TransactionModel.fromRawJson(String str) => TransactionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
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
