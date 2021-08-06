import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lianmiapp/pages/legalattest/gallery/browserPhoto.dart';
import 'package:lianmiapp/pages/legalattest/gallery/rotation_examples.dart';
import 'package:lianmiapp/pages/legalattest/pdfview/browserPdfViewPage.dart';
import 'package:lianmiapp/pages/legalattest/pdfview/pdfViewPage.dart';
import 'package:lianmiapp/util/app_navigator.dart';
import 'package:linkme_flutter_sdk/manager/LogManager.dart';
import 'models.dart'; //TODO 需要增加provider来实现动态变化

class Utils {
  static List<String> urlList = [];

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

  static Widget getWidget(
      BuildContext context, String url, void Function() callback,
      {String? originPath}) {
    logI('getWidget: $url');

    if (url == 'pdf') {
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
          logD('pdf hit!, originPath: $originPath');

          AppNavigator.push(context, PdfViewPage(originPath!)).then((value) {
            if (value != null) {
              logI("PdfViewPage Back Params value: ${value['path']}");
              if (value['path'] == originPath) {
                delTestData(originPath);
                logW('删除' + originPath);
              }
            }

            callback(); // setState(() {});
          });
        },
      );
    }

    return InkWell(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Image.file(File(url), fit: BoxFit.cover),
      ),
      onTap: () {
        logD('file hit!, url: $url');

        AppNavigator.push(context, ProgrammaticRotationExample(url))
            .then((value) {
          if (value != null) {
            logI(
                "ProgrammaticRotationExample Back Params value: ${value['path']}");
            if (value['path'] == url) {
              delTestData(url);
              logW('getWidget, 删除' + url);
            }
          }
          callback(); // setState(() {});
        });
      },
    );
  }

  static Widget getBrowserWidget(BuildContext context, String aliyunossUrl,
      String url, void Function() callback,
      {String? originPath}) {
    logI('getBrowserWidget: $url');

    if (url == 'pdf') {
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
          logD('pdf hit!, originPath: $originPath');

          AppNavigator.push(
                  context, BrowserPdfViewPage(aliyunossUrl, originPath!))
              .then((value) {});
        },
      );
    }

    return InkWell(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Image.file(File(url), fit: BoxFit.cover),
      ),
      onTap: () {
        logD('file hit!, url: $url');

        AppNavigator.push(context, BrowserPhoto(url)).then((value) {});
      },
    );
  }

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

    return Image.file(File(url), fit: BoxFit.cover);
    // return Image.asset(getImgPath(url), fit: BoxFit.cover);
  }

  static addTestData(String targetFileName) {
    if (urlList.contains(targetFileName) == false) {
      urlList.add(targetFileName);
    }
  }

  static delTestData(String targetFileName) {
    if (urlList.contains(targetFileName)) {
      urlList.remove(targetFileName);
    }
  }

  static List<ImageBean> getTestData() {
    List<ImageBean> list = [];
    for (int i = 0; i < urlList.length; i++) {
      String url = urlList[i];
      if (url.split('.').last == 'pdf') {
        list.add(ImageBean(
          originPath: url,
          middlePath: url,
          thumbPath: 'pdf',
          originalWidth: i == 0 ? 264 : null,
          originalHeight: i == 0 ? 258 : null,
          fileExtent: url.split('.').last,
        ));
      } else {
        list.add(ImageBean(
          originPath: url,
          middlePath: url,
          thumbPath: url,
          originalWidth: i == 0 ? 264 : null,
          originalHeight: i == 0 ? 258 : null,
          fileExtent: url.split('.').last,
        ));
      }
    }
    return list;
  }
}
