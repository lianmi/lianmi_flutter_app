// To parse this JSON data, do
//
//     final hetongtData = hetongtDataFromMap(jsonString);

import 'dart:convert';

class HetongteData {
  HetongteData({
    this.type,
    this.description,
    this.jiafangName,
    this.jiafangPhone,
    this.jiafangLegalName,
    this.jiafangAddress,
    this.yifangName,
    this.yifangPhone,
    this.yifangHuji,
    this.yifangAddress, 
    this.yifangIdCard,
    this.image1,
    this.image2,
    this.image3,
    this.image4,
    this.image5,
    this.image6,
    this.image7,
    this.image8,
    this.image9,
  });

  int? type;
  String? description;
  String? jiafangName;
  String? jiafangPhone;
  String? jiafangLegalName;
  String? jiafangAddress;
  String? yifangName;
  String? yifangPhone;
  String? yifangHuji;
  String? yifangAddress;
  String? yifangIdCard;
  String? image1;
  String? image2;
  String? image3;
  String? image4;
  String? image5;
  String? image6;
  String? image7;
  String? image8;
  String? image9;

  factory HetongteData.fromJson(String str) =>
      HetongteData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HetongteData.fromMap(Map<String, dynamic> json) => HetongteData(
        type: json["type"],
        description: json["description"],
        jiafangName: json["jiafang_name"],
        jiafangPhone: json["jiafang_phone"],
        jiafangLegalName: json["jiafangLegal_name"],
        jiafangAddress: json["jiafang_address"],
        yifangName: json["yifang_name"],
        yifangPhone: json["yifang_phone"],
        yifangHuji: json["yifang_huji"],
        yifangAddress: json["yifang_address"],
        yifangIdCard: json["yifang_id_card"],
        image1: json["image1"],
        image2: json["image2"],
        image3: json["image3"],
        image4: json["image4"],
        image5: json["image5"],
        image6: json["image6"],
        image7: json["image7"],
        image8: json["image8"],
        image9: json["image9"],
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "description": description,
        "jiafang_name": jiafangName,
        "jiafang_phone": jiafangPhone,
        "jiafangLegal_name": jiafangLegalName,
        "jiafang_address": jiafangAddress,
        "yifang_name": yifangName,
        "yifang_phone": yifangPhone,
        "yifang_huji": yifangHuji,
        "yifang_address": yifangAddress,
        "yifang_id_card": yifangIdCard,
        "image1": image1,
        "image2": image2,
        "image3": image3,
        "image4": image4,
        "image5": image5,
        "image6": image6,
        "image7": image7,
        "image8": image8,
        "image9": image9,
      };
}
