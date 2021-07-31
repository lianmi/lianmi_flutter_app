import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_qr_reader/flutter_qr_reader.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:lianmiapp/component/type_choose.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/lottery/model/lottery_order_model.dart';
import 'package:lianmiapp/pages/me/events/qr_events.dart';
import 'package:lianmiapp/res/colors.dart';
import 'package:lianmiapp/res/styles.dart';
import 'package:lianmiapp/util/save_utils.dart';
import 'package:lianmiapp/widgets/widget/button/custom_icon_button.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
import 'package:qr_flutter/qr_flutter.dart';

///蚂蚁链二维码
class AntChainQrPage extends StatefulWidget {
  final String qrurl;
  AntChainQrPage({required this.qrurl});

  @override
  _AntChainQrPageState createState() => _AntChainQrPageState();
}

class _AntChainQrPageState extends State<AntChainQrPage> with QrEvents {
  final GlobalKey _qrKey = GlobalKey();

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyCustomAppBar(
          centerTitle: '区块链存证二维码',
          actions: [
            CustomIconButton(
              width: 40.px,
              height: 40.px,
              icon: '',
              iconWidget:
                  Icon(Icons.more_horiz, size: 20.px, color: Colors.black),
              onTap: () {
                _showMore();
              },
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              _qrWidget(widget.qrurl),
              Gaps.vGap16,
              Text('打开支付宝扫一扫即可验证此存证真实性及关联性', style: TextStyles.font15()),
              Gaps.vGap16,
              Text('具备中国最高人民法院的存证资质及遵循技术中立原则', style: TextStyles.font15()),
              Gaps.vGap16,
              Text('存证具备法律效力，可以直接用于诉讼证据', style: TextStyles.font15()),
            ],
          ),
        )));
  }

  ///二维码
  Widget _qrWidget(String _url) {
    return RepaintBoundary(
        key: _qrKey,
        child: Container(
            margin: EdgeInsets.only(top: 30.px),
            color: Colors.white,
            child: QrImage(
              data: _url,

              ///#* *#内字段表示需跳转的路由， 后面嵌套的字符串表示请求用户数据的接口数据
              version: QrVersions.auto,
              size: 300.px,
              foregroundColor: Colours.text,
              backgroundColor: Colors.white,
              embeddedImageStyle: QrEmbeddedImageStyle(
                size: Size(40, 40),
              ),
              embeddedImage: ExactAssetImage('assets/images/antchain.png'),
            )));
  }

  void _showMore() {
    TypeChoose.show(
        title: '区块链存证二维码',
        list: ['保存二维码'],
        onTap: (int index) {
          // _saveImage(_qrKey);
          _saveQrcode();
        });
  }

  _saveQrcode() async {
    RenderRepaintBoundary boundary =
        _qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await (image.toByteData(format: ui.ImageByteFormat.png)
        as FutureOr<ByteData?>);
    if (byteData != null) {
      final result =
          await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
      logI('文件: ${result.toString()}');
      HubView.showToast('存证二维码保存成功');
    } else {
      HubView.showToastAfterLoadingHubDismiss('存证二维码保存失败');
    }
  }

  void _saveImage(GlobalKey key) async {
    ///需要filemanager
    HubView.showLoading();
    Uint8List _image = await QrEvents().qrToImage(key);
    logI(_image);

    FileManager.instance.copyU8ListFileToAppFolder(_image).then((value) async {
      HubView.dismiss();
      SaveUtils.saveOriginImage(value).then((value) {
        HubView.showToastAfterLoadingHubDismiss('保存成功');
      }).catchError((err) {
        HubView.showToastAfterLoadingHubDismiss('二维码保存失败');
      });
    }).catchError((err) {
      HubView.showToastAfterLoadingHubDismiss('二维码保存失败');
    });
  }
}
