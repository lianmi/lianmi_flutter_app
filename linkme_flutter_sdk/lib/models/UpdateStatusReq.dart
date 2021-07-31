import 'dart:convert';
import 'dart:ffi';

import 'package:linkme_flutter_sdk/base_enum.dart';
import 'package:linkme_flutter_sdk/sdk/SdkEnum.dart';
import 'package:moor/moor.dart';

/// 修改订单状态的请求参数
class UpdateStatusReq {
  String? order_id; //订单id
  int? status; //需要修改到新的订单状态

  UpdateStatusReq({this.order_id, this.status});

  factory UpdateStatusReq.fromJson(Map<String, dynamic> json) {
    return UpdateStatusReq(
        order_id: json['order_id'] as String, status: json['status'] as int);
  }

  Map<String, dynamic> toJson() => {
        'order_id': order_id,
        'status': status,
      };

  String toJsonString() {
    return jsonEncode(this.toJson());
  }
}
