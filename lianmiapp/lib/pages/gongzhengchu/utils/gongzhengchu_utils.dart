import 'dart:convert';

import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/gongzhengchu/gongzhengchu_router.dart';
// import 'package:lianmiapp/pages/lottery/lottery_router.dart';
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
import 'package:linkme_flutter_sdk/manager/LogManager.dart';

/*

  ///声明招标投标类
  zhaotoubiao,

  ///拍卖贷款抵押
  paimaidaikdiya,

  ///股票发行
  gupiaofaxing,

  ///股份制企业创立
  gufenzhiqiyechuangli,

  ///有价证券转让
  youjiazhengquanzhuanrang,

  ///票据拒付提存
  piaojujufuticun,

  ///国有土地转让
  guoyoutudizhuanrang,

  ///商品房的买卖预售
  shangpinfangmaimaiiyushou,

  ///房屋租赁
  fangwozulin,

  ///继承收养遗嘱赠与
  jichengshouyangyizhuzengyu,

  GongzhengchuUtils.showGongzhengchu(
                      model.id!,
                      model.productId!,
                      model.productName!,
                      model.productPrice!,
                      widget.businessUsername);
*/

class GongzhengchuUtils {
  static void showGongzhengchu(
      int id, String productId, int productPrice, String businessUsername) {
    switch (id) {
      case 9: //合同协议委托类
        {
          NavigatorUtils.push(
              App.context!,
              GongzhengchuRouter.hetongPage +
                  '?productId=${productId}&productPrice=${productPrice}&businessUsername=${businessUsername}&id=${id}');
        }
        break;
      case 10: //声明招标投标类
        {
          NavigatorUtils.push(
              App.context!,
              GongzhengchuRouter.zhaotoubiaoPage +
                  '?productId=${productId}&productPrice=${productPrice}&businessUsername=${businessUsername}&id=${id}');
        }
        break;
      default:
        {
          logW('暂时不支持此智能合约');
        }
    }

    /*
    switch (GongzhengchuTypeEnum.values[id]) {
      case GongzhengchuTypeEnum.hetong: //合同协议委托类
        {
          NavigatorUtils.push(
              App.context!,
              GongzhengchuRouter.hetongPage +
                  '?businessUsername=${businessUsername}&id=${id}');
        }
        break;
      case GongzhengchuTypeEnum.zhaotoubiao: //声明招标投标类
        {
          NavigatorUtils.push(
              App.context!,
              GongzhengchuRouter.zhaotoubiaoPage +
                  '?businessUsername=${businessUsername}&id=${id}');
        }
        break;
      // case LotteryTypeEnum.qlc:
      //   {
      //     NavigatorUtils.push(
      //         App.context!,
      //         LotteryRouter.qlcPage +
      //             '?businessUsername=${businessUsername}&id=${id}');
      //   }
      //   break;
      // case LotteryTypeEnum.fc3d:
      //   {
      //     NavigatorUtils.push(
      //         App.context!,
      //         LotteryRouter.fc3dPage +
      //             '?businessUsername=${businessUsername}&id=${id}');
      //   }
      //   break;
      // case LotteryTypeEnum.pl3:
      //   {
      //     NavigatorUtils.push(
      //         App.context!,
      //         LotteryRouter.pl3Page +
      //             '?businessUsername=${businessUsername}&id=${id}');
      //   }
      //   break;
      // case LotteryTypeEnum.pl5:
      //   {
      //     NavigatorUtils.push(
      //         App.context!,
      //         LotteryRouter.pl5Page +
      //             '?businessUsername=${businessUsername}&id=${id}');
      //   }
      //   break;
      // case LotteryTypeEnum.qxc:
      //   {
      //     NavigatorUtils.push(
      //         App.context!,
      //         LotteryRouter.qxcPage +
      //             '?businessUsername=${businessUsername}&id=${id}');
      //   }
      //   break;
      default:
    }
    */
  }
}
