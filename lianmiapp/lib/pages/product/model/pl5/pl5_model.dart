import 'dart:convert';

import 'package:lianmiapp/pages/product/model/lottery_base_model.dart';

class Pl5Model extends LotteryBaseModel {
  ///个位
  List<int>? geBalls;

  ///十位
  List<int>? shiBalls;

  ///百位
  List<int>? baiBalls;

  ///千位
  List<int>? qianBalls;

  ///万位
  List<int>? wanBalls;

  Pl5Model(
      {this.geBalls,
      this.shiBalls,
      this.baiBalls,
      this.qianBalls,
      this.wanBalls});

  Pl5Model.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    geBalls = json['geBalls'].cast<int>();
    shiBalls = json['shiBalls'].cast<int>();
    baiBalls = json['baiBalls'].cast<int>();
    qianBalls = json['qianBalls'].cast<int>();
    wanBalls = json['wanBalls'].cast<int>();
  }

  static List<Pl5Model> modelListFromDbLotterys(var lotterys) {
    List<Pl5Model> results = [];
    if (lotterys != null) {
      lotterys.forEach((v) {
        Map<String, dynamic> data = v.toJson();
        Map<String, dynamic> content = json.decode(data['content']);
        data.addAll(content);
        data.remove('content');
        results.add(Pl5Model.fromJson(data));
      });
    }
    return results;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['geBalls'] = this.geBalls;
    data['shiBalls'] = this.shiBalls;
    data['baiBalls'] = this.baiBalls;
    data['qianBalls'] = this.qianBalls;
    data['wanBalls'] = this.wanBalls;
    return data;
  }

  String toAttach() {
    return json.encode(this.toJson());
  }
}
