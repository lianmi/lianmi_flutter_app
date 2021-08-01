// To parse this JSON data, do
//
//     final rsaKeyPairModel = rsaKeyPairModelFromMap(jsonString);

import 'dart:convert';

//商户RSA公私钥
class RsaKeyPairModel {
  RsaKeyPairModel({
    this.privateKey,
    this.publicKey,
  });

  String? privateKey;
  String? publicKey;

  factory RsaKeyPairModel.fromJson(String str) =>
      RsaKeyPairModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RsaKeyPairModel.fromMap(Map<String, dynamic> json) => RsaKeyPairModel(
        privateKey: json["private_key"],
        publicKey: json["public_key"],
      );

  Map<String, dynamic> toMap() => {
        "private_key": privateKey,
        "public_key": publicKey,
      };
}
