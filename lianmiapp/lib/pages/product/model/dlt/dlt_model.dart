import 'dart:convert';

import 'package:lianmiapp/pages/product/model/lottery_base_model.dart';

class DltModel extends LotteryBaseModel {
  ///前区
  List<int>? frontBalls;

  ///后区
  List<int>? backBalls;

  ///前区-胆
  List<int>? danBalls;

  DltModel({this.frontBalls, this.backBalls, this.danBalls});

  DltModel.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    frontBalls = json['frontBalls'].cast<int>();
    backBalls = json['backBalls'].cast<int>();
    if (json['danBalls'] != null) {
      danBalls = json['danBalls'].cast<int>();
    } else {
      danBalls = [];
    }
  }

  static List<DltModel> modelListFromDbLotterys(var lotterys) {
    List<DltModel> results = [];
    if (lotterys != null) {
      lotterys.forEach((v) {
        Map<String, dynamic> data = v.toJson();
        Map<String, dynamic> content = json.decode(data['content']);
        data.addAll(content);
        data.remove('content');
        results.add(DltModel.fromJson(data));
      });
    }
    return results;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['frontBalls'] = this.frontBalls;
    data['backBalls'] = this.backBalls;
    data['danBalls'] = this.danBalls;
    return data;
  }

  String toAttach() {
    return json.encode(this.toJson());
  }
}
