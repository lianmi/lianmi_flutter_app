import 'package:fluro/fluro.dart';
import 'package:lianmiapp/routers/i_router.dart';
import 'page/store_audit_result_page.dart';

class StoreRouter implements IRouterProvider {
  static String auditPage = '/store/audit';
  static String auditResultPage = '/store/auditResult';

  @override
  void initRouter(FluroRouter router) {
    router.define(auditResultPage,
        handler: Handler(handlerFunc: (_, __) => StoreAuditResultPage()));
  }
}
