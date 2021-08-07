/*
 鉴权授权模块
 */
import 'package:linkme_flutter_sdk/common/http_utils.dart';
import 'package:linkme_flutter_sdk/common/urls.dart';
import 'package:linkme_flutter_sdk/manager/EventsManagers.dart';
import 'package:linkme_flutter_sdk/models/SystemMsgInfo.dart';
import 'package:linkme_flutter_sdk/models/login_entity.dart';
import 'package:linkme_flutter_sdk/manager/AppManager.dart';
import 'dart:async';
import 'package:linkme_flutter_sdk/base_enum.dart';
import 'package:linkme_flutter_sdk/net/wsHandler.dart';
import 'package:linkme_flutter_sdk/models/LastuserInfo.dart';
import 'SdkEnum.dart';
import 'package:linkme_flutter_sdk/manager/LogManager.dart';

/// @nodoc 授权鉴权类
class AuthMod {
  /// @nodoc 申请短信验证码
  static Future getSmscode(String mobile) async {
    try {
      var _data = await HttpUtils.get(
        HttpApi.smscode + '/' + mobile,
      );
      return _data;
    } catch (e) {
      logE(e);
    } finally {
      logD('AuthMod.getSmscode end.');
    }
  }

  /// @nodoc 登录, 当type=1， 用户注册号登录， 当type=2时，用手机号
  static Future login(LoginType type, String mobile, String password,
      String smscode, bool ismaster, int userType) async {
    Completer _completer = new Completer.sync();

    await AppManager.setMobile(mobile);
    var _map = {
      "mobile": mobile,
      "smscode": smscode, //暂未发送验证码，暂代
      "os": AppManager.os,
      "wechat_code": ""
    };

    logV('_map: ${_map}');

    ///提交数据
    try {
      var _body = await HttpUtils.post(HttpApi.login, data: _map);
      // logD('_body: $_body');

      var code = _body['code'];
      if (code == 200) {
        var _loginData = _body['data'];
        LoginEntity _login = LoginEntity.fromMap(_loginData);
        logD('登录回包: ${_login}');

        ///写入token
        AppManager.setIsLogined(true);
        AppManager.setLatestLoginTimeAt(DateTime.now().millisecondsSinceEpoch);
        AppManager.setUsername(_login.username!);
        await AppManager.setMobile(_login.mobile);
        AppManager.setJwtToken(_login.jwtToken!);
        AppManager.setUserType(_login.userType!);
        AppManager.setUserState(_login.state!);

        //登录成功后，需要根据username连接数据库
        bool isCreated = await appManager.initUserIsolate();
        String publicKey = '';
        String privateKey = '';
        if (isCreated) {
          bool isConnected = await AppManager.gRepository!.init(); //必须先create
          if (isConnected) {
            logD('数据库进程初始化成功');

            /// 初始化各种业务事件
            eventsManagers.init();

            //连接ws server
            websocketfactory.create(AppManager.currentToken!);
            websocketfactory.doLogin();

            _completer.complete(_login);
          } else {
            logE('数据库进程初始化失败');
          }
        }
      } else {
        logE("login fail , ${_body['code']} , msg ${_body['msg']}");
        return new Future.error('授权失败,错误信息:  ${_body['msg']}');
      }
    } catch (e) {
      logE(e);
      return new Future.error('授权失败，请你检查账号及密码');
    } finally {
      logD('AuthMod.login end.');
    }

    return _completer.future;
  }

