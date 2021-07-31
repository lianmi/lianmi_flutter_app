import 'package:fluro/fluro.dart';
import 'package:lianmiapp/pages/gongzhengchu/page/hetong_page.dart';
import 'package:lianmiapp/pages/gongzhengchu/page/zhaotoubiao_page.dart';

import 'package:lianmiapp/routers/i_router.dart';

class GongzhengchuRouter implements IRouterProvider {
  static String hetongPage = '/gongzhengchu/hetong'; //合同协议委托类
  static String zhaotoubiaoPage = '/gongzhengchu/zhaotoubiao'; //声明招标投标类
  //TODO  需要继续增加

  @override
  void initRouter(FluroRouter router) {
    router.define(hetongPage, handler: Handler(handlerFunc: (_, params) {
      final String? productId = params['productId']?.first;
      final int? productPrice = int.parse(params['productPrice']!.first);
      final String? businessUsername = params['businessUsername']?.first;
      final int id = int.parse(params['id']!.first);
      return HetongPage(productId!, productPrice!, businessUsername!, id);
    }));
    router.define(zhaotoubiaoPage, handler: Handler(handlerFunc: (_, params) {
      final String? productId = params['productId']?.first;
      final int? productPrice = int.parse(params['productPrice']!.first);
      final String? businessUsername = params['businessUsername']?.first;
      final int id = int.parse(params['id']!.first);
      return ZhaotoubiaoPage(productId!, productPrice!, businessUsername!, id);
    }));
    //TODO  需要继续增加
  }
}
