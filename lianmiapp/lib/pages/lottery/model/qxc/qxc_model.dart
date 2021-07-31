import 'dart:convert';

import 'package:lianmiapp/pages/lottery/model/lottery_base_model.dart';

class QxcModel extends LotteryBaseModel{
  ///1位
  List<int>? oneBalls;
  ///2位
  List<int>? twoBalls; 
  ///3位
  List<int>? threeBalls;
  ///4位
  List<int>? fourBalls;
  ///5位
  List<int>? fiveBalls;
  ///6位
  List<int>? sixBalls;
  ///7位
  List<int>? sevenBalls;
  

  QxcModel({this.oneBalls, this.twoBalls, this.threeBalls, this.fourBalls, this.fiveBalls, this.sixBalls, this.sevenBalls});

  QxcModel.fromJson(Map<String, dynamic> json):super.fromJson(json) {
    oneBalls = json['oneBalls'].cast<int>();
    twoBalls = json['twoBalls'].cast<int>();
    threeBalls = json['threeBalls'].cast<int>();
    fourBalls = json['fourBalls'].cast<int>();
    fiveBalls = json['fiveBalls'].cast<int>();
    sixBalls = json['sixBalls'].cast<int>();
    sevenBalls = json['sevenBalls'].cast<int>();
  }

  static List<QxcModel> modelListFromDbLotterys(var lotterys) {
    List<QxcModel> results = [];
    if (lotterys != null) {
      lotterys.forEach((v) {
        Map<String, dynamic> data = v.toJson();
        Map<String, dynamic> content = json.decode(data['content']);
        data.addAll(content);
        data.remove('content');
        results.add(QxcModel.fromJson(data));
      });
    }
    return results;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['oneBalls'] = this.oneBalls;
    data['twoBalls'] = this.twoBalls;
    data['threeBalls'] = this.threeBalls;
    data['fourBalls'] = this.fourBalls;
    data['fiveBalls'] = this.fiveBalls;
    data['sixBalls'] = this.sixBalls;
    data['sevenBalls'] = this.sevenBalls;
    return data;
  }

  String toAttach() {
    return json.encode(this.toJson());
  }
}