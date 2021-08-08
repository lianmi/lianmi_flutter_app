import 'dart:convert';

class HetongDataModel {
  HetongDataModel({
    this.description,
    this.jiafangName,
    this.jiafangPhone,
    required this.attachs,
    this.attachsAliyun,
  });

  String? description; //合同概述
  String? jiafangName; //姓名
  String? jiafangPhone; //联系电话
  List<String> attachs = []; //附件数组，必须带后缀，只支持pdf及图片(jpg/jpeg/png/gif/svg)
  List<String>? attachsAliyun = []; //attachs对应在阿里云的obj地址数组

  factory HetongDataModel.fromJson(String str) =>
      HetongDataModel.fromMap(json.decode(str));

  //将model对象转为json字符串
  String toJson() => json.encode(toMap());

//将json对象转为model对象
  factory HetongDataModel.fromMap(Map<String, dynamic> json) {
    return HetongDataModel(
      description: json["description"],
      jiafangName: json["jiafang_name"],
      jiafangPhone: json["jiafang_phone"],
      attachs: json["attachs"] == null ? [] : json["attachs"].cast<String>(),
      attachsAliyun: json["attachs_aliyun"] == null
          ? []
          : json["attachs_aliyun"].cast<String>(),
    );
  }

  //将model对象转为map对象
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['jiafang_name'] = this.jiafangName;
    data['jiafang_phone'] = this.jiafangPhone;
    data['attachs'] = this.attachs;
    data['attachs_aliyun'] = this.attachsAliyun;

    return data;
  }
}
