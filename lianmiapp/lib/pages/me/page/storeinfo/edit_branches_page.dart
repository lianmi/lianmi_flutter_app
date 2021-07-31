import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/me/page/storeinfo/store_info_page.dart';
import 'package:lianmiapp/provider/me/storeInfo_view_model.dart';
import 'package:lianmiapp/util/keyboard_utils.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';

class EditBranchesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // throw UnimplementedError();
    return _EditBranchesPageState();
  }
}

class _EditBranchesPageState extends State<EditBranchesPage> {
  final _formKey = GlobalKey<FormState>();
  FocusNode _fnText = FocusNode();
  TextEditingController? _ctrlBranchesName = TextEditingController();

  String? Function(String?)? _vali = (value) {
    if (value == null ||
        value.toString().length < 1 ||
        value.toString().length > 20) {
      return "商户名称长度限1～20位";
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
    if (isValidString(_ctrlBranchesName!.text) == false) {
      StoreInfo? store =
          Provider.of<StoreInfoViewModel>(context, listen: false).store;
      _ctrlBranchesName = TextEditingController(text: store!.branchesName);
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
              title: Text('商户名称', style: TextStyle(color: Color(0xff333333))),
              centerTitle: true,
              actions: [
                TextButton(
                  onPressed: () {
                    _confirm();
                  },
                  child: Text("确定修改"),
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
        title: Text("设置商户名称"),
        tileColor: Color(0xffF6F7F8),
      ),
      Form(
        key: this._formKey,
        child: TextFormField(
          autofocus: true,
          controller: _ctrlBranchesName,
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
            "商户名称长度限1～20位",
            style: TextStyle(fontSize: 11, color: Color(0xff999999)),
          )),
    ]));
  }

  void _confirm() {
    KeyboardUtils.hideKeyboard(context);
    if (isValidString(_ctrlBranchesName!.text) == false) {
      HubView.showToast('请输入商户名称');
      return;
    }
    HubView.showLoading();
    UserMod.updateStoreInfo(branchesName: _ctrlBranchesName!.text)
        .then((value) {
      Provider.of<StoreInfoViewModel>(context, listen: false).updateStoreInfo();
      Future.delayed(Duration(seconds: 1), () {
        HubView.dismiss();
        HubView.showToastAfterLoadingHubDismiss('修改商户名称成功');
        AppNavigator.goBack(context);
      });
    }).catchError((err) {
      HubView.dismiss();
      HubView.showToastAfterLoadingHubDismiss('修改商户名称失败:$err');
    });
  }
}
