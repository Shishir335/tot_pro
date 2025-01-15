import 'dart:convert';

class InvoiceModel {
  final int? id;
  final String? workId;
  final String? invoiceid;
  //final String? invoice_id;
  final DateTime? date;
  final String? amount;
  final String? img;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
   String? jobId;

  InvoiceModel({
     this.id,
     this.workId,
     this.invoiceid,
    //this.invoice_id,
     this.date,
     this.amount,
     this.img,
     this.status,
     this.createdAt,
     this.updatedAt,
    this.jobId
  });

  InvoiceModel copyWith({
    int? id,
    String? workId,
    String? invoiceid,
    DateTime? date,
    String? amount,
    String? img,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? jobId,
  }) =>
      InvoiceModel(
        id: id ?? this.id,
        workId: workId ?? this.workId,
        invoiceid: invoiceid ?? this.invoiceid,
        //invoice_id: invoice_id ?? this.invoice_id,
        date: date ?? this.date,
        amount: amount ?? this.amount,
        img: img ?? this.img,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        jobId: jobId ?? this.jobId,
      );

  factory InvoiceModel.fromRawJson(String str) => InvoiceModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InvoiceModel.fromJson(Map<String, dynamic> json) => InvoiceModel(
    id: json["id"],
    workId: json["work_id"],
    invoiceid: json["invoiceid"],
    //invoice_id: json["invoice_id"],
    date: DateTime.parse(json["date"]),
    amount: json["amount"],
    img: json["img"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    jobId: json["jobId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "work_id": workId,
    "invoiceid": invoiceid,
    //"invoice_id": invoice_id,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "amount": amount,
    "img": img,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "jobId": jobId,
  };
}
