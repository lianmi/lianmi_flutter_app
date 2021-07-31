import 'dart:io';
import 'package:huawei_push/huawei_push_library.dart' as HuaWeiPushPlugin;
import 'package:linkme_flutter_sdk/manager/LogManager.dart';
import 'package:xiao_mi_push_plugin/xiao_mi_push_plugin.dart';
import 'package:device_info/device_info.dart';
import 'package:lianmiapp/header/common_header.dart';

///
/// 推送管理
///

///小米
const String _kMiPushAppId = '2882303761519955989';
const String _kMiPushAppKey = '5461995546989';

enum PushBrand {
  unknow,
  iOS,    ///iOS
  google,
  xiaomi, ///小米
  huawei  ///华为
}

class PushManager {
  factory PushManager() =>_getInstance();
  static PushManager get instance => _getInstance();
  static PushManager? _instance;
  PushManager._internal() {
  }
  static PushManager _getInstance() {
    if (_instance == null) {
      _instance = PushManager._internal();
    }
    return _instance!;
  }

  String? _pushToken;

  PushBrand _pushBrand = PushBrand.unknow;

  ///推送的token，看时机传给后端对应用户保存起来(华为)
  String? get pushToken => _pushToken;

  PushBrand get pushBrand =>  _pushBrand;

  void init() async {
    await _getDeviceInfo();
    Future.delayed(Duration(seconds: 5), () async {
      switch (_pushBrand) {
        case PushBrand.iOS: {
        }
          break;
        case PushBrand.google: {
        }
          break;
        case PushBrand.huawei: {
          _initHuaWeiPush();
        }
          break;
        case PushBrand.xiaomi: {
          _initMiPush();
        }
          break;
        default:
      }
    });
  }
  
  Future _getDeviceInfo() async{
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if(Platform.isIOS){
      _pushBrand = PushBrand.iOS;
    }else if(Platform.isAndroid){
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      switch (androidDeviceInfo.brand) {
          case 'Xiaomi': {
            _pushBrand = PushBrand.xiaomi;
            break;
          }
          case 'HUAWEI': {
            _pushBrand = PushBrand.huawei;
            break;
          }
          default:
        }
    }
  }

  void _initMiPush() {
    XiaoMiPushPlugin.init(appId: _kMiPushAppId, appKey: _kMiPushAppKey).then((value) {
      XiaoMiPushPlugin.getRegId().then((value) {
        if (isValidString(value)) {
          logD('获取小米推送token:$value');
          _pushToken = value;
          _pushBrand = PushBrand.xiaomi;
        } else {
          ///有时候获取不到token重新获取一次
          _initMiPush();
        }
      }).catchError((err) {
        logD('获取小米regid失败:$err');
      });
    }).catchError((err) {
      logE('初始化小米推送失败:$err');
    });
  }

  void _initHuaWeiPush() {
    HuaWeiPushPlugin.Push.getTokenStream.listen(_onHuaWeiTokenEvent, onError: _onHuaWeiTokenError);
    HuaWeiPushPlugin.Push.getToken('');
  }

  void _onHuaWeiTokenEvent(String token) {
    logD('获取华为推送token:$token');
    if (isValidString(token)) {
      _pushToken = token;
      _pushBrand = PushBrand.huawei;
    }
  }

  void _onHuaWeiTokenError(Object error) {
    logE('获取华为推送token失败');
  }

}