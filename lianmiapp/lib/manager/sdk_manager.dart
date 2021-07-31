import 'dart:async';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';

class SDKManager {
  factory SDKManager() => _getInstance();
  static SDKManager get instance => _getInstance();
  static SDKManager? _instance;
  SDKManager._internal() {}
  static SDKManager _getInstance() {
    if (_instance == null) {
      _instance = new SDKManager._internal();
    }
    return _instance!;
  }

  StreamSubscription? _wxSubscription;

  void init() async {}

  ///获取当前用户的userId
  String get userId {
    return AuthMod.getLastLoginName() ?? '';
  }

  ///判断是否我自己
  bool isMe(String username) {
    return AuthMod.getLastLoginName() == username;
  }

  Future bindWX() {
    Completer completer = Completer();
    _wxSubscription = fluwx.weChatResponseEventHandler.listen((res) async {
      if (res is fluwx.WeChatAuthResponse) {
        _handleWXLoginData(res.code!, completer);
      }
    });
    fluwx.sendWeChatAuth(scope: "snsapi_userinfo", state: "lianmi");
    return completer.future;
  }

  void _handleWXLoginData(String code, Completer completer) async {
    _wxSubscription!.cancel();
    try {
      var result = await UserMod.userBindWechat(code);
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
  }

  Future isBindWechat() {
    return UserMod.isBindWechat();
  }

  Future<Map<String, dynamic>> loadPushSetting() async {
    try {
      var result = await UserMod.getPushSetting();
      return result as Map<String, dynamic>;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future modifyPushSetting({
    required bool newRemind,
    required bool detail,
    required bool sound,
  }) {
    return UserMod.modifyPushSetting(newRemind, detail, sound);
  }
}
