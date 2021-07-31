// class OrderRate {
//   String? businessId;
//   String? productId;
//   String? publicKey;

import 'dart:convert';

class CreateNewOrderResp {
  CreateNewOrderResp({
    this.publicKey, //商户协商公钥
    this.orderId,
    this.orderTime,
    this.ticketCode,
  });

  String? publicKey;
  String? orderId;
  int? orderTime;
  int? ticketCode;

  factory CreateNewOrderResp.fromJson(String str) =>
      CreateNewOrderResp.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreateNewOrderResp.fromMap(Map<String, dynamic> json) =>
      CreateNewOrderResp(
        publicKey: json["public_key"],
        orderId: json["order_id"],
        orderTime: json["order_time"],
        ticketCode: json["ticket_code"],
      );

  Map<String, dynamic> toMap() => {
        "public_key": publicKey,
        "order_id": orderId,
        "order_time": orderTime,
        "ticket_code": ticketCode,
      };
}
