import 'package:flutter/material.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
import 'package:linkme_flutter_sdk/sdk/AuthMod.dart';

class TosPage extends StatefulWidget {
  @override
  _TosPageState createState() => _TosPageState();
}

class _TosPageState extends State<TosPage> {
  String _tosContent = '';

  @override
  void initState() {
    super.initState();
    _loadTos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyCustomAppBar(
          centerTitle: '服务条款',
        ),
        backgroundColor: Color(0XFFF4F5F6),
        body: SafeArea(
            child: Container(
          padding: EdgeInsets.fromLTRB(16.px, 0, 16.px, 0),
          width: double.infinity,
          alignment: Alignment.topLeft,
          child: ListView(
            children: [
              CommonText(
                _tosContent,
                fontSize: 15.px,
                color: Colors.black,
                maxLines: 1000000000,
              )
            ],
          ),
        )));
  }

  void _loadTos() {
    HubView.showLoading();
    AuthMod.getFuwutiaokuan().then((value) {
      HubView.dismiss();
      setState(() {
        _tosContent = value;
        logI(_tosContent);
      });
    }).catchError((err) {
      HubView.dismiss();
      HubView.showToastAfterLoadingHubDismiss('加载服务条款出错:$err');
    });
  }
}
