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

///扫码Ca证书二维码
class ScanPage extends StatefulWidget {
  RsaKeyPairModel pair = new RsaKeyPairModel();

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> with QrEvents {
  ScanController controller = ScanController();
  String qrcode = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: MyCustomAppBar(
            centerTitle: '扫码导入证书',
          ),
          backgroundColor: Colors.white,
          body: SafeArea(
              child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 400,
                  height: 400,
                  child: ScanView(
                    controller: controller,
                    scanAreaScale: .7,
                    scanLineColor: Colors.green.shade400,
                    onCapture: (data) {
                      setState(() {
                        qrcode = data;
                        RsaKeyPairModel pair = RsaKeyPairModel.fromJson(qrcode);
                        AppManager.setLocalPrikey(pair.privateKey!);
                        AppManager.setLocalPubkey(pair.publicKey!);
                        logI('导入结果privateKey: ${pair.privateKey}');
                        logI('导入结果publicKey: ${pair.publicKey}');

                        // AppNavigator.push(context, UserCenterPage());
                        HubView.showToast('CA证书二维码导入成功');
                        Navigator.of(context).pop();
                      });
                    },
                  ),
                ),
                Text('对准CA证书二维码扫码'),
              ],
            ),
          ))),
    );
  }
}
