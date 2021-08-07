import 'dart:io';
import 'dart:typed_data';
import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:lianmisdk/ui/gallery/browserPhoto.dart';
import 'package:lianmisdk/ui/nineGridViewPage/NineGridViewPage.dart';
import 'package:lianmisdk/ui/gallery/gallery_example.dart';
import 'package:lianmisdk/ui/pdfview/pdfViewPage.dart';
import '../widget/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
import 'package:linkme_flutter_sdk/sdk/OrderMod.dart';
import 'package:linkme_flutter_sdk/sdk/SdkEnum.dart';
import '../../application.dart';
import 'package:path_provider/path_provider.dart';
import 'package:linkme_flutter_sdk/util/FileTool.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:oss_dart/oss_dart.dart';

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
            _customButton('商家接单', onTap: () async {
              var orderID = "234729347293472309";

              var ok = await OrderMod.takeOrder(orderID);
              if (ok) {
                logD('商家接单完成');
              } else {
                logE('takeOrder错误');
              }
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
            _customButton('pdf文件选择并预览', onTap: () async {
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
            _customButton('存证区-上传', onTap: () async {
              OssClient client = OssClient(
                  bucketName: AppManager.ossConfig_cunzheng!.bucketName,
                  endpoint: AppManager.ossConfig_cunzheng!.endPoint,
                  tokenGetter: appManager.getStsAccountForCunZheng);

              fromAsset('assets/pdf/demo-link.pdf', 'demo.pdf').then((f) async {
                String uploadFile = f.path;
                logI('pathPDF: $uploadFile');
                var response;

                File _inputFile = File(uploadFile);
                final _fileContents = _inputFile.readAsBytesSync();

                //获取文件
                response = await client.putObject(
                    _fileContents, 'orders/id1/demo.pdf');
                print(response.statusCode);

                if (response.statusCode == 200) {
                  logI(' $uploadFile 存证区上传成功');
                } else {
                  logE(' $uploadFile 存证区上传失败 ');
                }
              });
            }),
            _customButton('存证区-下载', onTap: () async {
              OssClient client = OssClient(
                  bucketName: AppManager.ossConfig_cunzheng!.bucketName,
                  endpoint: AppManager.ossConfig_cunzheng!.endPoint,
                  tokenGetter: appManager.getStsAccountForCunZheng);

              String fileKey = 'orders/id1/demo.pdf'; //下载文件名
              var response;

              //获取文件
              response = await client.getObject(fileKey);
              // print(response.body);
              if (response.statusCode == 200) {
                String saveFile = AppManager.appDocumentDir!.path + '/demo.pdf';
                File file = File(saveFile);
                var raf = file.openSync(mode: FileMode.write);

                var _content = new Uint8List.fromList(response.body.codeUnits);

                raf.writeFromSync(_content);
                if (file.existsSync()) {
                  logI(' $saveFile 存证区下载成功');
                }
              }
            }),
            _customButton('用户资料区 - 上传', onTap: () async {
              //TODO
            }),
            _customButton('用户资料区 - 下载', onTap: () async {
              //TODO
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

  Future<File> fromAsset(String asset, String filename) async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    Completer<File> completer = Completer();

    try {
      var dir = await getApplicationDocumentsDirectory();
      logI("file dir:  ${dir.path}/$filename");

      File file = File("${dir.path}/$filename");
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }
}
