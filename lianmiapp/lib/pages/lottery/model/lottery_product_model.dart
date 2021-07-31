class LotteryProductModel {
  int? id; //对应通用商品id枚举
  String? productId;
  String? productName;
  int? productType;
  int? productPrice;
  String? productDesc;
  String? productPic1Large;
  String? productPic2Large;
  String? productPic3Large;
  String? shortVideo;
  bool? allowCancel;
  String? descPic1;
  String? descPic2;
  String? descPic3;
  String? descPic4;
  String? descPic5;
  String? descPic6;
  // int? updatedAt;

  LotteryProductModel({
    this.id,
    this.productId,
    this.productName,
    this.productType,
    this.productDesc,
    this.productPrice,
    this.productPic1Large,
    this.productPic2Large,
    this.productPic3Large,
    this.shortVideo,
    this.allowCancel,
    this.descPic1,
    this.descPic2,
    this.descPic3,
    this.descPic4,
    this.descPic5,
    this.descPic6,
    // this.updatedAt,
  });

  LotteryProductModel.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    productId = json['productId'];
    productName = json['productName'];
    productType = json['productType'];
    productDesc = json['productDesc'];
    if (json['productPrice'] is double) {
      productPrice = json['productPrice'].round();
    } else {
      productPrice = json['productPrice'];
    }
    if (productPrice == null || productPrice == 0) {
      productPrice = 200;
    }
    productPic1Large = json['productPic1Large'];
    productPic2Large = json['productPic2Large'];
    productPic3Large = json['productPic3Large'];
    shortVideo = json['shortVideo'];
    allowCancel = json['allowCancel'];
    descPic1 = json['descPic1'];
    descPic2 = json['descPic2'];
    descPic3 = json['descPic3'];
    descPic4 = json['descPic4'];
    descPic5 = json['descPic5'];
    descPic6 = json['descPic6'];
    // updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.id;
    data['productId'] = this.productId;
    data['productName'] = this.productName;
    data['productType'] = this.productType;
    data['productDesc'] = this.productDesc;
    data['productPrice'] = this.productPrice;
    data['productPic1Large'] = this.productPic1Large;
    data['productPic2Large'] = this.productPic2Large;
    data['productPic3Large'] = this.productPic3Large;
    data['shortVideo'] = this.shortVideo;
    data['allowCancel'] = this.allowCancel;
    data['descPic1'] = this.descPic1;
    data['descPic2'] = this.descPic2;
    data['descPic3'] = this.descPic3;
    data['descPic4'] = this.descPic4;
    data['descPic5'] = this.descPic5;
    data['descPic6'] = this.descPic6;
    // data['updated_at'] = this.updatedAt;
    return data;
  }

  static List<LotteryProductModel> modelListFromJson(json) {
    List<LotteryProductModel> results = [];
    if (json != null) {
      json.forEach((v) {
        results.add(new LotteryProductModel.fromJson(v));
      });
    }
    return results;
  }
}
