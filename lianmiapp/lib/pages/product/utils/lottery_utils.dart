import 'dart:convert';

import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/product/lottery_router.dart';
import 'package:lianmiapp/pages/product/model/dlt/dlt_model.dart';
import 'package:lianmiapp/pages/product/model/fc3d/fc3d_model.dart';
import 'package:lianmiapp/pages/product/model/order_model.dart';
import 'package:lianmiapp/pages/product/model/pl3/pl3_model.dart';
import 'package:lianmiapp/pages/product/model/pl5/pl5_model.dart';
import 'package:lianmiapp/pages/product/model/qlc/qlc_model.dart';
import 'package:lianmiapp/pages/product/model/qxc/qxc_model.dart';
import 'package:lianmiapp/pages/product/model/shuang_se_qiu/shuang_se_qiu_model.dart';
import 'package:lianmiapp/pages/product/utils/lottery_data.dart';
import 'package:lianmiapp/util/app.dart';
import 'package:linkme_flutter_sdk/manager/LogManager.dart';

class LotteryUtils {
  static void showLottery(int id, String businessUsername) {
    switch (LotteryTypeEnum.values[id]) {
      case LotteryTypeEnum.ssq:
        {
          NavigatorUtils.push(
              App.context!,
              LotteryRouter.shuangseqiuPage +
                  '?businessUsername=${businessUsername}&id=${id}');
        }
        break;
      case LotteryTypeEnum.dlt:
        {
          NavigatorUtils.push(
              App.context!,
              LotteryRouter.dltPage +
                  '?businessUsername=${businessUsername}&id=${id}');
        }
        break;
      case LotteryTypeEnum.qlc:
        {
          NavigatorUtils.push(
              App.context!,
              LotteryRouter.qlcPage +
                  '?businessUsername=${businessUsername}&id=${id}');
        }
        break;
      case LotteryTypeEnum.fc3d:
        {
          NavigatorUtils.push(
              App.context!,
              LotteryRouter.fc3dPage +
                  '?businessUsername=${businessUsername}&id=${id}');
        }
        break;
      case LotteryTypeEnum.pl3:
        {
          NavigatorUtils.push(
              App.context!,
              LotteryRouter.pl3Page +
                  '?businessUsername=${businessUsername}&id=${id}');
        }
        break;
      case LotteryTypeEnum.pl5:
        {
          NavigatorUtils.push(
              App.context!,
              LotteryRouter.pl5Page +
                  '?businessUsername=${businessUsername}&id=${id}');
        }
        break;
      case LotteryTypeEnum.qxc:
        {
          NavigatorUtils.push(
              App.context!,
              LotteryRouter.qxcPage +
                  '?businessUsername=${businessUsername}&id=${id}');
        }
        break;
      default:
        logW('此彩种没有选号器');

        NavigatorUtils.push(
            App.context!,
            LotteryRouter.standartPage +
                '?businessUsername=${businessUsername}&id=${id}');
    }
  }

  static List<dynamic> loadSelectNums(OrderModel order) {
    List<dynamic> results = [];
    if (order.straws != null) {
      order.straws!.forEach((element) {
        switch (LotteryTypeEnum.values[order.loterryType!]) {
          case LotteryTypeEnum.ssq:
            {
              results.add(ShuangseqiuModel.fromJson(json.decode(element)));
            }
            break;
          case LotteryTypeEnum.fc3d:
            {
              results.add(Fc3dModel.fromJson(json.decode(element)));
            }
            break;
          case LotteryTypeEnum.dlt:
            {
              results.add(DltModel.fromJson(json.decode(element)));
            }
            break;
          case LotteryTypeEnum.qlc:
            {
              results.add(QlcModel.fromJson(json.decode(element)));
            }
            break;
          case LotteryTypeEnum.pl3:
            {
              results.add(Pl3Model.fromJson(json.decode(element)));
            }
            break;
          case LotteryTypeEnum.pl5:
            {
              results.add(Pl5Model.fromJson(json.decode(element)));
            }
            break;
          case LotteryTypeEnum.qxc:
            {
              results.add(QxcModel.fromJson(json.decode(element)));
            }
            break;
          default:
        }
      });
    }
    return results;
  }

  static String typeText(int type) {
    switch (type) {
      case 0:
        return '单式';
      case 1:
        return '复式';
      case 2:
        return '胆拖';
      default:
        return '';
    }
  }
}
