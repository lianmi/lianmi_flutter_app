import 'dart:convert';

import 'package:lianmiapp/pages/product/model/dlt/dlt_model.dart';
import 'package:lianmiapp/pages/product/model/fc3d/fc3d_model.dart';
import 'package:lianmiapp/pages/product/model/pl3/pl3_model.dart';
import 'package:lianmiapp/pages/product/model/pl5/pl5_model.dart';
import 'package:lianmiapp/pages/product/model/qlc/qlc_model.dart';
import 'package:lianmiapp/pages/product/model/qxc/qxc_model.dart';
import 'package:lianmiapp/pages/product/model/shuang_se_qiu/shuang_se_qiu_model.dart';
import 'package:lianmiapp/pages/product/utils/lottery_data.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
import 'package:linkme_flutter_sdk/sdk/SdkEnum.dart';

///此model是订单里的详细数据，如果是彩票，则straws等字段有值，如果是合同存证，则
class OrderModel {
  String? buyUser; // 买家注册id
  String? businessUsername; //商户注册id
  String? shopName; //店铺名称
  String? orderImageUrl; //产品图片
  String? productID; //产品id
  String? productName; //产品名称
  int? loterryType; //通用商品类型，1-7是彩票类，8-票据存证
  String? orderID; //订单id
  List<String>? straws; //复式选号
  List<dynamic>? strawObjects; //对象数组, 分别对应双色球等各种彩票
  int? multiple; //倍数, 默认是1倍
  int? count; //注数
  double? cost; //订单价格
  int? orderTime; //改为按订单创建时间
  OrderStateEnum? status; //订单状态 枚举
  int? payMode; //支付平台 1-微信 2-支付宝
  int? payStatus; //支付状态
  int? chainStatus; //上链状态
  double? fee; //上链服务费
  int? ticketCode; //出票码
  double? prize; //中奖奖金
  String? prizedPhoto; //兑奖后彩票拍照图片url，上面有中奖金额或未中奖
  dynamic cunzhengModelData; //存证数据json，通用的，（必须根据 ProductModel id转为对应的model）

