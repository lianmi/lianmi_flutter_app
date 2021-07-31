import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/manager/sdk_manager.dart';

class NoticeSettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NoticeSettingPageState();
  }
}

class _NoticeSettingPageState extends State<NoticeSettingPage> {
  bool _newRemind = false;
  bool _detail = false;
  bool _sound = false;

  @override
  void initState() {
    super.initState();
    _loadSetting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyCustomAppBar(
          centerTitle: '通知设置',
        ),
        backgroundColor: Colors.white,
        body: _body());
  }

  Widget _body() {
    return Container(
        color: Colors.white,
        child: ListView(
          // padding: const EdgeInsets.all(8.0),
          children: <Widget>[
            _item(
                title: "新消息提醒",
                value: _newRemind,
                onChange: (bool value) {
                  setState(() {
                    _newRemind = value;
                  });
                }),
            _item(
                title: "通知栏消息详情",
                value: _detail,
                onChange: (bool value) {
                  setState(() {
                    _detail = value;
                  });
                }),
            _item(
                title: "声音提醒",
                value: _sound,
                onChange: (bool value) {
                  setState(() {
                    _sound = value;
                  });
                }),
          ],
        ));
  }

  Widget _item(
      {required String title,
      bool value = false,
      Function()? onTap,
      Function(bool value)? onChange}) {
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
              children: [
                Switch(
                  value: value,
                  onChanged: (bool value) {
                    onChange!(value);
                    _modifySetting();
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _loadSetting() {
    HubView.showLoading();
    SDKManager.instance.loadPushSetting().then((value) {
      HubView.dismiss();
      setState(() {
        _newRemind = value['new_remind_switch'];
        _detail = value['detail_switch'];
        _sound = value['sound_switch'];
      });
    }).catchError((err) {
      HubView.dismiss();
      HubView.showToastAfterLoadingHubDismiss('加载通知设置出错:$err');
    });
  }

  void _modifySetting() {
    HubView.showLoading();
    SDKManager.instance
        .modifyPushSetting(
            newRemind: _newRemind, detail: _detail, sound: _sound)
        .then((value) {
      HubView.dismiss();
    }).catchError((err) {
      HubView.dismiss();
      HubView.showToastAfterLoadingHubDismiss('修改通知设置出错:$err');
    });
  }
}
