import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluwx/fluwx.dart';
import 'package:lianmiapp/manager/push_manager.dart';
import 'package:lianmiapp/net/http_api.dart';
import 'package:lianmiapp/pages/product/model/product_model.dart';
import 'package:lianmiapp/pages/product/provider/dlt_provider.dart';
import 'package:lianmiapp/pages/product/provider/fc3d_provider.dart';
import 'package:lianmiapp/pages/product/provider/pl3_provider.dart';
import 'package:lianmiapp/pages/product/provider/pl5_provider.dart';
import 'package:lianmiapp/pages/product/provider/qlc_provider.dart';
import 'package:lianmiapp/pages/product/provider/qxc_provider.dart';
import 'package:lianmiapp/pages/product/provider/shuang_se_qiu_provider.dart';
import 'package:lianmiapp/pages/product/utils/lottery_data.dart';
import 'package:lianmiapp/provider/location_provider.dart';
import 'package:lianmiapp/provider/me/storeInfo_view_model.dart';
import 'package:lianmiapp/provider/me/userInfo_view_model.dart';
import 'package:lianmiapp/provider/store_focus_provider.dart';
import 'package:lianmiapp/util/update_utils.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'adapt.dart';
import 'http_utils.dart';

const _kWXAppId = 'wx93699cc3c641f8a3';

// const _kWXAppId = 'wx9dff85e1c3a3b342';

class App {
  ///判断是否是商户
  static bool isShop = false;

  ///[BuildContext]
  static BuildContext? context;

  static BuildContext? appContext;

  static String? userImagesPath;
  // static WalletNotifier walletNotifier;

  static String? userIMPath;

  static AppLifecycleState lifecycleState = AppLifecycleState.resumed;

  ///下载地址
  static String downloadUrl = '';

  ///初始化数据存储
  static initApp(BuildContext ctx) async {
    appContext = ctx;
    Adapt.init(375);
    await setupUserEverything();

    ///初始化IM管理
    // IMManager.instance.init();

    ///初始化钱包通知
    // walletNotifier = WalletNotifier(0);
    registerWxApi(appId: _kWXAppId, universalLink: "");
  }

  static Future initLinkme() async {
    await appManager.init();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    AppManager.setVersion(version);
    return;
  }

  static String get currentUsername {
    return AuthMod.getLastLoginName() ?? '';
  }

  static String get currentMobile {
    return AppManager.currentMobile ?? '';
  }

  ///初始化用户目录
  static Future setupUserEverything() async {
    PushManager.instance.init();
    if (AppManager.isLogined != true) return;
    Directory appDocDir = await getApplicationDocumentsDirectory();
    var content = new Utf8Encoder().convert(currentUsername);
    var digest = md5.convert(content);
    Directory userDir = Directory(appDocDir.path + '/${digest.toString()}');
    if (!userDir.existsSync()) {
      userDir.createSync();
      // logD('创建用户缓存目录成功:' + userDir.path);
    }
    logD('初始化用户缓存目录成功:' + userDir.path);
    Directory userImgDir = Directory(userDir.path + '/images');
    if (!userImgDir.existsSync()) {
      userImgDir.createSync();
      // print('创建用户图片目录成功:' + userDir.path);
    }
    logD('初始化用户图片目录成功:' + userDir.path);
    Directory userIMDir = Directory(userDir.path + '/im');
    if (!userIMDir.existsSync()) {
      userIMDir.createSync();
      // print('创建用户IM目录成功:' + userDir.path);
    }
    logD('初始化IM目录成功:' + userDir.path);
    userImagesPath = userImgDir.path;
    userIMPath = userIMDir.path;
    Provider.of<UserInfoViewModel>(appContext!, listen: false).updateUserInfo();
    Provider.of<StoreInfoViewModel>(appContext!, listen: false)
        .updateStoreInfo();

    _loadAllProducts();
    Provider.of<StoreFocusProvider>(appContext!, listen: false)
        .updateAllFocusStore();
    Provider.of<LocationProvider>(appContext!, listen: false).setup();
    downloadUrl = await AuthMod.getAppDownloadURL();
    UpdateUtils.checkForUpdate(showLoading: false);
    return;
  }

  //获取所有通用商品 -lishijia
  static _loadAllProducts() {
    HttpUtils.get(HttpApi.generalproducts).then((val) {
      logD('获取所有通用商品:$val');

      List<ProductModel> list = ProductModel.modelListFromJson(val);
      List<ProductModel> fucaiProducts = [];
      List<ProductModel> ticaiProducts = [];
      List<ProductModel> legalAttestProducts = [];

      //TODO 继续增加各种通用智能合约

      list.forEach((element) {
        if (element.productType == 1) {
          fucaiProducts.add(element);
        } else if (element.productType == 2) {
          ticaiProducts.add(element);
        } else if (element.productType == 3) {
          legalAttestProducts.add(element);
        }
      });
      LotteryData.instance.fucaiProducts = fucaiProducts;
      LotteryData.instance.ticaiProducts = ticaiProducts;
      LotteryData.instance.legalAttestProducts = legalAttestProducts;
      _initAllLotteryProvider();
    }).catchError((err) {
      logE(err);
    });
  }

  ///初始化所有的订单provider数据
  static _initAllLotteryProvider() {
    LotteryData.instance.fucaiProducts.forEach((element) {
      switch (LotteryTypeEnum.values[element.id!]) {
        case LotteryTypeEnum.ssq:
          {
            Provider.of<ShuangseqiuProvider>(App.appContext!, listen: false)
                .setup(element.id!);
          }
          break;
        case LotteryTypeEnum.fc3d:
          {
            Provider.of<Fc3dProvider>(App.appContext!, listen: false)
                .setup(element.id!);
          }
          break;
        case LotteryTypeEnum.qlc:
          {
            Provider.of<QlcProvider>(App.appContext!, listen: false)
                .setup(element.id!);
          }
          break;
        default:
      }
    });
    LotteryData.instance.ticaiProducts.forEach((element) {
      switch (LotteryTypeEnum.values[element.id!]) {
        case LotteryTypeEnum.dlt:
          {
            Provider.of<DltProvider>(App.appContext!, listen: false)
                .setup(element.id!);
          }
          break;
        case LotteryTypeEnum.pl3:
          {
            Provider.of<Pl3Provider>(App.appContext!, listen: false)
                .setup(element.id!);
          }
          break;
        case LotteryTypeEnum.pl5:
          {
            Provider.of<Pl5Provider>(App.appContext!, listen: false)
                .setup(element.id!);
          }
          break;
        case LotteryTypeEnum.qxc:
          {
            Provider.of<QxcProvider>(App.appContext!, listen: false)
                .setup(element.id!);
          }
          break;
        default:
      }
    });
  }

  ///处理APP生命周期
  static void handleAppLifecycleState(AppLifecycleState state) {
    lifecycleState = state;
    switch (state) {
      case AppLifecycleState.resumed:
        {
          _handleAppResumed();
        }
        break;
      default:
    }
  }

  ///处理回到APP
  static void _handleAppResumed() {
    logD('回到APP处理事务');

    ///重新回到APP需要获取一下定位
    Provider.of<LocationProvider>(appContext!, listen: false).getLocation();
  }
}
