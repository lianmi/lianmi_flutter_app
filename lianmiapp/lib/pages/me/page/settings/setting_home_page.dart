import 'package:flutter/material.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/me/page/settings/about_page.dart';
import 'package:lianmiapp/pages/me/page/settings/bind_third_page.dart';
import 'package:lianmiapp/pages/me/page/settings/notice_setting_page.dart';
import 'package:lianmiapp/provider/linkme_provider.dart';
import 'package:lianmiapp/util/alert_utils.dart';
import 'package:lianmiapp/util/image_utils.dart';
import 'package:lianmiapp/widgets/widget/button/common_button.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';

class SettingHomePage extends StatelessWidget {
  static String routeName = '/me/settings/home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyCustomAppBar(
          centerTitle: '设置',
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Container(
          child: _body(context),
        )));
  }

  Widget _body(BuildContext context) {
    return Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            _settingItem(
                title: "通知设置",
                onTap: () {
                  AppNavigator.push(context, NoticeSettingPage());
                }),
            _settingItem(
                title: "第三方绑定",
                onTap: () {
                  AppNavigator.push(context, BindThirdPage());
                }),
            _settingItem(
                title: "清空缓存",
                onTap: () {
                  _clearCache();
                }),
            _settingItem(
                title: "关于我们",
                onTap: () {
                  AppNavigator.push(context, AboutPage());
                }),
            CommonButton(
              margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
              width: double.infinity,
              height: 50.px,
              text: '退出',
              fontSize: 16.px,
              textColor: Colors.white,
              color: Colours.app_main,
              borderRadius: 4.px,
              onTap: () {
                _logout();
              },
            ),
          ],
        ));
  }

  Widget _settingItem({required String title, required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(fontSize: 16)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Icon(Icons.keyboard_arrow_right)],
            )
          ],
        ),
      ),
    );
  }

  void _clearCache() {
    HubView.showLoading();
    Future.delayed(Duration(seconds: 1), () {
      HubView.dismiss();
      HubView.showToastAfterLoadingHubDismiss('已清空缓存');
    });
  }

  void _logout() async {
    AlertUtils.showChooseAlert(App.context!, title: '提示', content: '退出当前账号?',
        onTapConfirm: () {
      AuthMod.signout();
      HubView.showToast('已退出');
      String id = AuthMod.getLastLoginName() ?? '';
      // logD(id);
      Future.delayed(Duration(seconds: 1), () {
        Provider.of<LinkMeProvider>(App.context!, listen: false)
            .logoutSuccess();
        Navigator.of(App.context!).popUntil(ModalRoute.withName('/'));
      });
    });
  }
}
