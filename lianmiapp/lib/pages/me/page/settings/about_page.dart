import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/me/page/settings/tos_page.dart';
import 'package:lianmiapp/util/app_navigator.dart';
import 'package:lianmiapp/util/update_utils.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyCustomAppBar(
          centerTitle: '关于我们',
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
            SizedBox(
                width: 320,
                height: 240,
                child: Image(image: AssetImage('assets/images/192.png'))),
            InkWell(
              onTap: () {
                AppNavigator.push(context, TosPage());
              },
              child: Container(
                height: 60,
                margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("服务条款", style: TextStyle(fontSize: 16)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Icon(Icons.keyboard_arrow_right)],
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                _checkForUpdate();
              },
              child: Container(
                height: 60,
                margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("检查更新", style: TextStyle(fontSize: 16)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Icon(Icons.keyboard_arrow_right)],
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }

  void _checkForUpdate() {
    UpdateUtils.checkForUpdate();
  }
}
