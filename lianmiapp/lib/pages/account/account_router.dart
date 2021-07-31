import 'package:fluro/fluro.dart';
import 'package:lianmiapp/routers/i_router.dart';

/// 账号相关的路由
class AccountRouter implements IRouterProvider {
  static String accountPage = '/account';
  static String accountRecordListPage = '/account/recordList';
  static String addWithdrawalAccountPage = '/account/addWithdrawal';
  static String bankSelectPage = '/account/bankSelect';
  static String citySelectPage = '/account/citySelect';
  static String withdrawalAccountListPage = '/account/withdrawalAccountList';
  static String withdrawalAccountPage = '/account/withdrawalAccount';
  static String withdrawalPage = '/account/withdrawal';
  static String withdrawalPasswordPage = '/account/withdrawalPassword';
  static String withdrawalRecordListPage = '/account/withdrawalRecordList';
  static String withdrawalResultPage = '/account/withdrawalResult';

  @override
  void initRouter(FluroRouter router) {
  }
}
