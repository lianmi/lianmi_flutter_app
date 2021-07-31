import 'package:lianmiapp/header/common_header.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:lianmiapp/widgets/widget/dialog/remind_dialog.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
import 'package:permission_handler/permission_handler.dart';

//保存文件工具类
class SaveUtils {
  ///保存原图片
  static Future saveOriginImage(String imgUrl) async {
    //读取缓存地址图片是否存在
    File _file;
    if (File(imgUrl).existsSync()) {
      _file = File(imgUrl);
    } else {
      _file = await DefaultCacheManager().getSingleFile(imgUrl);
    }

    bool _bo = await _requestPermission();
    if (_bo == true) {
      if (isValidString(_file.path)) {
        logD('图片缓存地址：' + _file.path);
        var _result = await ImageGallerySaver.saveFile(_file.path);
        logD('图片保存回包数据: $_result');
        if (_result['isSuccess'] == false) {
          return Future.error(_result['errorMessage']);
        }
      } else {
        if (imgUrl.contains('http')) {
          var byteData =
              await NetworkAssetBundle(Uri.parse(imgUrl)).load(imgUrl);
          var _result =
              await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
          logD('图片保存回包数据: $_result');
          if (_result['isSuccess'] == false) {
            return Future.error(_result['errorMessage']);
          }
        } else {
          return Future.error('图片不存在');
        }
      }
    }
  }
}

Future<bool> _requestPermission() async {
  bool _bo = false;
  await Permission.photos.request();
  var _has = await Permission.photos.status;
  if (_has.isGranted || _has.isLimited) {
    _bo = true;
    logD('权限申请通过');
  } else {
    logD('权限申请未通过');
    showDialog(
        context: App.context!,
        builder: (_) => RemindDialog(
              remind: '相册权限未开启,请前往设置开启',
              cancel: () {
                Navigator.of(App.context!).pop();
              },
              confirm: () {
                Navigator.of(App.context!).pop();
                openAppSettings();
              },
            ));
  }
  return _bo;
}