  /// @nodoc 微信登录
  static Future wxlogin(String wechatCode) async {
    var _map;

    Completer _completer = new Completer.sync();

    _map = {
      "username": '',
      "password": '',
      "mobile": '',
      "smscode": '',
      "usertype": 3,
      "os": AppManager.os,
      "wechat_code": wechatCode,
      "sdkversion": "3.0",
      "ismaster": true
    };

    logD('wxlogin: ${wechatCode}');

    ///提交数据
    try {
      var _body = await HttpUtils.post(HttpApi.login, data: _map);
      // logD('_body: $_body');

      var code = _body['code'];
      if (code == 200) {
        var _loginData = _body['data'];
        LoginEntity _login = LoginEntity.fromMap(_loginData);
        logD('登录回包: ${_login.toString()}');

        ///写入token
        AppManager.setIsLogined(true);
        AppManager.setLatestLoginTimeAt(DateTime.now().millisecondsSinceEpoch);
        AppManager.setUsername(_login.username!); //TODO: 必须有值
        await AppManager.setMobile(_login.mobile); //TODO:  可能没值
        AppManager.setJwtToken(_login.jwtToken!);
        AppManager.setUserType(_login.userType!);
        AppManager.setUserState(_login.state!);

        //登录成功后，需要根据username连接数据库
        bool isCreated = await appManager.initUserIsolate();
        String publicKey = '';
        String privateKey = '';
        if (isCreated) {
          bool isConnected = await AppManager.gRepository!.init(); //必须先create
          if (isConnected) {
            logD('数据库进程初始化成功');

            /// 初始化各种业务事件
            eventsManagers.init();

            //连接ws server
            websocketfactory.create(AppManager.currentToken!);
            websocketfactory.doLogin();

            _completer.complete(_login);
          } else {
            logE('数据库进程初始化失败');
            return new Future.error('数据库进程初始化失败');
          }
        }
      } else {
        logE("wxlogin fail , ${_body['code']} , msg ${_body['msg']}");
        return new Future.error('授权失败,错误信息:  ${_body['msg']}');
      }
    } catch (e) {
      logE(e);
      return new Future.error('授权失败，请你检查账号及密码');
    }

    return _completer.future;
  }

  /// @nodoc 获取最后一次登陆的 用户信息
  static Future<LastUserInfo> getLastUserInfo() async {
    if (AppManager.gRepository == null) {
      return new Future.error('没初始化gRepository');
    }
    LastUserInfo lastUserInfo = new LastUserInfo();

    lastUserInfo.username = AppManager.currentUsername;
    lastUserInfo.mobile = AppManager.currentMobile;
    lastUserInfo.jwtToken = AppManager.currentToken;
    lastUserInfo.userType = AppManager.currentUserType.index;
    lastUserInfo.state = AppManager.currentUserState;
    lastUserInfo.updateTime = AppManager.latestLoginTimeAt;

    return lastUserInfo;
  }

  /// @nodoc 获取最后一次登陆的 用户类型
  static UserTypeEnum getLastLoginUserType() {
    return AppManager.currentUserType;
  }

  /// @nodoc 获取最后一次登陆的 用户Token
  static String? getLastLoginToken() {
    return AppManager.currentToken;
  }

  /// @nodoc 获取最后一次登陆的用户名
  static String? getLastLoginName() {
    return AppManager.currentUsername;
  }

  /// @nodoc 获取最后一次登陆的用户的状态
  static int? getLastLoginState() {
    return AppManager.currentUserState;
  }

  /// @nodoc 查询商户是否在线
  /// userId - 商户注册id
  static Future isOnline(String userId) async {
    try {
      Map<String, dynamic> params = new Map<String, dynamic>();
      params['userId'] = userId;
      var _body = await HttpUtils.get(HttpApi.online, params: params);
      // logD('_body: $_body');
      var code = _body['code'];
      if (code == 200) {
        return _body['data']['online'];
      } else {
        return false;
      }
    } catch (e) {
      logE(e);
    } finally {
      logD('AuthMod.isOnline end.');
    }
  }

