import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/me/page/userInfo/user_info_page.dart';
import 'package:lianmiapp/provider/me/userInfo_view_model.dart';
import 'package:lianmiapp/util/keyboard_utils.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';

class SpecialWordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SpecialWordPageState();
  }
}

class _SpecialWordPageState extends State<SpecialWordPage> {
  TextEditingController _ctrlSpecialWord = TextEditingController();

  String? Function(String?)? _vali = (value) {
    if (value == null ||
        value.toString().length < 1 ||
        value.toString().length > 32) {
      return "个性签名长度限1～32位";
    }
  };

  @override
  Widget build(BuildContext context) {
    if (isValidString(_ctrlSpecialWord.text) == false) {
      UserInfo? user =
          Provider.of<UserInfoViewModel>(context, listen: false).user;
      _ctrlSpecialWord = TextEditingController(text: user!.label);
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
                  AppNavigator.push(context, UserInfoPage());
                },
                tooltip: 'Back',
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xff333333),
                ),
              ),
              backgroundColor: Colors.white,
              title: Text('个性签名', style: TextStyle(color: Color(0xff333333))),
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
            title: Text('个性签名'),
            tileColor: Color(0xffF6F7F8),
          ),
          Form(
            child: TextFormField(
              autofocus: true,
              controller: _ctrlSpecialWord,
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
                "个性签名长度限1～32位",
                style: TextStyle(fontSize: 11, color: Color(0xff999999)),
              )),
        ],
      ),
    );
  }

  void _confirm() {
    KeyboardUtils.hideKeyboard(context);
    if (isValidString(_ctrlSpecialWord.text) == false) {
      HubView.showToast('请输入昵称');
      return;
    }
    HubView.showLoading();
    UserMod.updateUserProfile(label: _ctrlSpecialWord.text).then((value) {
      Provider.of<UserInfoViewModel>(context, listen: false).updateUserInfo();
      Future.delayed(Duration(seconds: 1), () {
        HubView.dismiss();
        HubView.showToastAfterLoadingHubDismiss('修改个性签名成功');
        AppNavigator.goBack(context);
      });
    }).catchError((err) {
      HubView.dismiss();
      HubView.showToastAfterLoadingHubDismiss('修改个性签名失败:$err');
    });
  }
}
