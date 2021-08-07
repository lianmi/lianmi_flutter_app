import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lianmiapp/pages/account/account_router.dart';
import 'package:lianmiapp/pages/discovery/discovery_router.dart';
import 'package:lianmiapp/pages/home/home_page_shop.dart';
import 'package:lianmiapp/pages/home/home_page_user.dart';
import 'package:lianmiapp/pages/login/login_router.dart';
import 'package:lianmiapp/pages/product/lottery_router.dart';
import 'package:lianmiapp/pages/legalattest/legalattest_router.dart';
//TODO 增加其它类型的商品路由
import 'package:lianmiapp/pages/me/me_router.dart';
import 'package:lianmiapp/pages/me/page/store/storeRouter.dart';
import 'package:lianmiapp/pages/order/order_router.dart';
import 'package:lianmiapp/pages/store/store_router.dart';
import 'package:lianmiapp/routers/i_router.dart';
import 'package:lianmiapp/routers/not_found_page.dart';

// ignore: avoid_classes_with_only_static_members
class Routes {
  static String homeUserPage = '/homeUserPage';
  static String homeShopPage = '/homeShopPage';
  static String home = homeUserPage;
  static String webViewPage = '/webView';

  ///主页面路由在该位置改变
  void isShop() {
    home = homeShopPage;
  }

  static final List<IRouterProvider> _listRouter = [];

  static final FluroRouter router = FluroRouter();

  static void initRoutes() {
    /// 指定路由跳转错误返回页
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      debugPrint('未找到目标页');
      return NotFoundPage();
    });

    router.define(homeUserPage,
        handler: Handler(
            handlerFunc:
                (BuildContext? context, Map<String, List<String>> params) =>
                    HomePageUser()));
    router.define(homeShopPage,
        handler: Handler(
            handlerFunc:
                (BuildContext? context, Map<String, List<String>> params) =>
                    HomePageShop()));

    // router.define(webViewPage, handler: Handler(handlerFunc: (_, params) {
    //   final String? title = params['title']?.first;
    //   final String? url = params['url']?.first;
    //   return WebViewPage(title: title!, url: url!);
    // }));

    _listRouter.clear();

    /// 各自路由由各自模块管理，统一在此添加初始化
    _listRouter.add(LoginRouter());
    _listRouter.add(OrderRouter());
    _listRouter.add(StoreRouter());
    _listRouter.add(AccountRouter());
    _listRouter.add(DiscoveryRouter());
    _listRouter.add(LotteryRouter());
    _listRouter.add(LegalAttestRouter());
    //TODO: add by lishijia

    _listRouter.add(MeRouter());
    _listRouter.add(StoreRegRouter());

    /// 初始化路由
    _listRouter.forEach((routerProvider) {
      routerProvider.initRouter(router);
    });
  }
}
