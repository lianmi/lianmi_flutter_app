import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
import 'package:oktoast/oktoast.dart';
import 'dart:ui' as ui;

///二维码事件
class QrEvents {
  @override
  Future<Uint8List> qrToImage(GlobalKey key) async {
    // TODO: implement qrToImage
    try {
      RenderRepaintBoundary boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData byteData = await (image.toByteData(
          format: ui.ImageByteFormat.png) as FutureOr<ByteData>);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      print('图片转化成功');
      return pngBytes;
    } catch (e) {
      return Uint8List(10);
    }
  }

  @override
  void saveImage(GlobalKey key) async {
    // TODO: implement saveImage
//    await Permission.storage.request();
//    // 申请结果
//    bool  isPermission = await Permission.storage.isGranted;
//    print('权限是否申请成功: $isPermission');
    Uint8List _image = await qrToImage(key);
    try {
      final result = await ImageGallerySaver.saveImage(_image,
          quality: 100, name: "二维码_${DateTime.now().toString()}");
      logD('图片保存：' + result.toString());
      showToast('二维码保存成功');
    } catch (e) {
      showToast('二维码保存失败');
    }
  }
}
