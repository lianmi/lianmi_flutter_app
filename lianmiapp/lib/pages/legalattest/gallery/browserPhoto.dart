import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:lianmiapp/manager/file_manager.dart';
import 'package:lianmiapp/util/app_navigator.dart';
import 'package:lianmiapp/widgets/hub_view.dart';
import 'package:lianmiapp/widgets/my_app_bar.dart';
import 'package:linkme_flutter_sdk/manager/LogManager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';

class BrowserPhoto extends StatefulWidget {
  final String locallyPhotoPath;

  BrowserPhoto(this.locallyPhotoPath);

  @override
  _BrowserPhotoState createState() => _BrowserPhotoState();
}

class _BrowserPhotoState extends State<BrowserPhoto> {
  final PhotoViewController _controller = PhotoViewController();
  var _quarterTurns = 0;
  String _locallyPhotoPath = '';

  @override
  void initState() {
    super.initState();
    _locallyPhotoPath = widget.locallyPhotoPath;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar(
        centerTitle: '图片预览',
        actions: [
          //
          TextButton(
            onPressed: () {
              if (Platform.isIOS) {
                return _saveImage();
              }
              requestPermission().then((bool) {
                if (bool) {
                  _saveImage();
                }
              });
            },
            child: Text("保存到相册"),
          )
        ],
      ),
      backgroundColor: Color(0XFFF4F5F6),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 20.0),
                    height: 300.0,
                    child: ClipRect(
                      child: PhotoView(
                        controller: _controller,
                        imageProvider: FileImage(File(widget.locallyPhotoPath)),
                        maxScale: PhotoViewComputedScale.covered,
                        initialScale: PhotoViewComputedScale.contained * 0.8,
                        enableRotation: false,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.rotate_right),
        onPressed: _rotateRight90Degrees,
      ),
    );
  }

//动态申请权限，ios 要在info.plist 上面添加
  Future<bool> requestPermission() async {
    var status = await Permission.photos.status;
    return status.isGranted;
  }

  //保存图片到本地相册
  _saveImage() async {
    var status = await Permission.photos.status;
    logD(status);
    if (status.isDenied) {
      // We didn't ask for permission yet.
      logW('暂无相册权限');
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text('提示'),
              content: Text('您当前没有开启相册权限'),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text('取消'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                CupertinoDialogAction(
                  child: Text('去启动'),
                  onPressed: () {
                    openAppSettings();
                  },
                ),
              ],
            );
          });

      return;
    }

    EasyLoading.show(status: '加载中...');

    if (FileManager.instance.isExist(_locallyPhotoPath)) {
      final result = await ImageGallerySaver.saveFile(_locallyPhotoPath);
      logI(result);
      HubView.showToastAfterLoadingHubDismiss('保存成功');
    } else {
      HubView.showToastAfterLoadingHubDismiss('文件不存在');
    }

    EasyLoading.dismiss();
  }

  void _rotateRight90Degrees() {
    // Set the rotation to either 0, 90, 180 or 270 degrees (value is in radians)
    _quarterTurns = _quarterTurns == 3 ? 0 : _quarterTurns + 1;
    _controller.rotation = math.pi / 2 * _quarterTurns;
  }

  _erasePhoto() {
    logW('_erasePhoto hit' + _locallyPhotoPath);

    AppNavigator.goBackWithParams(context, {'path': _locallyPhotoPath});
  }
}
