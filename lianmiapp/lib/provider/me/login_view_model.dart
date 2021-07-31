import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/net/http_api.dart';
import 'package:lianmiapp/provider/linkme_provider.dart';
import 'package:lianmiapp/util/http_utils.dart';
import 'package:oktoast/oktoast.dart';
import 'package:lianmiapp/util/app.dart';

class LoginViewModel extends ChangeNotifier {
  TextEditingController? _phone;

  ///手机号码
  TextEditingController? _idCode;

  ///验证码
  int _loginType = 0;

  ///0 是用户， 1是商户
  bool _isAgree = true;
  bool _isSub = false;

  ///是否可提交
  String _timerText = '获取验证码';
  int _timerNum = 59;
  Timer? _timer;

  String get timerText => _timerText;
  bool get isAgree => _isAgree;
  bool get isSub => _isSub;
  int get loginType => _loginType;
  TextEditingController? get phone => _phone;
  TextEditingController? get idCode => _idCode;

  StreamSubscription? wxSubscription;

  LoginViewModel() {
    _phone = TextEditingController();
    _idCode = TextEditingController();
  }

  ///发送手机校验码
  Future _sendSms(var lastMobile) async {
    var value = await AuthMod.getSmscode(lastMobile);
    logD("AuthMod.sendSms code = ${value['code']} , msg = ${value['msg']}");
    return;
  }

  ///获取验证码
  void getCode() async {
    if (_phone!.text.length == 11 && _timerText == '获取验证码') {
      var _data = await HttpUtils.get(HttpApi.sms + _phone!.text);
      logD('获取到的数据:' + _data.toString());

      _timerText = '获取($_timerNum)';
      notifyListeners();
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        _timerNum -= 1;
        _timerText = '获取($_timerNum)';
        notifyListeners();
        if (_timerNum < 1) {
          _timerNum = 59;
          _timerText = '获取验证码';
          _timer?.cancel();
          _timer = null;
          return;
        }
      });
    } else {
      showToast('请先输入11位的手机号码');
    }
  }

  ///修改登录类型
  void changeLoginType(int _type) {
    this._loginType = _type;
    notifyListeners();
  }

  ///写入同意协议
  void setAgree() {
    logD('同意协议?');
    _isAgree = !_isAgree;
    notifyListeners();
  }

  ///检验是否可提交
  void checkSub() {
    if (_phone!.text.length == 11 && _idCode!.text.length == 6 && _isAgree) {
      _isSub = true;
    } else {
      _isSub = false;
    }
    notifyListeners();
  }

  ///提交
  void sub(BuildContext context) async {
    if (_isAgree) {
      if (_isSub) {
        ///用户提交
        //登录手机号
        HubView.showLoading();
        var _mobile = _phone!.text;
        await _sendSms(_mobile);
        var f = AuthMod.login(
            LoginType.LoginType_Mobile, _mobile, "654321", "123456", true, 1);

        f.then((value) {
          HubView.dismiss();
          String lastLoginToken = AuthMod.getLastLoginToken() ?? '';
          if (lastLoginToken != '') {
            logD("lastLoginToken : ${lastLoginToken}");
          }
          logD(AppManager.isLogined);
          _handleUserAfterLogin();
          App.setupUserEverything();
          Provider.of<LinkMeProvider>(App.appContext!, listen: false)
              .loginSuccess();
        }).catchError((error) {
          HubView.showToastAfterLoadingHubDismiss(error);
        });
      } else {
        showToast('请输入正确的手机号码和验证码');
      }
    } else {
      showToast('请先勾选同意协议');
    }
  }

  void wxLogin() {
    if (_isAgree) {
      wxSubscription = fluwx.weChatResponseEventHandler.listen((res) async {
        if (res is fluwx.WeChatAuthResponse) {
          _handleWXLoginData(res.code!);
        }
      });
      fluwx.sendWeChatAuth(scope: "snsapi_userinfo", state: "lianmi");
    } else {
      showToast('请先勾选同意协议');
    }
  }

  void _handleWXLoginData(String code) {
    wxSubscription!.cancel();
    logI('微信code:$code');

    HubView.showLoading();
    AuthMod.wxlogin(code).then((value) async {
      logD(value);
      if (isValidString(App.currentMobile)) {
        await _loginSuccess();
      } else {
        Provider.of<LinkMeProvider>(App.appContext!, listen: false)
            .bindMobile();
      }
      HubView.dismiss();
    }).catchError((err) {
      HubView.dismiss();
      HubView.showToastAfterLoadingHubDismiss('登录失败:$err');
    });
  }

  Future _loginSuccess() async {
    await UserMod.getMyProfile();
    _handleUserAfterLogin();
    await App.setupUserEverything();
    Provider.of<LinkMeProvider>(App.appContext!, listen: false).loginSuccess();
  }

  void _handleUserAfterLogin() {
    UserTypeEnum lastUserType = AuthMod.getLastLoginUserType();
    // 判断用户类型
    switch (lastUserType) {
      case UserTypeEnum.UserTypeEnum_Normal:
        {
          App.isShop = false;
        }
        break;

      case UserTypeEnum.UserTypeEnum_Business:
        {
          App.isShop = true;
        }
        break;

      default:
        {
          logW("Unsupported UserType : ${lastUserType}");
        }
        break;
    }
  }

  void loginID58(BuildContext context) {
    _phone!.text = '13577912348';
    _idCode!.text = '123456';
    checkSub();
    sub(context);
  }

  void dispose() {
    _phone?.clear();
    _idCode?.clear();
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }
}
