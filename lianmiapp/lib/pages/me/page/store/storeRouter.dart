import 'package:fluro/fluro.dart';
import 'package:lianmiapp/pages/me/page/store/storeCenterPage.dart';
import 'package:lianmiapp/routers/i_router.dart';

class StoreRegRouter implements IRouterProvider {
  static String toStorePage = '/me/store';

  @override
  void initRouter(FluroRouter router) {
    router.define(toStorePage, handler: Handler(handlerFunc: (_, params) {
      return storeRegCenterPage();
    }));
  }
}
