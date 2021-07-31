import 'package:lianmiapp/pages/lottery/provider/dlt_provider.dart';
import 'package:lianmiapp/pages/lottery/provider/fc3d_provider.dart';
import 'package:lianmiapp/pages/lottery/provider/lottery_provider.dart';
import 'package:lianmiapp/pages/lottery/provider/pl3_provider.dart';
import 'package:lianmiapp/pages/lottery/provider/pl5_provider.dart';
import 'package:lianmiapp/pages/lottery/provider/qlc_provider.dart';
import 'package:lianmiapp/pages/lottery/provider/qxc_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../model/lottery_product_model.dart';
import '../provider/shuang_se_qiu_provider.dart';

enum LotteryTypeEnum {
  unknow,

  ///双色球
  ssq,

  ///大乐透
  dlt,

  ///排列三
  type3,

  ///福彩3d
  fc3d,

  ///七乐彩
  qlc,

  ///排列三
  pl3,

  ///排列五
  pl5,

  ///七星彩
  qxc,

  ///合同协议委托类
  hetong,

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

  
}

// //公证处的智能合约类型枚举
// enum GongzhengchuTypeEnum {
//   unknow,
// }

class LotteryData {
  factory LotteryData() => _getInstance();
  static LotteryData get instance => _getInstance();
  static LotteryData? _instance;
  LotteryData._internal() {}
  static LotteryData _getInstance() {
    if (_instance == null) {
      _instance = LotteryData._internal();
    }
    return _instance!;
  }

  List<LotteryProductModel> _fucaiProducts = [];
  List<LotteryProductModel> _ticaiProducts = [];
  List<LotteryProductModel> _gongzhengchuProducts = [];

  ///福彩所有商品
  List<LotteryProductModel> get fucaiProducts => _fucaiProducts;

  ///体彩所有商品
  List<LotteryProductModel> get ticaiProducts => _ticaiProducts;

  ///公证处的所有商品 - lishijia
  List<LotteryProductModel> get gongzhengchuProducts => _gongzhengchuProducts;

  set fucaiProducts(List<LotteryProductModel> list) {
    _fucaiProducts = list;
  }

  set ticaiProducts(List<LotteryProductModel> list) {
    _ticaiProducts = list;
  }

  set gongzhengchuProducts(List<LotteryProductModel> list) {
    _gongzhengchuProducts = list;
  }

  ///根据商户类型获取列表
  List<LotteryProductModel> getProducts(int storeType) {
    switch (storeType) {
      case 1:
        return _fucaiProducts;
      case 2:
        return _ticaiProducts;
      case 3:
        return _gongzhengchuProducts;

      //TODO lishijia 增加各种商户产品
      default:
        return [];
    }
  }

  ///根据id获取商品信息
  LotteryProductModel? getProduct(int id) {
    for (LotteryProductModel item in _fucaiProducts) {
      if (item.id == id) {
        return item;
      }
    }
    for (LotteryProductModel item in _ticaiProducts) {
      if (item.id == id) {
        return item;
      }
    }

    for (LotteryProductModel item in _gongzhengchuProducts) {
      if (item.id == id) {
        return item;
      }
    }
    return null;
  }

  List<SingleChildWidget> providers = [
    ChangeNotifierProvider.value(value: LotteryProvider()),
    ChangeNotifierProvider.value(value: ShuangseqiuProvider()),
    ChangeNotifierProvider.value(value: DltProvider()),
    ChangeNotifierProvider.value(value: QlcProvider()),
    ChangeNotifierProvider.value(value: Fc3dProvider()),
    ChangeNotifierProvider.value(value: Pl3Provider()),
    ChangeNotifierProvider.value(value: Pl5Provider()),
    ChangeNotifierProvider.value(value: QxcProvider()),
  ];
}
