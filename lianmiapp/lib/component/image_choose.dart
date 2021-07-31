import 'dart:async';
import 'dart:io';

import 'package:lianmiapp/header/common_header.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

class ImageChoose {
  factory ImageChoose() => _getInstance();
  static ImageChoose get instance => _getInstance();
  static ImageChoose? _instance;
  ImageChoose._internal() {}
  static ImageChoose _getInstance() {
    if (_instance == null) {
      _instance = ImageChoose._internal();
    }
    return _instance!;
  }

  Future pickImage() {
    Completer completer = Completer();
    showModalBottomSheet(
      context: App.context!,
      builder: (BuildContext context) {
        return SafeArea(
            child: Column(
            mainAxisSize: MainAxisSize.min, // 设置最小的弹出
            children: <Widget>[
              ListTile(
                title: Text("拍照"),
                onTap: () async {
                  Navigator.of(context).pop();
                  _cameraAction(completer);
                },
              ),
              ListTile(
                title: Text("相册"),
                onTap: () async {
                  Navigator.of(context).pop();
                  _photoAction(completer);
                },
              ),
            ],
          )
        );
      }
    );
    return completer.future;
  }

  void _cameraAction(Completer completer) {
    CameraPicker.pickFromCamera(
      App.context!, 
      enableRecording: false
    ).then((value) async {
      if(value != null) {
        AssetEntity asset = value;
        File? file = await asset.file;
        completer.complete(file!.path);
      } else {
        completer.complete(null);
      }
    });
  }

  void _photoAction(Completer completer) {
    AssetPicker.pickAssets(
      App.context!,
      requestType: RequestType.image,
      maxAssets: 1
    ).then((assets) async {
      if(assets != null && assets.length > 0) {
        AssetEntity asset = assets.first;
        File? file = await asset.file;
        completer.complete(file!.path);
      } else {
        completer.complete(null);
      }
    });
  }
}