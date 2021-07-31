import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
import 'package:lianmiapp/header/common_header.dart';

class LinkMeProvider<T> extends ChangeNotifier {
  ///是否登录
  bool get isLogin {
    if (AppManager.isLogined) {
      return true;
    } else {
      return false;
    }
  }

  ///是否绑定手机号
  bool get isBindMobile {
    if (AppManager.isLogined &&
        AppManager.currentMobile != null &&
        AppManager.currentMobile!.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void loginSuccess() {
    logI('登陆成功通知');
    notifyListeners();
  }

  void bindMobile() {
    logI('登陆成功通知');
    notifyListeners();
  }

  void logoutSuccess() {
    logI('退出通知');
    notifyListeners();
  }
}
