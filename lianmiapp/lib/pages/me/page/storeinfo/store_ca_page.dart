import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:lianmiapp/component/type_choose.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/me/events/qr_events.dart';
import 'package:lianmiapp/pages/me/page/storeinfo/store_scan_page.dart';
import 'package:lianmiapp/pages/me/page/user_center_page.dart';
import 'package:lianmiapp/res/colors.dart';
import 'package:lianmiapp/res/styles.dart';
import 'package:lianmiapp/util/save_utils.dart';
import 'package:lianmiapp/widgets/widget/button/custom_icon_button.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
import 'package:linkme_flutter_sdk/models/RsaKeyPairModel.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scan/scan.dart';
import 'package:images_picker/images_picker.dart';
import 'package:flutter/services.dart';

///Ca证书二维码
class StoreCaPage extends StatefulWidget {
  // final String caPair = '';
  // StoreCaPage({required this.qrurl});

  RsaKeyPairModel pair = RsaKeyPairModel(
    privateKey: AppManager.localPrikey,
    publicKey: AppManager.localPubkey,
  );

  @override
  _StoreCaPageState createState() => _StoreCaPageState();
}

class _StoreCaPageState extends State<StoreCaPage> with QrEvents {
  final GlobalKey _qrKey = GlobalKey();
  // ScanController controller = ScanController();
  // String qrcode = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyCustomAppBar(
          centerTitle: 'CA证书二维码',
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
              _qrWidget(widget.pair.toJson()),
              Gaps.vGap16,
              Text('证书公钥是商户提供给用户的附件加密之用', style: TextStyles.font15()),
              Gaps.vGap16,
              Text('加密后的用户附件暂存在服务端OSS空间里', style: TextStyles.font15()),
              Gaps.vGap16,
              Text('业务结束后，服务端OSS空间会删除这些加密文件', style: TextStyles.font15()),
              Gaps.vGap16,
              Text('证书私钥存在本地，用于解密用户的附件', style: TextStyles.font15()),
              Gaps.vGap16,
              Text('证书必须保管好，丢失将无法解密用户的附件', style: TextStyles.font15()),
              Gaps.vGap16,
              Text('重装app之后，须导入并恢复证书', style: TextStyles.font15()),
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
              embeddedImage: ExactAssetImage('assets/images/ca.png'),
            )));
  }

  void _showMore() {
    TypeChoose.show(
        title: 'CA数字证书',
        list: [
          '保存CA证书二维码到相册',
          '从相册恢复证书',
          '扫码恢复证书',
        ],
        onTap: (int index) {
          if (index == 0) {
            _saveCaQrcode();
          } else if (index == 1) {
            _loadCaQrcode();
          } else {
            AppNavigator.push(context, ScanPage());
          }
        });
  }

  _saveCaQrcode() async {
    RenderRepaintBoundary boundary =
        _qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await (image.toByteData(format: ui.ImageByteFormat.png)
        as FutureOr<ByteData?>);
    if (byteData != null) {
      final result =
          await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
      logI('文件: ${result.toString()}');
      HubView.showToast('CA证书二维码保存成功');
    } else {
      HubView.showToastAfterLoadingHubDismiss('CA证书二维码保存失败');
    }
  }

//从相册里读取CA证书的二维码并恢复到本地数据表
  _loadCaQrcode() async {
    List<Media>? res = await ImagesPicker.pick();
    if (res != null) {
      String? str = await Scan.parse(res[0].path);
      if (str != null) {
        RsaKeyPairModel pair = RsaKeyPairModel.fromJson(str);
        AppManager.setLocalPrikey(pair.privateKey!);
        AppManager.setLocalPubkey(pair.publicKey!);
        logI('导入结果privateKey: ${pair.privateKey}');
        logI('导入结果publicKey: ${pair.publicKey}');

        // AppNavigator.push(context, UserCenterPage());

        HubView.showToast('CA证书二维码导入成功');
        Navigator.of(context).pop();
      }
    }
  }
}
