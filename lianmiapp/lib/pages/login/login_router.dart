import 'package:fluro/fluro.dart';
import 'package:lianmiapp/pages/login/page/login_page.dart';
import 'package:lianmiapp/routers/i_router.dart';


class LoginRouter implements IRouterProvider {
  static String loginPage = '/login';
  static String registerPage = '/login/register';
  // static String smsLoginPage = '/login/smsLogin';
  static String registerBusinessPage = '/login/registerBusiness';
  static String resetPasswordPage = '/login/resetPassword';
  static String updatePasswordPage = '/login/updatePassword';
  ///商户上传证件
  static String businessSelectCertificate = '/login/businessSelectCertificate';

  @override
  void initRouter(FluroRouter router) {
    router.define(loginPage,
        handler: Handler(handlerFunc: (_, __) => LoginPage()));
    // router.define(smsLoginPage,
    //     handler: Handler(handlerFunc: (_, __) => SMSLoginPage()));
  }
}
