import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/manager/sdk_manager.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';

class BindThirdPage extends StatefulWidget {
  const BindThirdPage({Key? key}) : super(key: key);

  @override
  _BindThirdPageState createState() => _BindThirdPageState();
}

class _BindThirdPageState extends State<BindThirdPage> {
  bool? _isbind;

  @override
  void initState() {
    super.initState();
    _loadIsBindWX();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyCustomAppBar(
          centerTitle: '绑定第三方',
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Container(
          child: _body(),
        )));
  }

  Widget _body() {
    Widget statusWidget = SizedBox();
    if (_isbind != null) {
      statusWidget = Text(_isbind! ? '已绑定' : '暂未绑定');
    }

    return Container(
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      child: Column(
                    children: [
                      Image.asset(
                        ImageStandard.wx,
                        width: 100.px,
                        height: 100.px,
                      ),
                      SizedBox(height: 24),
                      statusWidget
                    ],
                  ))
                ],
              ),
            ),
            _bindaction()
          ],
        ));
  }

  Widget _bindaction() {
    if (_isbind == null) return SizedBox();
    logD('_isbind: $_isbind');

    if (_isbind!) {
      return Container(
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(0, 0, 0, 12),
          child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colours.app_main)),
              onPressed: () {
                _unbind();
              },
              child: Text('解绑')));
    } else {
      return Container(
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(0, 0, 0, 12),
          child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colours.app_main)),
              onPressed: () {
                _bind();
              },
              child: Text('立即绑定')));
    }
  }

  void _loadIsBindWX() {
    HubView.showLoading();
    UserMod.isBindWechat().then((value) {
      HubView.dismiss();
      setState(() {
        _isbind = value;
      });
    }).catchError((err) {
      HubView.dismiss();
      HubView.showToastAfterLoadingHubDismiss('获取绑定状态失败:$err');
    });
  }

  void _bind() {
    HubView.showLoading();
    SDKManager.instance.bindWX().then((value) {
      HubView.dismiss();
      HubView.showToastAfterLoadingHubDismiss('绑定微信成功');
      AppNavigator.goBack(App.context!);
    }).catchError((err) {
      HubView.showToastAfterLoadingHubDismiss('绑定微信失败:$err');
    });
  }

  void _unbind() {
    HubView.showLoading();
    UserMod.unBindMobile().then((value) {
      HubView.dismiss();
      HubView.showToastAfterLoadingHubDismiss('解绑微信成功');
      AppNavigator.goBack(App.context!);
    }).catchError((err) {
      HubView.showToastAfterLoadingHubDismiss('解绑微信失败:$err');
    });
  }
}
