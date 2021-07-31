/*
{
  "code":200,
  "codeMsg":"Ok",
  "data":{
      "target":"",
      "type":"text",
      "msg":"bbb",
      "from":"欧阳修"
  }
}

 */

// To parse this JSON data, do
//
//     final response = responseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Response {
  Response({
    required this.code,
    required this.codeMsg,
    required this.data,
  });

  int code;
  String codeMsg;
  Data data;

  factory Response.fromRawJson(String str) =>
      Response.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        code: json["code"],
        codeMsg: json["codeMsg"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "codeMsg": codeMsg,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.target,
    required this.type,
    required this.msg,
    required this.from,
  });

  String target;
  String type;
  String msg;
  String from;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        target: json["target"],
        type: json["type"],
        msg: json["msg"],
        from: json["from"],
      );

  Map<String, dynamic> toJson() => {
        "target": target,
        "type": type,
        "msg": msg,
        "from": from,
      };
}
