import 'package:fluro/fluro.dart';
import 'package:lianmiapp/pages/lottery/page/dlt_page.dart';
import 'package:lianmiapp/pages/lottery/page/fc3d_page.dart';
import 'package:lianmiapp/pages/lottery/page/pl3_page.dart';
import 'package:lianmiapp/pages/lottery/page/pl5_page.dart';
import 'package:lianmiapp/pages/lottery/page/qlc_page.dart';
import 'package:lianmiapp/pages/lottery/page/qxc_page.dart';
import 'package:lianmiapp/routers/i_router.dart';
import 'page/shuangseqiu_page.dart';

class LotteryRouter implements IRouterProvider {
  static String shuangseqiuPage = '/lottery/shuangseqiu';
  static String dltPage = '/lottery/dlt';
  static String qlcPage = '/lottery/qlc';
  static String fc3dPage = '/lottery/fc3d';
  static String pl3Page = '/lottery/pl3';
  static String pl5Page = '/lottery/pl5';
  static String qxcPage = '/lottery/qxc';

  @override
  void initRouter(FluroRouter router) {
    router.define(shuangseqiuPage, handler: Handler(handlerFunc: (_, params) {
      final String? businessUsername = params['businessUsername']?.first;
      final int id = int.parse(params['id']!.first);
      return ShuangseqiuPage(businessUsername!,id);
    }));
    router.define(dltPage, handler: Handler(handlerFunc: (_, params) {
      final String businessUsername = params['businessUsername']!.first;
      final int id = int.parse(params['id']!.first);
      return DltPage(businessUsername,id);
    }));
    router.define(qlcPage, handler: Handler(handlerFunc: (_, params) {
      final String businessUsername = params['businessUsername']!.first;
      final int id = int.parse(params['id']!.first);
      return QlcPage(businessUsername,id);
    }));
    router.define(fc3dPage, handler: Handler(handlerFunc: (_, params) {
      final String businessUsername = params['businessUsername']!.first;
      final int id = int.parse(params['id']!.first);
      return Fc3dPage(businessUsername,id);
    }));
    router.define(pl3Page, handler: Handler(handlerFunc: (_, params) {
      final String businessUsername = params['businessUsername']!.first;
      final int id = int.parse(params['id']!.first);
      return Pl3Page(businessUsername,id);
    }));
    router.define(pl5Page, handler: Handler(handlerFunc: (_, params) {
      final String businessUsername = params['businessUsername']!.first;
      final int id = int.parse(params['id']!.first);
      return Pl5Page(businessUsername,id);
    }));
    router.define(qxcPage, handler: Handler(handlerFunc: (_, params) {
      final String businessUsername = params['businessUsername']!.first;
      final int id = int.parse(params['id']!.first);
      return QxcPage(businessUsername,id);
    }));
  }
}
