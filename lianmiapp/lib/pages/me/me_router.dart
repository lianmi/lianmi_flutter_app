import 'package:fluro/fluro.dart';
import 'package:lianmiapp/pages/me/page/user_center_page.dart';
import 'package:lianmiapp/routers/i_router.dart';

/// 我的 相关的路由
class MeRouter implements IRouterProvider {
  String mehome = "me/home";
  @override
  void initRouter(FluroRouter router) {
    router.define(mehome, handler: Handler(handlerFunc: (_, params) {
      return UserCenterPage();
    }));
  }
}
