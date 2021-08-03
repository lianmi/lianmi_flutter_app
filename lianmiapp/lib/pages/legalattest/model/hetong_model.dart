import 'dart:convert';

class HetongDataModel {
  HetongDataModel({
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

  int? type; //合同类型
  String? description; //合同概述

  ///甲方
  String? jiafangName; //甲方名称
  String? jiafangPhone; //甲方联系电话
  String? jiafangLegalName; //甲方法人姓名
  String? jiafangAddress; //甲方地址

  ///乙方
  String? yifangName; //乙方名称
  String? yifangPhone; //乙方联系电话
  String? yifangHuji; //乙方户籍
  String? yifangAddress; //乙方住址
  String? yifangIdCard; //乙方身份证号码

  String? image1; //附件图片1
  String? image2; //附件图片2
  String? image3; //附件图片3
  String? image4; //附件图片4
  String? image5; //附件图片5
  String? image6; //附件图片6
  String? image7; //附件图片7
  String? image8; //附件图片8
  String? image9; //附件图片9

  factory HetongDataModel.fromJson(String str) =>
      HetongDataModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HetongDataModel.fromMap(Map<String, dynamic> json) => HetongDataModel(
        type: json["type"],
        description: json["description"],
        jiafangName: json["jiafang_name"],
        jiafangPhone: json["jiafang_phone"],
        jiafangLegalName: json["jiafang_legal_name"],
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
        "jiafang_legal_name": jiafangLegalName,
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
