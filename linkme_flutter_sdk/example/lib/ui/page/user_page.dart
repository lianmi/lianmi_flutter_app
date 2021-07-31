import '../widget/appbar_widget.dart';
import 'package:flutter/material.dart';

import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
import 'package:linkme_flutter_sdk/manager/AppManager.dart';
import 'package:linkme_flutter_sdk/sdk/UserMod.dart';
import 'package:linkme_flutter_sdk/sdk/SdkEnum.dart';
import 'package:image_picker/image_picker.dart';

class UserPage extends StatefulWidget {
  UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> implements SyncEventListener {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("user", 80, false).build(context),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            _oneColumnWidget(),
            _twoColumnWidget(),
          ],
        ),
      ),
    );
  }

  Widget _oneColumnWidget() {
    return Expanded(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          children: [
            _customButton('获取当前用户的关注商户', onTap: () async {
              var stores = await UserMod.getWatchingStores();
              stores.forEach((store) => logD('${store.toJson()}'));
            }),
            _customButton('上传用户设备信息', onTap: () async {
              var _map = {
                'imei': 'aaa',
                'im_device_id': 'bbb',
                'device_name': 'reemi',
                "os_type": 'android',
                "os_tyos_versionpe": '10',
                "push_service_code": '2',
                "push_token": 'xxx',
              };

              var ok = await UserMod.userUploadDeviceInfo(_map);
              if (ok) {
                logD('上传用户设备信息成功');
              }
            }),
            _customButton('获取服务端个人资料', onTap: () async {
              var _user = await UserMod.getMyProfile();
              logD('_user.nick: ${_user.nick}');
              logD('_user.genger: ${_user.gender}');
            }),
            // _customButton('获取本地个人资料', onTap: () async {
            //   var _user = await AppManager.gRepository!
            //       .queryPrivInfo(AppManager.currentUsername);
            //   logD('_user: ${_user}');
            //   // logD('_user.genger: ${_user.gender}');
            // }),
            _customButton('更改id1头像，呢称', onTap: () async {
              // 上传头像
              final _imageFile =
                  await _picker.getImage(source: ImageSource.gallery);
              if (_imageFile == null) {
                return null;
              }
              var filename = _imageFile.path;

              UserMod.uploadOssFile(filename, 'avatars', (imageKey) {
                logD('$filename 头像上传完成, imageKey: $imageKey');

                var f = UserMod.updateUserProfile(
                    imageKey: imageKey, //头像
                    nick: '李示佳',
                    gender: GenderEnum.GenderMale.index.toString(),
                    label: ' 区块链彩票专家',
                    trueName: '李示佳',
                    email: 'lianmicloud@163.com',
                    extend: 'xxxx-232asdlfkaskdfj',
                    identityCard: '440725197207290017',
                    province: '广东省',
                    city: '鹤山市',
                    area: '沙坪街道',
                    address: '新鹤路乐民村116号302房');
                f.then((value) {
                  logD(
                      '更新用户(${AppManager.currentUsername})资料成功, value: $value');
                }).catchError((err) {
                  logE('UpdateUserProfile错误: $err');
                });
              }, (errmsg) {
                logD('头像上传失败, $errmsg');
              }, (percent) {
                //上传进度
              });
            })
          ],
        ),
      ),
    );
  }

  Widget _twoColumnWidget() {
    return Expanded(
        child: Container(
      width: double.infinity,
      height: double.infinity,
      child: ListView(
        children: [
          _customButton('绑定手机', onTap: () async {
            String mobile = '13702290109';
            String smscode = '123456';
            await AuthMod.getSmscode(mobile);

            UserMod.userBindMobile(mobile, smscode).then((value) {
              logD('value: $value');
            }).catchError((err) {
              logE(err);
            });
          }),
          _customButton('手机获取注册id', onTap: () async {
            String mobile = '13702290109';
            await AuthMod.getSmscode(mobile);

            UserMod.getUserIDFromServerByMobile(mobile).then((value) {
              logD('value: $value');
            }).catchError((err) {
              logE(err);
            });
          }),
        ],
      ),
    ));
  }

  Widget _customButton(String title, {required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        width: double.infinity,
        height: 30,
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  ///所有同步完成
  @override
  void onSyncDone() {
    logD('所有同步完成');
  }
}
