// import 'package:lianmiapp/header/common_header.dart';
// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// // import 'package:flutter_qr_reader/flutter_qr_reader.dart';
// import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:provider/provider.dart';
// import 'package:lianmiapp/provider/qr_scan_view_model.dart';
// import 'package:wechat_assets_picker/wechat_assets_picker.dart';

// class QrScanPage extends StatefulWidget {
//   QrScanPage({Key? key}) : super(key: key);

//   @override
//   _QrScanPageState createState() => _QrScanPageState();
// }

// class _QrScanPageState extends State<QrScanPage> {
//   late QrScanViewModel _viewModel;

//   ///闪光灯是否打开
//   bool _isFlashlightOpen = false;

//   @override
//   void initState() {
//     _viewModel = QrScanViewModel();
//     initPower();
//     super.initState();
//   }

//   void initPower() async {
//     Future.delayed(Duration(milliseconds: 500), () async {
//       await Permission.photos.request();
//       await Permission.camera.request();
//       await Permission.storage.request();
//       // 申请结果
//       bool isPermission = await Permission.storage.isGranted;
//       logD('权限是否申请成功: $isPermission');
//       if (isPermission) {
//         _viewModel.isPower = true;
//       } else {
//         AppNavigator.goBack(context);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<QrScanViewModel>.value(
//       value: _viewModel,
//       child: Scaffold(
//         body: Consumer<QrScanViewModel>(
//           builder: (BuildContext context, model, child) {
//             return Column(
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(0),
//                   margin: EdgeInsets.all(0),
//                   width: Adapt.px(375),
//                   height: Adapt.px(487),
//                   child: Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       model.isPower
//                           ? QrReaderView(
//                               width: Adapt.px(375),
//                               height: Adapt.px(487),
//                               callback: (container) {
//                                 model.qrController = container;
//                                 model.qrController.startCamera(model.onScan);
//                               },
//                             )
//                           : Center(
//                               child: Text(""),
//                             ),
//                       Opacity(
//                         opacity: 0.9,
//                         child: Stack(
//                           alignment: Alignment.center,
//                           children: [
//                             Container(
//                               width: double.infinity,
//                               height: double.infinity,
//                               decoration: BoxDecoration(
//                                 color: Colors.black26,
//                               ),
//                             ),
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Container(
//                                   width: Adapt.px(200),
//                                   height: Adapt.px(200),
//                                   decoration: BoxDecoration(
//                                     color: Colors.white38,
//                                   ),
//                                   child: Stack(
//                                     children: [
//                                       Positioned(
//                                         left: 0,
//                                         top: 0,
//                                         child: Container(
//                                           height: Adapt.px(23),
//                                           width: Adapt.px(23),
//                                           decoration: BoxDecoration(
//                                             border: Border(
//                                               left: BorderSide(
//                                                 width: Adapt.px(5),
//                                                 color: Colours.app_main,
//                                               ),
//                                               top: BorderSide(
//                                                 width: Adapt.px(5),
//                                                 color: Colours.app_main,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Positioned(
//                                         right: 0,
//                                         top: 0,
//                                         child: Container(
//                                           height: Adapt.px(23),
//                                           width: Adapt.px(23),
//                                           decoration: BoxDecoration(
//                                             border: Border(
//                                               right: BorderSide(
//                                                 width: Adapt.px(5),
//                                                 color: Colours.app_main,
//                                               ),
//                                               top: BorderSide(
//                                                 width: Adapt.px(5),
//                                                 color: Colours.app_main,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Positioned(
//                                         left: 0,
//                                         bottom: 0,
//                                         child: Container(
//                                           height: Adapt.px(23),
//                                           width: Adapt.px(23),
//                                           decoration: BoxDecoration(
//                                             border: Border(
//                                               left: BorderSide(
//                                                 width: Adapt.px(5),
//                                                 color: Colours.app_main,
//                                               ),
//                                               bottom: BorderSide(
//                                                 width: Adapt.px(5),
//                                                 color: Colours.app_main,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Positioned(
//                                         right: 0,
//                                         bottom: 0,
//                                         child: Container(
//                                           height: Adapt.px(23),
//                                           width: Adapt.px(23),
//                                           decoration: BoxDecoration(
//                                             border: Border(
//                                               right: BorderSide(
//                                                 width: Adapt.px(5),
//                                                 color: Colours.app_main,
//                                               ),
//                                               bottom: BorderSide(
//                                                 width: Adapt.px(5),
//                                                 color: Colours.app_main,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: Adapt.px(30),
//                                 ),
//                                 Text('将二维码放入框内，即可自动扫描',
//                                     style: TextStyle(color: Colors.black)),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       Positioned(
//                         top: Adapt.px(40),
//                         left: Adapt.px(16),
//                         child: GestureDetector(
//                             onTap: () {
//                               AppNavigator.goBack(context);
//                             },
//                             child: Container(
//                               width: 40.px,
//                               height: 40.px,
//                               alignment: Alignment.center,
//                               child: Image.asset(
//                                 ImageStandard.imSoundRecoreClose,
//                                 width: Adapt.px(40),
//                                 height: Adapt.px(40),
//                                 fit: BoxFit.cover,
//                               ),
//                             )),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: Container(
//                     height: double.infinity,
//                     padding: EdgeInsets.all(0),
//                     margin: EdgeInsets.all(0),
//                     decoration: BoxDecoration(
//                       color: Colors.black,
//                     ),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Container(
//                           child: GestureDetector(
//                             onTap: () {
//                               assert(model.qrController != null);
//                               model.qrController.setFlashlight();
//                               setState(() {
//                                 _isFlashlightOpen = !_isFlashlightOpen;
//                               });
//                             },
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Image.asset(
//                                   _isFlashlightOpen
//                                       ? ImageStandard.imScanLightClose
//                                       : ImageStandard.imScanLightOpen,
//                                   width: Adapt.px(60),
//                                   height: Adapt.px(60),
//                                 ),
//                                 SizedBox(
//                                   height: Adapt.px(14),
//                                 ),
//                                 Text(
//                                   _isFlashlightOpen ? '关闭手电' : '打开手电',
//                                   style: TextStyle(color: Colors.black),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Container(
//                           child: GestureDetector(
//                             onTap: () async {
//                               _photoAction();
//                               // PickedFile image = await ImagePicker().getImage(
//                               //   source: ImageSource.gallery,
//                               // );
//                               // if (image == null) return;
//                               // final rest = await FlutterQrReader.imgScan(image.path);
//                               // print(rest);
//                             },
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Image.asset(
//                                   ImageStandard.imScanPic,
//                                   width: Adapt.px(60),
//                                   height: Adapt.px(60),
//                                 ),
//                                 SizedBox(
//                                   height: Adapt.px(14),
//                                 ),
//                                 Text('打开相册',
//                                     style: TextStyle(color: Colors.black)),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }

//   void _photoAction() {
//     AssetPicker.pickAssets(context,
//             requestType: RequestType.image, maxAssets: 1)
//         .then((assets) async {
//       if (assets != null && assets.length > 0) {
//         AssetEntity asset = assets.first;
//         File? file = await asset.file;
//         _copyFileAndUpload(file!.path, asset.type);
//       }
//     });
//   }

//   void _copyFileAndUpload(String sourceFile, AssetType type) {
//     FileManager.instance.copyFileToAppFolder(sourceFile).then((value) async {
//       String data = await FlutterQrReader.imgScan(value);
//       AppNavigator.goBackWithParams(context, data);
//     });
//   }
// }
