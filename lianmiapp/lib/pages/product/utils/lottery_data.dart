import 'package:lianmiapp/pages/product/provider/dlt_provider.dart';
import 'package:lianmiapp/pages/product/provider/fc3d_provider.dart';
import 'package:lianmiapp/pages/product/provider/lottery_provider.dart';
import 'package:lianmiapp/pages/product/provider/pl3_provider.dart';
import 'package:lianmiapp/pages/product/provider/pl5_provider.dart';
import 'package:lianmiapp/pages/product/provider/qlc_provider.dart';
import 'package:lianmiapp/pages/product/provider/qxc_provider.dart';
import 'package:lianmiapp/pages/product/provider/standart_provider.dart';
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

  ///其它彩种
  standart,

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

  //足彩
  zucai,

  //篮球
  lanqiu,

  kuaile8,
}

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

  List<ProductModel> _fucaiProducts = []; //福彩
  List<ProductModel> _ticaiProducts = []; //体彩
  List<ProductModel> _legalAttestProducts = []; //公证处
  List<ProductModel> _lawFirmProducts = []; //律师事务所
  List<ProductModel> _insuranceProducts = []; //保险公司
  List<ProductModel> _governmentProducts = []; //政府部门
  List<ProductModel> _designProducts = []; //设计公司
  List<ProductModel> _intellectualPropertyProducts = []; //知识产权
  List<ProductModel> _artworkProducts = []; //艺术品

  ///福彩所有商品
  List<ProductModel> get fucaiProducts => _fucaiProducts;

  ///体彩所有商品
  List<ProductModel> get ticaiProducts => _ticaiProducts;

  ///公证处的所有商品 - lishijia
  List<ProductModel> get legalAttestProducts => _legalAttestProducts;

  //律师事务所的所有商品 - lishijia
  List<ProductModel> get lawFirmProducts => _lawFirmProducts;

  //保险公司的所有商品 - lishijia
  List<ProductModel> get insuranceProducts => _insuranceProducts;

  //政府部门的所有商品 - lishijia
  List<ProductModel> get governmentProducts => _governmentProducts;

  //设计公司的所有商品 - lishijia
  List<ProductModel> get designProducts => _designProducts;

  List<ProductModel> get intellectualPropertyProducts =>
      _intellectualPropertyProducts;

  List<ProductModel> get artworkProducts => _artworkProducts;

  set fucaiProducts(List<ProductModel> list) {
    _fucaiProducts = list;
  }

  set ticaiProducts(List<ProductModel> list) {
    _ticaiProducts = list;
  }

  set legalAttestProducts(List<ProductModel> list) {
    _legalAttestProducts = list;
  }

  set lawFirmProducts(List<ProductModel> list) {
    _lawFirmProducts = list;
  }

  set insuranceProducts(List<ProductModel> list) {
    _insuranceProducts = list;
  }

  set governmentProducts(List<ProductModel> list) {
    _governmentProducts = list;
  }

  set designProducts(List<ProductModel> list) {
    _designProducts = list;
  }

  set intellectualPropertyProducts(List<ProductModel> list) {
    _intellectualPropertyProducts = list;
  }

  set artworkProducts(List<ProductModel> list) {
    _artworkProducts = list;
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
      case 4:
        return _lawFirmProducts;

      case 5:
        return _insuranceProducts;

      case 6:
        return _governmentProducts;

      case 7:
        return _designProducts;

      case 8:
        return _intellectualPropertyProducts;

      case 9:
        return _artworkProducts;

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

    for (ProductModel item in _lawFirmProducts) {
      if (item.id == id) {
        return item;
      }
    }

    for (ProductModel item in _insuranceProducts) {
      if (item.id == id) {
        return item;
      }
    }

    for (ProductModel item in _governmentProducts) {
      if (item.id == id) {
        return item;
      }
    }

    for (ProductModel item in _designProducts) {
      if (item.id == id) {
        return item;
      }
    }

    for (ProductModel item in _intellectualPropertyProducts) {
      if (item.id == id) {
        return item;
      }
    }

    for (ProductModel item in _artworkProducts) {
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
    ChangeNotifierProvider.value(value: StandartProvider()),
  ];
}