  ///@nodoc 登出 signout
  static Future signout() async {
    websocketfactory.logout();

    //断开ws连接
    websocketfactory.logout();

    //登出成功
    appManager.clearCache();

    if (AppManager.isLogined) {
      logD('AuthMod.signout start...');
      try {
        var _body = await HttpUtils.get(HttpApi.signout);
        // logD('_body: $_body');
        if (_body['code'] == 200) {
          return true;
        } else {
          logE("登出出错, ${_body['code']} , msg ${_body['msg']}");
          return new Future.error('登出失败,错误信息:  ${_body['msg']}');
        }
      } catch (e) {
        logE('登出出错, $e');
        return Future.error('登出出错');
      } finally {
        logD('Signout end.');
      }
    }
  }

  ///@nodoc 用户扫描二维码
  static Future getAppDownloadURL() async {
    if (AppManager.isLogined) {
      // logD('AuthMod.getAppDownloadURL start...');
      try {
        var _body = await HttpUtils.get(HttpApi.qrcodeUrl);
        // logD('_body: $_body');
        if (_body['code'] == 200) {
          // logD('getAppDownloadURL success.');
          return _body['data'];
        } else {
          logE("用户扫描二维码, ${_body['code']} , msg ${_body['msg']}");
          return new Future.error('用户扫描二维码,错误信息:  ${_body['msg']}');
        }
      } catch (e) {
        logE('getAppDownloadURL出错, $e');
        return Future.error('getAppDownloadURL出错');
      }
    } else {
      logW('请先登录');
    }
  }

  ///@nodoc 获取服务条款
  static Future getFuwutiaokuan() async {
    if (AppManager.isLogined) {
      // logD('AuthMod.getFuwutiaokuan start...');
      try {
        var _body = await HttpUtils.get(HttpApi.fuwutiaokuan);
        // logD('_body: $_body');
        if (_body['code'] == 200) {
          // logD('getFuwutiaokuan success.');
          return _body['data'];
        } else {
          logE("获取服务条款, ${_body['code']} , msg ${_body['msg']}");
          return new Future.error('获取服务条款,错误信息:  ${_body['msg']}');
        }
      } catch (e) {
        logE('getFuwutiaokuan出错, $e');
        return Future.error('getFuwutiaokuan出错');
      }
    } else {
      logW('请先登录');
    }
  }

  ///curVersion - 当前版本号
  static Future checkUpdate() async {
    // logD('AuthMod.checkUpdate start...');
    try {
      Map<String, dynamic> params = new Map<String, dynamic>();
      params['version'] = AppManager.curVersion;
      params['os'] = AppManager.os ?? 'android';

      // logD('checkUpdate params: $params');

      var _body = await HttpUtils.get(HttpApi.checkUpdate, params: params);
      // logD('_body: $_body');
      if (_body['code'] == 200) {
        // logD('checkUpdate success.');
        return _body['data'];
      } else {
        logE("检测新版本出错 , ${_body['code']} , msg ${_body['msg']}");
        return new Future.error('检测新版本出错 ,错误信息:  ${_body['msg']}');
      }
    } catch (e) {
      logE('checkUpdate出错, $e');
      return Future.error('checkUpdate出错');
    }
  }

  /// 获取系统公告
  static Future getSystemMsgs({int limit = 20, int page = 0}) async {
    Completer _completer = new Completer.sync();
    Future _c = _completer.future;

    // logD('AuthMod.getSystemMsgs start...');

    try {
      Map<String, dynamic> params = new Map<String, dynamic>();
      params['page'] = page;
      params['limit'] = limit;

      // logD('getSystemMsgs params: $params');

      var _body = await HttpUtils.get(HttpApi.systemMsgs, params: params);
      if (_body['code'] == 200) {
        // List<SystemMsgInfo> _infos = [];
        // _body['data'].forEach((v) {
        //   SystemMsgInfo info = new SystemMsgInfo.fromMap(v);
        //   _infos.add(info);
        // });
        _completer.complete(_body['data']); //返回

      } else {
        _completer.completeError('获取系统公告出错');
      }
    } catch (e) {
      logE('获取系统公告出错, $e');
      return Future.error('获取系统公告出错');
    }
    return _c;
  }
}
