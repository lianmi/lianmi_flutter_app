import 'dart:convert';

import 'package:lianmiapp/pages/product/model/lottery_base_model.dart';

class QlcModel extends LotteryBaseModel {
  List<int>? balls;

  QlcModel({this.balls});

  QlcModel.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    balls = json['balls'].cast<int>();
  }

  static List<QlcModel> modelListFromDbLotterys(var lotterys) {
    List<QlcModel> results = [];
    if (lotterys != null) {
      lotterys.forEach((v) {
        Map<String, dynamic> data = v.toJson();
        Map<String, dynamic> content = json.decode(data['content']);
        data.addAll(content);
        data.remove('content');
        results.add(QlcModel.fromJson(data));
      });
    }
    return results;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['balls'] = this.balls;
    return data;
  }

  String toAttach() {
    return json.encode(this.toJson());
  }
}
