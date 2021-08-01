import 'dart:typed_data';

import 'package:flutter/rendering.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart' as sdk;
import 'package:qr_flutter/qr_flutter.dart';

class meQrcodePage extends StatelessWidget {
  sdk.UserInfo? _user = null;
  GlobalKey globalKey = GlobalKey();
  Uint8List? newPngBytes;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Theme(
        data: ThemeData(
          backgroundColor: Colors.white,
        ),
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
                tooltip: 'Back',
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xff333333),
                ),
              ),
              backgroundColor: Colors.white,
              centerTitle: true,
              actions: [
                IconButton(
                  icon: Icon(Icons.more_horiz),
                  color: Colors.black,
                  tooltip: "Scan",
                  onPressed: () {
                    this.showModalButtomSheet(context);
                  },
                )
              ],
              elevation: 0,
            ),
            body: FutureBuilder<dynamic>(
              future: _networkData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                // 请求已结束
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    // 请求失败，显示错误
                    return Text("Error: ${snapshot.error}");
                  } else {
                    // 请求成功，显示数据
                    // return Text("Contents: ${snapshot.data}");
                    sdk.UserInfo user = snapshot.data as sdk.UserInfo;
                    this._user = user;
                    return _body(user);
                  }
                } else {
                  // 请求未结束，显示loading
                  return Container();
                }
              },
            )));
  }

  Widget _body(sdk.UserInfo user) {
    return Container(
      child: Column(
        children: [
          RepaintBoundary(
            key: globalKey,
            child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                      height: 110,
                    ),
                    Center(
                        child: QrImage(
                      data: user.userName!,
                      size: 200.0,
                      gapless: false,
                      embeddedImage: NetworkImage(user.avatar!),
                      // embeddedImage: (user.avatar == null || user.avatar == '')
                      //     ? NetworkImage(user.avatar)
                      //     : ExactAssetImage('assets/images/logo.png'),
                      embeddedImageStyle:
                          QrEmbeddedImageStyle(size: Size(30, 30)),
                    )),
                    //
                  ],
                )),
          ),
          Text("扫一扫，加我为好友")
        ],
      ),
    );
  }

  _networkData() {
    return sdk.UserMod.getMyProfile();
  }

  // GlobalKey globalKey = GlobalKey();
  // Uint8List newPngBytes;

  static Future<void> saveImage1(GlobalKey globalKey) async {
    // RenderObject? boundary =
    //     globalKey.currentContext!.findRenderObject();
    // var image = await boundary!.toImage(pixelRatio: 6.0);
    // ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    // Uint8List pngBytes = byteData.buffer.asUint8List();
    // final result = await ImageGallerySaver.saveImage(pngBytes, quality: 100);
    // if (result["isSuccess"]) {
    //   // print('ok');
    //   showToast('保存成功');
    // } else {
    //   print('error');
    // }
  }

  saveImage(sdk.UserInfo user) async {
    QrImage qr = QrImage(
      data: user.userName!,
      version: QrVersions.auto,
      size: 182,
      gapless: false,
      embeddedImage: NetworkImage(user.avatar!),
      // embeddedImage: (user.avatar == null || user.avatar == '')
      //     ? NetworkImage(user.avatar)
      //     : ExactAssetImage('assets/images/logo.png'), //
      embeddedImageStyle: QrEmbeddedImageStyle(
        size: Size(80, 80),
      ),
    );
    // Uint8List _image = await qrToImage(qr.key);
    // try {
    //   final result = await ImageGallerySaver.saveImage(_image,
    //       quality: 100, name: "二维码_${DateTime.now().toString()}");
    //   print('图片保存：' + result.toString());
    //   showToast('二维码保存成功');
    // } catch (e) {
    //   showToast('二维码保存失败');
    // }
  }

  Future<Uint8List?> qrToImage(GlobalKey key) async {
    return null;
    // TODO: implement qrToImage
    // try {
    //   print('inside');
    //   RenderRepaintBoundary boundary = key.currentContext.findRenderObject();
    //   ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    //   ByteData byteData =
    //       await image.toByteData(format: ui.ImageByteFormat.png);
    //   Uint8List pngBytes = byteData.buffer.asUint8List();
    //   print('图片转化成功');
    //   return pngBytes;
    // } catch (e) {
    //   return Uint8List(10);
    // }
  }

  void showModalButtomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
            height: 125,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    // sdk.AppManager.gRepository.deleteBankCard(bc.id);
                    // AppNavigator.push(context, WLTBankCardPage());
                    Navigator.of(context).pop();
                    // Navigator.of(context).push(me_utils.createPageRouter(
                    //     SlideDirection.bottom2top, Gallery()));
                    if (this._user != null) {
                      saveImage1(this.globalKey);
                    }
                  },
                  child: Container(
                      // margin: EdgeInsets.fromLTRB(0, 12, 0, 12),
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Color(0xFFF5F5F5),
                                width: 1.0,
                                style: BorderStyle.solid)),
                      ),
                      height: 60,
                      child: Center(
                          child: Text("保存相册",
                              style: TextStyle(
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16)))),
                ),
                InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                        height: 60,
                        // margin: EdgeInsets.fromLTRB(0, 12, 0, 12),
                        child: Center(
                            child: Text("取消",
                                style: TextStyle(
                                    color: Color(0XFFFF4400),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16)))))
              ],
            ));
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// // import 'package:interviewer_app/common/component_index.dart';
// // 一定要引入这三个插件
// import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:lianmiapp/res/gaps.dart';
// import 'package:oktoast/oktoast.dart';
// import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// import 'package:flutter/services.dart';
// import 'dart:ui' as ui;
// import 'dart:typed_data';
// import 'dart:io';
//
// class ShareJob extends StatefulWidget {
//   const ShareJob({Key key, this.searchKey}) : super(key: key);
//   final String searchKey;
//
//
//   @override
//   State<StatefulWidget> createState() {
//
//     return new _ShareJobState();
//   }
// }
//
// class _ShareJobState extends State<ShareJob> {
// // globalKey 在这里设置
//   GlobalKey globalKey = GlobalKey();
//   Uint8List newPngBytes;
//
//   Widget shareImage() {
//     return
//       RepaintBoundary(
//           key: globalKey,
//           child:
//           Container(
//
//             child:
//             // 图片
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Container(
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                       color: Color(0xFF5B9AFF),
//                       boxShadow:[
//                         BoxShadow(
//                             color: Color(0x1A000000),
//                             offset: Offset(0, 5.0),
//                             blurRadius: 24.0
//                         ),
//                       ]),
//
//                   width: MediaQuery.of(context).size.width * 0.6,
//
//                   child:
//                   Column(
//                     children: [
//                       Gaps.vGap5,
//                       Text('热招职位', style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w300),),
//                       Gaps.vGap5,
//                       Container(
//                         margin: EdgeInsets.only(bottom: 22,left: 15,right: 15),
//                         // padding: EdgeInsets.only(bottom: 22,left: 15,right: 15),
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(10.0),
//                             boxShadow:[
//                               BoxShadow(
//                                   color: Color(0x1A000000),
//                                   offset: Offset(0, 5.0),
//                                   blurRadius: 24.0
//                               ),
//                             ]),
//                         // padding: EdgeInsets.all(10),
//                         // margin: EdgeInsets.only(bottom: 6),
//                         // width: MediaQuery.of(context).size.width * 0.6,
//                         // height: 305,
//                         child: Column(
//                           children: [
//                             Gaps.vGap5,
//                             Gaps.vGap10,
//                             Text('测试工程师', style: TextStyle(fontSize: 15, color: Color(0xFF313753), fontWeight: FontWeight.w500),),
//                             Gaps.vGap10,
//                             Text('15k-20K | 上海', style: TextStyle(fontSize: 15, color: Color(0xFFF4A25A), fontWeight: FontWeight.w500),),
//                             Gaps.vGap10,
//                             Text('公司名', style: TextStyle(fontSize: 10, color: Color(0xFF313753), fontWeight: FontWeight.w400),),
//                             Gaps.vGap15,
//                             Gaps.vGap5,
//                             Text('长按查看职位详情', style: TextStyle(fontSize: 9, color: Color(0xFF313753), fontWeight: FontWeight.w400),),
//                             Gaps.vGap5,
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//
//           )
//       );
//   }
//
//   /// 保存图片
//   static Future<void> saveImage(GlobalKey globalKey) async {
//     RenderRepaintBoundary boundary =
//     globalKey.currentContext.findRenderObject();
//     var image = await boundary.toImage(pixelRatio: 6.0);
//     ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//     Uint8List pngBytes = byteData.buffer.asUint8List();
//     final result = await ImageGallerySaver.saveImage(pngBytes,
//         quality: 60, name: "hello2");
//     if (result) {
//       // print('ok');
//       showToast("保存成功");
//     } else {
//       print('error');
//     }
//
//     // if (Platform.isIOS) {
//     //   var status = await Permission.photos.status;
//     //   if (status.isRestricted) {
//     //     Map<Permission, PermissionStatus> statuses = await [
//     //       Permission.photos,
//     //     ].request();
//     //     saveImage(globalKey);
//     //   }
//     //   if (status.isGranted) {
//     //     final result = await ImageGallerySaver.saveImage(pngBytes,
//     //         quality: 60, name: "hello");
//     //     if (result) {
//     //       print('ok');
//     //       // toast("保存成功", wring: false);
//     //     } else {
//     //       print('error');
//     //       // toast("保存失败");
//     //     }
//     //   }
//     //   if (status.isDenied) {
//     //     print("IOS拒绝");
//     //   }
//     // } else if (Platform.isAndroid) {
//     //   var status = await Permission.storage.status;
//     //   if (status.isRestricted) {
//     //     Map<Permission, PermissionStatus> statuses = await [
//     //       Permission.storage,
//     //     ].request();
//     //     saveImage(globalKey);
//     //   }
//     //   if (status.isGranted) {
//     //     print("Android已授权");
//     //     final result = await ImageGallerySaver.saveImage(pngBytes, quality: 60);
//     //     if (result != null) {
//     //       print('ok');
//     //       // toast("保存成功", wring: false);
//     //     } else {
//     //       print('error');
//     //       // toast("保存失败");
//     //     }
//     //   }
//     //   if (status.isDenied) {
//     //     print("Android拒绝");
//     //   }
//     // }
//   }
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: AppBar(title: Text('分享职位'), titleSpacing: 0, centerTitle: true),
//       body: SingleChildScrollView(
//         child: Container(
//           child: Column(children: [
//             Gaps.vGap5,
//             Row(
//               children: [
//                 // http://images.shejidaren.com/wp-content/uploads/2020/03/36365-4.png
//                 // IconButton(
//                 //   iconSize: 22,
//                 //   icon: const Icon(Icons.close),
//                 //   onPressed: (){
//                 //   },
//                 // )
//                 Gaps.hGap5,
//                 Gaps.hGap10,
//                 Gaps.hGap10,
//                 Column(
//                   children: [
//                     Container(
//                       decoration: new BoxDecoration(
//                         color:Colors.black,
//                         borderRadius: BorderRadius.circular(100),
//                       ),
//                       padding: EdgeInsets.all(10),
//                       margin: EdgeInsets.only(bottom: 6),
//                       width: 60,
//                       height: 60,
//                       child: Image.network(
//                           'http://images.shejidaren.com/wp-content/uploads/2020/03/36365-4.png'),
//                     ),
//                     Text(
//                       '微信好友',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(color: Colors.white, fontSize: 14),
//                     )
//                   ],
//                 ),
//
//                 Gaps.hGap5,
//                 Gaps.hGap10,
//                 Gaps.hGap10,
//                 Column(
//                   children: [
//                     Container(
//                       decoration: new BoxDecoration(
//                         color: Colors.blue[100],
//                         borderRadius: BorderRadius.circular(100),
//                       ),
//                       padding: EdgeInsets.all(10),
//                       margin: EdgeInsets.only(bottom: 6),
//                       width: 60,
//                       height: 60,
//                       child: Image.network(
//                           'https://www.sj520.cn/sc/ima/weixin_sj520_11.jpg'),
//                     ),
//                     Text(
//                       '朋友圈',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(color: Colors.blue[100], fontSize: 14),
//                     )
//                   ],
//                 ),
//               ],
//             ),
//             Gaps.vGap20,
//             // 灰色横线
//             Container(
//               decoration: new BoxDecoration(color: Colors.blue[100]),
//               width: double.infinity,
//               height: 10,
//             ),
//             Gaps.vGap15,
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Text(
//                   '已生成朋友圈图片',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(color: Colors.black.withOpacity(0.65), fontSize: 14),
//                 ),
//               ],
//             ),
//             Gaps.vGap15,
//             shareImage(),
//             Gaps.vGap15,
//             Gaps.vGap10,
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 RaisedButton(
//                   color: Colors.blue[100],
//                   highlightColor: Colors.blue[100],
//                   colorBrightness: Brightness.dark,
//                   splashColor: Colors.blue[100],
//                   padding: EdgeInsets.only(left: 34,right: 34),
//                   child: Text(
//                     "保存至相册",
//                     style: TextStyle(color: Colors.white, fontSize: 14),
//                   ),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20.0)),
//                   onPressed: () async {
//
//                     print('------');
//                     print(globalKey.currentContext);
//                     // createImageFromRepaintBoundary(globalKey);
//                     // final g = createImageFromWidget(saveImage());
//                     // print(g);
//                     saveImage(globalKey);
//                   },
//                 ),
//               ],
//             ),
//             Gaps.vGap5,
//             Gaps.vGap5,
//
//           ]),
//         ),
//       ),
//     );
//   }
// }
