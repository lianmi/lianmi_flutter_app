import "package:flutter/material.dart";
import 'package:lianmiapp/component/image_choose.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/common/qr_scan_page.dart';
import 'package:lianmiapp/pages/me/me_utils.dart';
import 'package:lianmiapp/pages/me/page/userInfo/edit_nickname_page.dart';
import 'package:lianmiapp/pages/me/page/userInfo/special_word_page.dart';
import 'package:lianmiapp/provider/linkme_provider.dart';
import 'package:lianmiapp/provider/me/userInfo_view_model.dart';
import 'package:lianmiapp/util/action_utils.dart';
import 'package:lianmiapp/util/app.dart';
import 'package:lianmiapp/util/keyboard_utils.dart';
import 'package:lianmiapp/widgets/hub_view.dart';
import 'package:lianmiapp/widgets/widget/button/common_button.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart' as sdk;
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
import 'package:linkme_flutter_sdk/sdk/AuthMod.dart';
import '../../../../util/app_navigator.dart';

class UserInfoPage extends StatefulWidget {
  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          backgroundColor: Colors.white,
        ),
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  Navigator.of(context).popUntil(ModalRoute.withName('/'));
                },
                tooltip: 'Back',
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xff333333),
                ),
              ),
              backgroundColor: Colors.white,
              title: Text('个人资料', style: TextStyle(color: Color(0xff333333))),
              centerTitle: true,
              actions: [],
              elevation: 0,
            ),
            body: _body(context)));
  }

  Widget _body(BuildContext context) {
    return Consumer<UserInfoViewModel>(builder: (context, userInfo, child) {
      return Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              InkWell(
                onTap: () {
                  _showMedia();
                },
                child: Container(
                  height: 60,
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("头像", style: TextStyle(fontSize: 16)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          me_utils().roundRectImage(
                              40, 40, userInfo.user!.avatar!, 10.0),
                          Icon(Icons.keyboard_arrow_right)
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 60,
                margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("用户名", style: TextStyle(fontSize: 16)),
                    Text(userInfo.user!.userName!,
                        style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              InkWell(
                  onTap: () {
                    _editNickname();
                  },
                  child: Container(
                    height: 60,
                    margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("呢称", style: TextStyle(fontSize: 16)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(userInfo.user!.nick!,
                                style: TextStyle(fontSize: 16)),
                            Icon(Icons.keyboard_arrow_right)
                          ],
                        )
                      ],
                    ),
                  )),
              InkWell(
                onTap: () {
                  _editLabel();
                },
                child: Container(
                  height: 60,
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("个性签名", style: TextStyle(fontSize: 16)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(userInfo.user!.label!,
                              style: TextStyle(fontSize: 16)),
                          Icon(Icons.keyboard_arrow_right)
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ));
    });
  }

  Widget _listItem(String title, {Function? onTap}) {
    return InkWell(
      onTap: () {
        onTap!();
      },
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

  void _showMedia() {
    KeyboardUtils.hideKeyboard(App.context!);
    ImageChoose.instance.pickImage().then((value) {
      if (value != null) {
        FileManager.instance.copyFileToAppFolder(value).then((value) {
          _uploadAvatarAndChange(value);
        });
      }
    });
  }

  void _uploadAvatarAndChange(String path) {
    HubView.showLoading();
    UserMod.uploadOssFile(path, 'avatars', (imageKey) {
      UserMod.updateUserProfile(imageKey: imageKey).then((value) {
        Provider.of<UserInfoViewModel>(context, listen: false).updateUserInfo();
        Future.delayed(Duration(seconds: 1), () {
          HubView.dismiss();
          HubView.showToastAfterLoadingHubDismiss('修改头像成功');
        });
      }).catchError((err) {
        HubView.dismiss();
        HubView.showToastAfterLoadingHubDismiss('修改头像出错:$err');
      });
    }, (errmsg) {
      HubView.dismiss();
      HubView.showToastAfterLoadingHubDismiss('上传图片出错$errmsg');
    }, (percent) {
      sdk.logD('上传图片进度:$percent');
    });
  }

  void _editNickname() {
    AppNavigator.push(context, EditNicknamePage());
  }

  void _editLabel() {
    AppNavigator.push(context, SpecialWordPage());
  }
}
