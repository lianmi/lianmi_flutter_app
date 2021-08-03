import 'dart:convert';

import 'package:lianmiapp/pages/product/model/lottery_base_model.dart';

class ShuangseqiuModel extends LotteryBaseModel {
  ///红球
  List<int>? redBalls;

  ///蓝球
  List<int>? blueBalls;

  ///胆
  List<int>? danBalls;

  ShuangseqiuModel({this.blueBalls, this.danBalls, this.redBalls});

  ShuangseqiuModel.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    blueBalls = json['blueBalls'].cast<int>();
    if (json['danBalls'] != null) {
      danBalls = json['danBalls'].cast<int>();
    } else {
      danBalls = [];
    }
    redBalls = json['redBalls'].cast<int>();
  }

  static List<ShuangseqiuModel> modelListFromDbLotterys(var lotterys) {
    List<ShuangseqiuModel> results = [];
    if (lotterys != null) {
      lotterys.forEach((v) {
        Map<String, dynamic> data = v.toJson();
        Map<String, dynamic> content = json.decode(data['content']);
        data.addAll(content);
        data.remove('content');
        results.add(ShuangseqiuModel.fromJson(data));
      });
    }
    return results;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['blueBalls'] = this.blueBalls;
    data['danBalls'] = this.danBalls;
    data['redBalls'] = this.redBalls;
    return data;
  }

  String toAttach() {
    return json.encode(this.toJson());
  }
}