  OrderModel({
    this.buyUser,
    this.businessUsername,
    this.shopName,
    this.orderImageUrl,
    this.productID,
    this.productName,
    this.loterryType,
    this.orderID,
    this.straws,
    this.multiple = 1,
    this.count = 0,
    this.cost = 0.0,
    this.orderTime = 0,
    this.status,
    this.payMode,
    this.payStatus = 0,
    this.chainStatus = 0,
    this.fee = 0,
    this.ticketCode,
    this.prize,
    this.prizedPhoto,
    this.cunzhengModelData,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    buyUser = json['buyUser'];
    businessUsername = json['businessUsername'];
    shopName = json['shopName'];
    orderImageUrl = json['orderImageUrl'];
    productID = json['productID'];
    productName = json['productName'];
    loterryType = json['loterryType'];
    orderID = json['orderID'];
    if (json['straws'] != null) {
      straws = json['straws'].cast<String>();
    } else {
      straws = [];
    }
    multiple = json['multiple'];
    count = json['count'];
    cost = json['cost'];
    payMode = json['pay_mode'];
    ticketCode = json['ticket_code'];
    prize = json['prize'];
    prizedPhoto = json['prized_photo'];
    cunzhengModelData = json['cunzheng_model_data'];
  }

  //从服务器获取的金额都是以分为单位
  OrderModel.fromServerData(OrderInfoData orderInfoData, String planeBody) {
    buyUser = orderInfoData.buyerUsername;
    businessUsername = orderInfoData.storeUsername;

    productID = orderInfoData.productId;
    orderID = orderInfoData.orderId;
    cost = orderInfoData.totalAmount! / 100;
    orderTime = orderInfoData.orderTime!;
    status = OrderStateEnum.values[orderInfoData.state!];
    payMode = orderInfoData.payMode;
    fee = orderInfoData.fee! / 100;
    ticketCode = orderInfoData.ticketCode!;
    prize = orderInfoData.prize! / 100;
    prizedPhoto = orderInfoData.prizedPhoto!; // data['prized_photo'];

    Map<String, dynamic> body = json.decode(planeBody);
    // logD('body: $body');

    String bodyText = body['body'];
    String jsonBodyText = utf8.decode(base64Decode(bodyText));
    Map<String, dynamic> bodyJson = json.decode(jsonBodyText);
    OrderModel order = OrderModel.fromJson(bodyJson);
    shopName = order.shopName;
    orderImageUrl = order.orderImageUrl;
    productName = order.productName;

    loterryType = order.loterryType;
    if (loterryType! >= 1 || loterryType! <= 7) {
      //彩票类
      straws = order.straws;
      multiple = order.multiple;
      count = order.count;

      if (straws != null) {
        _genStrawObjects(straws!);
      }
    } else {
      //存证数据，动态的
      cunzhengModelData = order.cunzhengModelData;
    }
  }

  _genStrawObjects(List<String> straws) {
    List<dynamic> results = [];
    switch (LotteryTypeEnum.values[loterryType!]) {
      case LotteryTypeEnum.ssq:
        {
          straws.forEach((element) {
            results.add(ShuangseqiuModel.fromJson(json.decode(element)));
          });
        }
        break;
      case LotteryTypeEnum.fc3d:
        {
          straws.forEach((element) {
            results.add(Fc3dModel.fromJson(json.decode(element)));
          });
        }
        break;
      case LotteryTypeEnum.dlt:
        {
          straws.forEach((element) {
            results.add(DltModel.fromJson(json.decode(element)));
          });
        }
        break;
      case LotteryTypeEnum.qlc:
        {
          straws.forEach((element) {
            results.add(QlcModel.fromJson(json.decode(element)));
          });
        }
        break;
      case LotteryTypeEnum.pl3:
        {
          straws.forEach((element) {
            results.add(Pl3Model.fromJson(json.decode(element)));
          });
        }
        break;
      case LotteryTypeEnum.pl5:
        {
          straws.forEach((element) {
            results.add(Pl5Model.fromJson(json.decode(element)));
          });
        }
        break;
      case LotteryTypeEnum.qxc:
        {
          straws.forEach((element) {
            results.add(QxcModel.fromJson(json.decode(element)));
          });
        }
        break;
      default:
    }
    strawObjects = results;
  }

  static Future<List<OrderModel>> modelListFromServerDatas(
      dynamic datas) async {
    List<OrderModel> results = [];

    if (datas != null) {
      for (var data in datas) {
        OrderInfoData orderInfoData = data as OrderInfoData;

        String planeBody = orderInfoData.body!;
        try {
          results.add(OrderModel.fromServerData(orderInfoData, planeBody));
        } catch (e) {
          logE(e);
        }
      }
    }
    return results;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['buyUser'] = this.buyUser;
    data['businessUsername'] = this.businessUsername;
    data['shopName'] = this.shopName;
    data['orderImageUrl'] = this.orderImageUrl;
    data['productID'] = this.productID;
    data['productName'] = this.productName;
    data['loterryType'] = this.loterryType; //通用商品类型，1-7是彩票类，8-票据存证
    data['orderID'] = this.orderID;
    if (this.straws != null) {
      data['straws'] = this.straws;
    }
    data['multiple'] = this.multiple;
    data['count'] = this.count;
    data['cost'] = this.cost;
    data['pay_mode'] = this.payMode;
    data['ticket_code'] = this.ticketCode;
    data['prize'] = this.prize;
    data['prized_photo'] = this.prizedPhoto;
    data['cunzheng_model_data'] = this.cunzhengModelData;
    return data;
  }

  toAttach() {
    return toJsonString();
  }

  String toJsonString() {
    Map<String, dynamic> body = this.toJson();
    int bodyType = 0; //0-表示订单内容, 之前是区分vip会员的
    Map<String, dynamic> attach = {
      'body_type': bodyType,
      'body': base64Encode(utf8.encode(jsonEncode(body)))
    };
    return jsonEncode(attach);
  }

  //订单概要信息
  String get orderShowName {
    //彩票类
    if (loterryType! >= 1 && loterryType! <= 7) {
      if (strawObjects == null || strawObjects!.length == 0) return '';
      String showName = '';
      String suffix = '';
      if (productName == null || productName!.length == 0) productName = '商品';
      showName += productName!;
      dynamic object = strawObjects!.first;
      switch (LotteryTypeEnum.values[loterryType!]) {
        case LotteryTypeEnum.ssq:
          {
            ShuangseqiuModel model = object;
            if (model.redBalls!.length == 6 && model.blueBalls!.length == 1) {
              suffix = '单式';
            } else if (model.redBalls!.length > 6 ||
                model.blueBalls!.length > 1 && model.danBalls!.length == 0) {
              suffix = '复式';
            } else if (model.danBalls!.length > 0) {
              suffix = '胆拖';
            }
          }
          break;
        case LotteryTypeEnum.fc3d:
          {
            Fc3dModel model = object;
            if (model.geBalls!.length == 1 &&
                model.shiBalls!.length == 1 &&
                model.baiBalls!.length == 1) {
              suffix = '单式';
            } else if (model.geBalls!.length > 1 &&
                model.shiBalls!.length > 1 &&
                model.baiBalls!.length > 1) {
              suffix = '复式';
            }
          }
          break;
        case LotteryTypeEnum.dlt:
          {
            DltModel model = object;
            if (model.frontBalls!.length == 5 && model.backBalls!.length == 2) {
              suffix = '单式';
            } else if (model.frontBalls!.length > 5 ||
                model.backBalls!.length > 2 && model.danBalls!.length == 0) {
              suffix = '复式';
            } else if (model.danBalls!.length > 0) {
              suffix = '胆拖';
            }
          }
          break;
        case LotteryTypeEnum.qlc:
          {
            QlcModel model = object;
            if (model.balls!.length == 7) {
              suffix = '单式';
            } else if (model.balls!.length > 7) {
              suffix = '复式';
            }
          }
          break;
        case LotteryTypeEnum.pl3:
          {
            Pl3Model model = object;
            if (model.geBalls!.length == 1 &&
                model.shiBalls!.length == 1 &&
                model.baiBalls!.length == 1) {
              suffix = '单式';
            } else if (model.geBalls!.length > 1 &&
                model.shiBalls!.length > 1 &&
                model.baiBalls!.length > 1) {
              suffix = '复式';
            }
          }
          break;
        case LotteryTypeEnum.pl5:
          {
            Pl5Model model = object;
            if (model.geBalls!.length == 1 &&
                model.shiBalls!.length == 1 &&
                model.baiBalls!.length == 1 &&
                model.qianBalls!.length == 1 &&
                model.wanBalls!.length == 1) {
              suffix = '单式';
            } else if (model.geBalls!.length > 1 &&
                model.shiBalls!.length > 1 &&
                model.baiBalls!.length > 1) {
              suffix = '复式';
            }
          }
          break;
        case LotteryTypeEnum.qxc:
          {
            QxcModel model = object;
            if (model.oneBalls!.length == 1 &&
                model.twoBalls!.length == 1 &&
                model.threeBalls!.length == 1 &&
                model.fourBalls!.length == 1 &&
                model.fiveBalls!.length == 1 &&
                model.sixBalls!.length == 1 &&
                model.sevenBalls!.length == 1) {
              suffix = '单式';
            } else if (model.oneBalls!.length > 1 &&
                model.twoBalls!.length > 1 &&
                model.threeBalls!.length > 1 &&
                model.fourBalls!.length > 1 &&
                model.fiveBalls!.length > 1 &&
                model.sixBalls!.length > 1 &&
                model.sevenBalls!.length > 1) {
              suffix = '复式';
            }
          }
          break;
        default:
      }
      showName += suffix;
      return showName;
    } else {
      //其它票据类
      if (productName != null) {
        return productName!;
      } else {
        return '--';
      }
    }
  }
}
