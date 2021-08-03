class LotteryBaseModel {
  int? id;
  int? productId;
  int? type;
  int? createAt;
  int? act;

  LotteryBaseModel({this.id, this.productId, this.type, this.createAt, this.act});

  LotteryBaseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['productId'];
    type = json['type'];
    createAt = json['createAt'];
    act = json['act'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productId'] = this.productId;
    data['type'] = this.type;
    data['createAt'] = this.createAt;
    data['act'] = this.act;
    return data;
  }
}