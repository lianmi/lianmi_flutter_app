import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/me/page/storeinfo/store_info_page.dart';
import 'package:lianmiapp/provider/me/storeInfo_view_model.dart';
import 'package:lianmiapp/util/keyboard_utils.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';

class KeysPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _KeysPageState();
  }
}

class _KeysPageState extends State<KeysPage> {
  TextEditingController _ctrlKeys = TextEditingController();

  String? Function(String?)? _vali = (value) {
    if (value == null ||
        value.toString().length < 1 ||
        value.toString().length > 32) {
      return "关键字长度限1～32位";
    }
  };

  @override
  Widget build(BuildContext context) {
    if (isValidString(_ctrlKeys.text) == false) {
      StoreInfo? store =
          Provider.of<StoreInfoViewModel>(context, listen: false).store;
      _ctrlKeys = TextEditingController(text: store!.keys);
    }
    return Theme(
        data: ThemeData(
          backgroundColor: Colors.white,
        ),
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  AppNavigator.push(context, StoreInfoPage());
                },
                tooltip: 'Back',
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xff333333),
                ),
              ),
              backgroundColor: Colors.white,
              title: Text('商户关键字', style: TextStyle(color: Color(0xff333333))),
              centerTitle: true,
              actions: [
                TextButton(
                  onPressed: () {
                    _confirm();
                  },
                  child: Text("确定"),
                )
              ],
              elevation: 0,
            ),
            body: _body(context)));
  }

  Widget _body(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ListTile(
            title: Text('请输入关键字'),
            tileColor: Color(0xffF6F7F8),
          ),
          Form(
            child: TextFormField(
              autofocus: true,
              controller: _ctrlKeys,
              style: TextStyle(fontSize: 16),
              decoration: InputDecoration(
                prefixIconConstraints:
                    BoxConstraints(minHeight: 0, minWidth: 16),
                prefixIcon: SizedBox(
                  width: 0,
                ),
                border: InputBorder.none,
              ),
              validator: _vali,
            ),
          ),
          Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(16, 0, 0, 0),
              child: Text(
                "关键字长度限1～32位",
                style: TextStyle(fontSize: 11, color: Color(0xff999999)),
              )),
        ],
      ),
    );
  }

  void _confirm() {
    KeyboardUtils.hideKeyboard(context);
    if (isValidString(_ctrlKeys.text) == false) {
      HubView.showToast('请输入关键字');
      return;
    }
    HubView.showLoading();
    UserMod.updateStoreInfo(keys: _ctrlKeys.text).then((value) {
      Provider.of<StoreInfoViewModel>(context, listen: false).updateStoreInfo();
      Future.delayed(Duration(seconds: 1), () {
        HubView.dismiss();
        HubView.showToastAfterLoadingHubDismiss('修改关键字成功');
        AppNavigator.goBack(context);
      });
    }).catchError((err) {
      HubView.dismiss();
      HubView.showToastAfterLoadingHubDismiss('修改关键字失败:$err');
    });
  }
}
