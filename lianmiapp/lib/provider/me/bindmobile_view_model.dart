import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/provider/linkme_provider.dart';
import 'package:oktoast/oktoast.dart';
import 'package:lianmiapp/util/app.dart';

class BindMobileViewModel extends ChangeNotifier {
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

  BindMobileViewModel() {
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
      HubView.showLoading();
      await AuthMod.getSmscode(_phone!.text);
      HubView.dismiss();

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
        HubView.showLoading();
        UserMod.userBindMobile(_phone!.text, _idCode!.text).then((value) async {
          logD(value);
          await _loginSuccess();
          HubView.dismiss();
        }).catchError((err) {
          HubView.dismiss();
          HubView.showToastAfterLoadingHubDismiss('绑定手机号失败:$err');
        });
      } else {
        showToast('请输入正确的手机号码和验证码');
      }
    } else {
      showToast('请先勾选同意协议');
    }
  }

  Future _loginSuccess() async {
    await UserMod.getMyProfile();
    logD('当前用户手机号码:${App.currentMobile}');
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
