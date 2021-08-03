import 'package:lianmiapp/pages/product/provider/dlt_provider.dart';
import 'package:lianmiapp/pages/product/provider/fc3d_provider.dart';
import 'package:lianmiapp/pages/product/provider/lottery_provider.dart';
import 'package:lianmiapp/pages/product/provider/pl3_provider.dart';
import 'package:lianmiapp/pages/product/provider/pl5_provider.dart';
import 'package:lianmiapp/pages/product/provider/qlc_provider.dart';
import 'package:lianmiapp/pages/product/provider/qxc_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../model/product_model.dart';
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
// enum LegalAttestTypeEnum {
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

  List<ProductModel> _fucaiProducts = [];
  List<ProductModel> _ticaiProducts = [];
  List<ProductModel> _legalAttestProducts = [];

  ///福彩所有商品
  List<ProductModel> get fucaiProducts => _fucaiProducts;

  ///体彩所有商品
  List<ProductModel> get ticaiProducts => _ticaiProducts;

  ///公证处的所有商品 - lishijia
  List<ProductModel> get legalAttestProducts => _legalAttestProducts;

  set fucaiProducts(List<ProductModel> list) {
    _fucaiProducts = list;
  }

  set ticaiProducts(List<ProductModel> list) {
    _ticaiProducts = list;
  }

  set legalAttestProducts(List<ProductModel> list) {
    _legalAttestProducts = list;
  }

  ///根据商户类型获取列表
  List<ProductModel> getProducts(int storeType) {
    switch (storeType) {
      case 1:
        return _fucaiProducts;
      case 2:
        return _ticaiProducts;
      case 3:
        return _legalAttestProducts;

      //TODO lishijia 增加各种商户产品
      default:
        return [];
    }
  }

  ///根据id获取商品信息
  ProductModel? getProduct(int id) {
    for (ProductModel item in _fucaiProducts) {
      if (item.id == id) {
        return item;
      }
    }
    for (ProductModel item in _ticaiProducts) {
      if (item.id == id) {
        return item;
      }
    }

    for (ProductModel item in _legalAttestProducts) {
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
