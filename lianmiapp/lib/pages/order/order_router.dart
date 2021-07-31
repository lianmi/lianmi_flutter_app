import 'package:fluro/fluro.dart';
import 'package:lianmiapp/routers/i_router.dart';
import 'page/order_page.dart';
import 'page/order_search_page.dart';

class OrderRouter implements IRouterProvider {
  static String orderPage = '/order';
  static String orderInfoPage = '/order/info';
  static String orderSearchPage = '/order/search';
  static String orderTrackPage = '/order/track';

  @override
  void initRouter(FluroRouter router) {
    router.define(orderPage,
        handler: Handler(handlerFunc: (_, __) => OrderPage()));
    router.define(orderSearchPage,
        handler: Handler(handlerFunc: (_, __) => OrderSearchPage()));
  }
}
