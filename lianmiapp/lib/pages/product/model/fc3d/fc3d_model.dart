import 'dart:convert';

import 'package:lianmiapp/pages/product/model/lottery_base_model.dart';

class Fc3dModel extends LotteryBaseModel {
  ///个位
  List<int>? geBalls;

  ///十位
  List<int>? shiBalls;

  ///百位
  List<int>? baiBalls;

  Fc3dModel({this.geBalls, this.shiBalls, this.baiBalls});

  Fc3dModel.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    geBalls = json['geBalls'].cast<int>();
    shiBalls = json['shiBalls'].cast<int>();
    baiBalls = json['baiBalls'].cast<int>();
  }

  static List<Fc3dModel> modelListFromDbLotterys(var lotterys) {
    List<Fc3dModel> results = [];
    if (lotterys != null) {
      lotterys.forEach((v) {
        Map<String, dynamic> data = v.toJson();
        Map<String, dynamic> content = json.decode(data['content']);
        data.addAll(content);
        data.remove('content');
        results.add(Fc3dModel.fromJson(data));
      });
    }
    return results;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['geBalls'] = this.geBalls;
    data['shiBalls'] = this.shiBalls;
    data['baiBalls'] = this.baiBalls;
    return data;
  }

  String toAttach() {
    return json.encode(this.toJson());
  }
}
