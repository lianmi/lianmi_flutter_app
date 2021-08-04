import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lianmisdk/ui/nineGridViewPage/NineGridViewPage.dart';
import 'package:lianmisdk/ui/gallery/gallery_example.dart';
import 'package:lianmisdk/ui/pdfview/pdfViewPage.dart';
import 'package:linkme_flutter_sdk/common/common.dart';
import 'package:linkme_flutter_sdk/util/file_cryptor.dart';
import '../widget/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
import 'package:linkme_flutter_sdk/sdk/OrderMod.dart';
import 'package:linkme_flutter_sdk/sdk/SdkEnum.dart';
import '../../application.dart';
import 'package:path_provider/path_provider.dart';
import 'package:libsignal_protocol_dart/src/ecc/curve.dart' as DH;
import 'package:linkme_flutter_sdk/util/hex.dart';
import 'package:linkme_flutter_sdk/util/FileTool.dart';

import 'package:permission_handler/permission_handler.dart';


class OrderPage extends StatefulWidget {
  OrderPage({Key? key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    _requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("order", 80, false).build(context),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            _oneColumnWidget(),
            // _twoColumnWidget(),
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
            _customButton('合同类图片加解密', onTap: () async {
              //TODO
              var test2 = DH.Curve.generateKeyPair();
              String test2PubKey = Hex.encode(test2.publicKey.serialize());
              String test2PrivKey = Hex.encode(test2.privateKey.serialize());

              logI('test2PubKey: $test2PubKey');
              logI('test2PrivKey: $test2PrivKey');

              String secret = OrderMod.calculateAgreement(
                  test2PubKey, Constant.systemPrivateKey);

              var saveDir = await getExternalStorageDirectory();

              FileCryptor fileCryptor = FileCryptor(
                key: secret, //64个字符
                iv: 16,
                dir: saveDir!.path,
                // useCompress: true,
              );

              //从相册里选择文件
              final _imageFile =
                  await _picker.getImage(source: ImageSource.gallery);
              if (_imageFile == null) {
                return null;
              }
              var filename = _imageFile.path;
              logI('从相册里选择文件filename : $filename');

              //计算出图片的hash字符串，用来做文件名
              String _outputFile = await OrderMod.getHash256(filename);

              File encryptedFile = await fileCryptor.encrypt(
                  inputFileFullPath: filename, outputFile: _outputFile);

              logI('完整路径 : ${encryptedFile.absolute.path}');

              UserMod.uploadOssOrderFile(encryptedFile.absolute.path,
                  (String url) async {
                logD('上传加密后的图片成功: $url');

                //将加密后的文件下载到本地
                var appDocDir = await getTemporaryDirectory();
                String savePath = appDocDir.path + "/" + _outputFile;
                String fileUrl =
                    "https://lianmi-ipfs.oss-cn-hangzhou.aliyuncs.com/" + url;
                await Dio().download(fileUrl, savePath,
                    onReceiveProgress: (count, total) {
                  // print((count / total * 100).toStringAsFixed(0) + "%");
                });

                File decryptedFile = await fileCryptor.decrypt(
                    inputFile: encryptedFile.absolute.path,
                    outputFile: _outputFile);

                logI('解密后文件完整路径 : ${decryptedFile.absolute.path}');

/*
TODO 不要删，以后完善example的权限
                final result = await ImageGallerySaver.saveFile(
                    decryptedFile.path + '.jpg');

                logI('解密后相册完整路径 : $result');
                */
              }, (String errMsg) {
                logD('上传加密后的图片错误:$errMsg');
              }, (int progress) {
                // logD('上传加密后的图片进度:$progress');
              });
            }),
            _customButton('预下单', onTap: () async {
              try {
                var f = OrderMod.preOrder(
                    'id3', 'f44264da-b070-4f4e-b1c8-7e1eb07008a4', 2, 'body',
                    payMode: 1);
                f.then((resp) {
                  logD('resp:\n $resp');
                }).catchError((err) {
                  logE('获取订单id错误: $err');
                });
              } catch (e) {
                logE('catch: $e');
              }
            }),
            _customButton('商家接单, 上传收款码', onTap: () async {
              final _imageFile =
                  await _picker.getImage(source: ImageSource.gallery);
              if (_imageFile == null) {
                return null;
              }
              var filename = _imageFile.path;

              var orderID = "406ec164-5ed5-4c57-a46e-0316f7fe9282";

              var ok = await OrderMod.takeOrder(orderID, filename);
              if (ok) {
                logD('上传完成');
              } else {
                logE('takeOrder错误');
              }
            }),
            _customButton('商家出票后拍照上链', onTap: () async {
              final _imageFile =
                  await _picker.getImage(source: ImageSource.gallery);
              if (_imageFile == null) {
                return null;
              }
              var filename = _imageFile.path;

              //2419b9c8a937f5527d3124cf8618748ecc957b7535c505c818ed752d7a77597a
              // logD(hash);

              String orderID = Application.changeStateOrderID;
              UserMod.uploadOssOrderFile(filename, (imageKey) {
                logD('$filename 上传完成, imageKey: $imageKey');

                var f = OrderMod.uploadorderimage(filename, orderID, imageKey);
                f.then((value) {
                  logD('上传完成, value: $value');
                }).catchError((err) {
                  logE('uploadorderimage错误: $err');
                });
              }, (errmsg) {
                logD('拍照上传失败, $errmsg');
              }, (percent) {
                //上传进度
              });
            }),
            _customButton('更改订单状态为已完成', onTap: () async {
              String orderID = Application.changeStateOrderID;
              logD('orderID: $orderID');

              OrderStateEnum status = OrderStateEnum.OS_Done;
              ProductOrderType orderType = ProductOrderType.POT_Normal;
              var f = OrderMod.changeOrderStatus(orderID, status, orderType);
              f.then((value) {
                if (value == true) {
                  logD('更改订单($orderID)成功');
                }
              }).catchError((err) {
                logE(err);
              });
            }),
            _customButton('订单详情', onTap: () async {
              String orderID = Application.changeStateOrderID;
              logD('orderID: $orderID');

              OrderInfoData _data = await OrderMod.getOrder(orderID);
              logD('订单详情: ${_data.toJson()}');
            }),
            _customButton('商家id3所有订单', onTap: () async {
              int status = OrderStateEnum.OS_Prepare.index; //查询所有预审核
              var _list = await OrderMod.getOrders(status);
              logD('订单列表: $_list');
            }),
            _customButton('中奖后用户上传收款码', onTap: () async {
              final _imageFile =
                  await _picker.getImage(source: ImageSource.gallery);
              if (_imageFile == null) {
                return null;
              }
              var filename = _imageFile.path;

              var orderID = "406ec164-5ed5-4c57-a46e-0316f7fe9282";

              var ok = await OrderMod.acceptPrize(orderID, 'id3', filename);
              if (ok) {
                logD('上传完成');
              } else {
                logE('acceptPrize错误');
              }
            }),
            _customButton('九宫格', onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => NineGridViewPage(),
                ),
              );
            }),
            _customButton('多图浏览', onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => GalleryExample(),
                ),
              );
            }),
            _customButton('文件选择并预览', onTap: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles();

              if (result != null) {
                String extName =  
                    result.files.single.path.toString().split('.').last;
                logI(
                    'result.files.single.path: ${result.files.single.path}, extName: $extName ');

                File file = File(result.files.single.path!);

                var dir = await getApplicationDocumentsDirectory();

                String targetFileName =
                    FileTool.createFilePath(dir.path, extName);
                File newFile = await file.copy(targetFileName);
                logI("targetFileName:  $targetFileName");
                logI("newFile:  ${newFile.absolute.path}");
                if (extName == 'pdf') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PdfViewPage(targetFileName),
                    ),
                  );
                }
              } else {
                // User canceled the picker
                logW('User canceled the picker');
              }
            }),
          ],
        ),
      ),
    );
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

  _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    final info = statuses[Permission.storage].toString();
    print(info);
    // _toastInfo(info);
  }
}
