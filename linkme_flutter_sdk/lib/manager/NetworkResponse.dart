import 'dart:typed_data';

/// 回包
class NetworkResponse {
  String? businessKey;
  int? code;
  String? errormsg;

  // 因为protobuf 只支持这种格式
  Uint8List? msgBody;

  NetworkResponse({this.code, this.errormsg, this.businessKey, this.msgBody});
}
