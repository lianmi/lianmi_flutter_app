import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/me/page/userInfo/user_info_page.dart';
import 'package:lianmiapp/provider/me/userInfo_view_model.dart';
import 'package:lianmiapp/util/keyboard_utils.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';

class EditNicknamePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // throw UnimplementedError();
    return _EditNicknamePageState();
  }
}

class _EditNicknamePageState extends State<EditNicknamePage> {
  final _formKey = GlobalKey<FormState>();
  FocusNode _fnText = FocusNode();
  TextEditingController? _ctrlNickName = TextEditingController();

  String? Function(String?)? _vali = (value) {
    if (value == null ||
        value.toString().length < 1 ||
        value.toString().length > 20) {
      return "昵称长度限1～20位";
    }
  };
  @override
  initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance!.addPostFrameCallback((tim) {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (isValidString(_ctrlNickName!.text) == false) {
      UserInfo? user =
          Provider.of<UserInfoViewModel>(context, listen: false).user;
      _ctrlNickName = TextEditingController(text: user!.nick);
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
              title: Text('昵称', style: TextStyle(color: Color(0xff333333))),
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
            body: _body()));
  }

  Widget _body() {
    return Container(
        child: Column(children: [
      ListTile(
        title: Text("设置呢称"),
        tileColor: Color(0xffF6F7F8),
      ),
      Form(
        key: this._formKey,
        child: TextFormField(
          autofocus: true,
          controller: _ctrlNickName,
          style: TextStyle(fontSize: 16),
          focusNode: _fnText,
          onEditingComplete: () {},
          decoration: InputDecoration(
            prefixIconConstraints: BoxConstraints(minHeight: 0, minWidth: 16),
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
            "昵称长度限1～20位",
            style: TextStyle(fontSize: 11, color: Color(0xff999999)),
          )),
    ]));
  }

  void _confirm() {
    KeyboardUtils.hideKeyboard(context);
    if (isValidString(_ctrlNickName!.text) == false) {
      HubView.showToast('请输入昵称');
      return;
    }
    HubView.showLoading();
    UserMod.updateUserProfile(nick: _ctrlNickName!.text).then((value) {
      Provider.of<UserInfoViewModel>(context, listen: false).updateUserInfo();
      Future.delayed(Duration(seconds: 1), () {
        HubView.dismiss();
        HubView.showToastAfterLoadingHubDismiss('修改昵称成功');
        AppNavigator.goBack(context);
      });
    }).catchError((err) {
      HubView.dismiss();
      HubView.showToastAfterLoadingHubDismiss('修改昵称失败:$err');
    });
  }
}
