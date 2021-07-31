import 'package:linkme_flutter_sdk/net/wsHandler.dart';
import 'package:permission_handler/permission_handler.dart';
import '../widget/appbar_widget.dart';
import 'package:flutter/material.dart';
import '../../application.dart';
import 'package:linkme_flutter_sdk/util/hex.dart';
import 'package:event_bus/event_bus.dart';

//一个文件
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

void initPower() async {
  // bool isOpened = await PermissionHandler().openAppSettings();

  await Permission.photos.request();
  await Permission.camera.request();
  await Permission.storage.request();
  // 申请结果
  bool isPermission = await Permission.storage.isGranted;
  logV('权限是否申请成功: $isPermission');
}

class _AuthPageState extends State<AuthPage> implements BaseConnectionListener {
  String _phone = '';

  @override
  void initState() {
    initPower();

    websocketfactory.addNetWorkListener(this); //增加网络状态监听器

    super.initState();
  }

  void _login(String mobile, int userType) async {
    ///验证码验证
    var _smscode = await AuthMod.getSmscode(mobile);

    var f = AuthMod.login(
        LoginType.LoginType_Mobile, mobile, "", "123456", true, userType);
    f.then((loginValue) async {
      logD('AppManager.isLogined= ${AppManager.isLogined}');

      if (AppManager.isLogined) {
        logD(
            '登录成功: ${AppManager.currentUsername},用户手机: ${AppManager.currentMobile}, 用户类型: ${loginValue.userType}, State: ${loginValue.state}');
      } else {
        logW('isLogined = false, 登录失败');
      }
    }).catchError((err) {
      logE('错误: ${err}');
    });
    logI(' 登录: ${AppManager.isLogined}');
  }

  _init_app() async {
    logD('统一初始化');
    await appManager.init(); //统一初始化

    // 设置 订单到达回调
    AppManager.onReceiveOrder = (orderInfoData) {
      logD('收到服务端下发订单数据, orderInfoData: ${orderInfoData.toJson()}');

      Application.changeStateOrderID = orderInfoData.orderId!; //订单id
      Application.orderTotalAmount = orderInfoData.totalAmount! / 100; //以元为单位
      Application.state = OrderStateEnum.values[orderInfoData.state!];
      logD(
          'Application.changeStateOrderID: ${Application.changeStateOrderID}, \norderTotalAmount: ${Application.orderTotalAmount}, \nstate: ${Application.state}}');
    };
  }

  @override
  void onConnected() {
    logD("onConnected === 默认网络监听器 : 网络链接成功 ");
  }

  @override
  void onDisconnected() {
    logD("onDisconnected === 默认网络监听器 : 网络断开 ");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("auth", 80, false).build(context),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            _oneColumnWidget(),
            _twoColumnWidget(),
          ],
        ),
      ),
    );
  }

  Widget _oneColumnWidget() {
    return Expanded(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          children: [
            _customButton('初始化', onTap: () {
              _init_app();
            }),
            _customButton('登录id1', onTap: () {
              _phone = '13702290109'; //id1 的手机
              _login(this._phone, UserTypeEnum.UserTypeEnum_Normal.index);
            }),
            _customButton('登录商户id6', onTap: () {
              _phone = '13922148401'; //id6 的手机
              _login(this._phone, UserTypeEnum.UserTypeEnum_Normal.index);
            }),
            _customButton('检查更新', onTap: () async {
              var result = await AuthMod.checkUpdate();
              logD(
                  'version: ${result['version']}, url: ${result['download_url']}');
            }),
            _customButton('服务条款', onTap: () async {
              var result = await AuthMod.getFuwutiaokuan();
              logD(result);
            }),
            _customButton('用户扫码URL', onTap: () async {
              var result = await AuthMod.getAppDownloadURL();
              logD(result);
            }),
            _customButton('查询商户是否在线', onTap: () async {
              var _isOnline = await AuthMod.isOnline('id3');
              if (_isOnline) {
                logD('商户在线');
              } else {
                logD('商户离线');
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _twoColumnWidget() {
    return Expanded(
        child: Container(
      width: double.infinity,
      height: double.infinity,
      child: ListView(
        children: [
          _customButton('登出并断开ws链接', onTap: () async {
            logD('关闭数据库中...');
            await AuthMod.signout();
            logI('登出完成');
          }),
          _customButton('当前用户信息', onTap: () async {
            logD({
              'isLogined': AppManager.isLogined,
              '用户注册账号': AuthMod.getLastLoginName(),
              '用户手机': AppManager.currentMobile,
              '令牌': AuthMod.getLastLoginToken(),
              '用户类型': AuthMod.getLastLoginUserType().toString(),
              '账号状态': AuthMod.getLastLoginState().toString(),
            });

            var lastUserInfo = await AuthMod.getLastUserInfo();
            logD('数据库里的用户数据: ${lastUserInfo.toString()}');
          }),
          _customButton('修改用户推送', onTap: () async {
            var result = await UserMod.modifyPushSetting(true, true, false);
            logD('result: $result');
          }),
          _customButton('查询用户推送', onTap: () async {
            var data = await UserMod.getPushSetting();
            logD('data: $data');
          }),
          _customButton('查询用户是否绑定了微信', onTap: () async {
            var isBind = await UserMod.isBindWechat();
            logD('isBind: $isBind');
          }),
          _customButton('获取系统公告', onTap: () async {
            var list = await AuthMod.getSystemMsgs();
            logD('list: $list');
          }),
        ],
      ),
    ));
  }

  Widget _customButton(String title, {required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        width: double.infinity,
        height: 30,
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
