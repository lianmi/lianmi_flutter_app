import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linkme_flutter_sdk/manager/AppManager.dart';
import 'package:linkme_flutter_sdk/manager/LogManager.dart';
import 'package:linkme_flutter_sdk/util/FileTool.dart';

import 'models.dart';

class Utils {
  static List<String> urlList = [
    'add_square',
    // 'people/square/ali.png',
    // 'people/ali_landscape.png',
    // 'people/square/peter.png',
    // 'people/square/sandra.png',
    // 'people/square/trevor.png',
    // 'places/india_tanjore_bronze_works.png',
    // 'places/india_tanjore_market_merchant.png',
    // 'places/india_tanjore_thanjavur_temple_carvings.png',
  ];

  static String getImgPath(String name, {String format: 'png'}) {
    return 'assets/images/$name.$format';
  }

  static Future<T?> pushPage<T extends Object>(
      BuildContext context, Widget page) {
    return Navigator.push(
      context,
      CupertinoPageRoute(builder: (ctx) => page),
    );
  }

  static void showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: Duration(seconds: 2),
      ),
    );
  }

  static Widget getWidget(String url) {
    if (url.startsWith('http')) {
      //return CachedNetworkImage(imageUrl: url, fit: BoxFit.cover);
      return InkWell(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: Image.network(
            url,
            fit: BoxFit.cover,
          ),
        ),
        onTap: () {
          logI('getWidget network image hit!');
        },
      );
      //Image.network(url, fit: BoxFit.cover);
    }
    if (url.endsWith('.png')) {
      return InkWell(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: Image.asset(
            url,
            fit: BoxFit.cover,
            package: 'flutter_gallery_assets',
          ),
        ),
        onTap: () {
          logI('getWidget flutter_gallery_assets hit!');
        },
      );
    }
    if (url == 'add_square') {
      return InkWell(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: Image.asset(
            getImgPath(url),
            fit: BoxFit.cover,
          ),
        ),
        onTap: () {
          logI('add_square hit!');
          FilePicker.platform.pickFiles().then((result) {
            if (result != null) {
              String extName =
                  result.files.single.path.toString().split('.').last;
              logI(
                  'result.files.single.path: ${result.files.single.path}, extName: $extName ');

              File file = File(result.files.single.path!);
              var dir = AppManager.appDocumentDir;
              String targetFileName =
                  FileTool.createFilePath(dir!.path, extName);

              file.copy(targetFileName).then((newFile) {
                logI("targetFileName:  $targetFileName");
                logI("newFile:  ${newFile.absolute.path}");
                // if (extName == 'pdf') {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (_) => PdfViewPage(targetFileName),
                //     ),
                //   );
                // }

                addTestData(targetFileName);
              });
            } else {
              // User canceled the picker
              logW('User canceled the picker');
            }
          });
        },
      );
    }
    return Image.file(File(url), fit: BoxFit.cover);
  }

  // static Widget getWidget(String url) {
  //   if (url.startsWith('http')) {
  //     //return CachedNetworkImage(imageUrl: url, fit: BoxFit.cover);
  //     return Image.network(url, fit: BoxFit.cover);
  //   }
  //   if (url.endsWith('.png')) {
  //     return Image.asset(url,
  //         fit: BoxFit.cover, package: 'flutter_gallery_assets');
  //   }
  //   //return Image.file(File(url), fit: BoxFit.cover);
  //   return Image.asset(getImgPath(url), fit: BoxFit.cover);
  // }

  static Image? getBigImage(String? url) {
    if (url == null || url.isEmpty) return null;
    if (url.startsWith('http')) {
      //return Image(image: CachedNetworkImageProvider(url), fit: BoxFit.cover);
      return Image.network(url, fit: BoxFit.cover);
    }
    if (url.endsWith('.png')) {
      return Image.asset(url,
          fit: BoxFit.cover, package: 'flutter_gallery_assets');
    }
    //return Image.file(File(url), fit: BoxFit.cover);
    return Image.asset(getImgPath(url), fit: BoxFit.cover);
  }

  static addTestData(String targetFileName) {
    urlList.add(targetFileName);
  }

  static List<ImageBean> getTestData() {
    List<ImageBean> list = [];
    for (int i = 0; i < urlList.length; i++) {
      String url = urlList[i];
      list.add(ImageBean(
        originPath: url,
        middlePath: url,
        thumbPath: url,
        originalWidth: i == 0 ? 264 : null,
        originalHeight: i == 0 ? 258 : null,
        fileExtent: url.split('.').last,
      ));
    }
    return list;
  }
}
