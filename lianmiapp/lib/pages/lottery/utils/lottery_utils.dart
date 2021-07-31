import 'dart:convert';

import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/lottery/lottery_router.dart';
import 'package:lianmiapp/pages/lottery/model/dlt/dlt_model.dart';
import 'package:lianmiapp/pages/lottery/model/fc3d/fc3d_model.dart';
import 'package:lianmiapp/pages/lottery/model/lottery_order_model.dart';
import 'package:lianmiapp/pages/lottery/model/pl3/pl3_model.dart';
import 'package:lianmiapp/pages/lottery/model/pl5/pl5_model.dart';
import 'package:lianmiapp/pages/lottery/model/qlc/qlc_model.dart';
import 'package:lianmiapp/pages/lottery/model/qxc/qxc_model.dart';
import 'package:lianmiapp/pages/lottery/model/shuang_se_qiu/shuang_se_qiu_model.dart';
import 'package:lianmiapp/pages/lottery/utils/lottery_data.dart';
import 'package:lianmiapp/util/app.dart';

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
    }
  }

  static List<dynamic> loadSelectNums(LotteryOrderModel order) {
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
        break;
      case 1:
        return '复式';
        break;
      case 2:
        return '胆拖';
        break;
      default:
        return '';
    }
  }
}
