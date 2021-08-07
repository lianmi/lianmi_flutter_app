import 'dart:convert';

class StandartOrderModel {
  StandartOrderModel({
    this.id,
    this.productName,
    this.mobile,
    this.title,
    this.description,
    this.count,
    this.multiple,
    required this.attachs,
  });

  int? id; //产品id
  String? productName; //产品名称
  String? mobile; //联系手机，自动取当前用户登录手机s
  String? title; //标题
  String? description; //概述
  int? count; //数量
  int? multiple; //倍数
  List<String> attachs = []; //附件数组，必须带后缀，只支持图片(jpg/jpeg/png/gif/svg)

  factory StandartOrderModel.fromJson(String str) =>
      StandartOrderModel.fromMap(json.decode(str));

  //将model对象转为json字符串
  String toJson() => json.encode(toMap());

//将json对象转为model对象
  factory StandartOrderModel.fromMap(Map<String, dynamic> json) {
    return StandartOrderModel(
      id: json["id"],
      productName: json["product_name"],
      mobile: json["mobile"],
      title: json["title"],
      description: json["description"],
      count: json["count"],
      multiple: json["multiple"],
      attachs: json["attachs"] == null ? [] : json["attachs"].cast<String>(),
    );
  }

  //将model对象转为map对象
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_name'] = this.productName;
    data['mobile'] = this.mobile;
    data['title'] = this.title;
    data['description'] = this.description;
    data['count'] = this.count;
    data['multiple'] = this.multiple;
    data['attachs'] = this.attachs;

    return data;
  }
}
