import 'package:fluro/fluro.dart';
import 'package:lianmiapp/routers/i_router.dart';
import 'page/discovery_search_page.dart';
import 'page/store_page.dart';
// import 'page/product_detail_page.dart';

/// 发现相关的路由
class DiscoveryRouter implements IRouterProvider {
  static String searchPage = '/discovery/search';
  static String storePage = '/discovery/store';
  static String productDetailPage = '/discovery/productDetail';

  @override
  void initRouter(FluroRouter router) {
    router.define(searchPage,
        handler: Handler(handlerFunc: (_, __) => DiscoverySearchPage()));
    router.define(storePage, handler: Handler(handlerFunc: (_, params) {
      final String businessUsername = params['businessUsername']!.first;
      return StorePage(businessUsername);
    }));
    router.define(productDetailPage, handler: Handler(handlerFunc: (_, params) {
      final String businessUsername = params['businessUsername']!.first;
      final String productId = params['productId']!.first;
      // return ProductDetailPage(businessUsername,productId);
    }));
  }
}
