import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';

import 'package:lianmiapp/util/app.dart';
import 'package:lianmiapp/util/other_utils.dart';
import 'package:lianmiapp/widgets/my_app_bar.dart';
import 'package:linkme_flutter_sdk/manager/LogManager.dart';
import 'package:linkme_flutter_sdk/sdk/OrderMod.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:permission_handler/permission_handler.dart';

class BrowserPdfViewPage extends StatefulWidget {
  final String aliyunossUrl;
  final String locallyPdfPath;

  BrowserPdfViewPage(this.aliyunossUrl, this.locallyPdfPath);

  @override
  _BrowserPdfViewPageState createState() => _BrowserPdfViewPageState();
}

class _BrowserPdfViewPageState extends State<BrowserPdfViewPage> {
  String _title = 'PDF文件预览';
  String pathPDF = "";
  String remotePDFpath = "";

  @override
  void initState() {
    super.initState();
    logI('BrowserPdfViewPage initState, aliyunossUrl: ${widget.aliyunossUrl}');
  }


//动态申请权限，ios 要在info.plist 上面添加
  Future<bool> requestPermission() async {
    var status = await Permission.photos.status;
    return status.isGranted;
  }

  /// 调起浏览器下载当前文档
  _saveStoreage() async {
    OrderMod.getSignedUrl(widget.aliyunossUrl).then((value) {
      logI('调起浏览器下载当前文档, value: $value');
      Utils.launchBrowser(value);
    }).catchError((e) {
      logE(e);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyCustomAppBar(
          centerTitle: '$_title',
          actions: [
            App.isShop
                ? TextButton(
                    onPressed: () {
                      _saveStoreage();
                    },
                    child: Text("下载"),
                  )
                : SizedBox(),

          ],
        ),
        backgroundColor: Color(0XFFF4F5F6),
        body: PDFScreen(path: widget.locallyPdfPath));
  }
}

class PDFScreen extends StatefulWidget {
  final String? path;

  PDFScreen({Key? key, this.path}) : super(key: key);

  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';
  String _localPdfPath = '';

  @override
  void initState() {
    super.initState();
    _localPdfPath = widget.path!;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        PDFView(
          filePath: widget.path,
          enableSwipe: true,
          swipeHorizontal: true,
          autoSpacing: false,
          pageFling: true,
          pageSnap: true,
          defaultPage: currentPage!,
          fitPolicy: FitPolicy.BOTH,
          preventLinkNavigation:
              false, // if set to true the link is handled in flutter
          onRender: (_pages) {
            setState(() {
              pages = _pages;
              isReady = true;
            });
          },
          onError: (error) {
            setState(() {
              errorMessage = error.toString();
            });
            // print(error.toString());
          },
          onPageError: (page, error) {
            setState(() {
              errorMessage = '$page: ${error.toString()}';
            });
            // print('$page: ${error.toString()}');
          },
          onViewCreated: (PDFViewController pdfViewController) {
            _controller.complete(pdfViewController);
          },
          onLinkHandler: (String? uri) {
            // print('goto uri: $uri');
          },
          onPageChanged: (int? page, int? total) {
            // print('page change: $page/$total');
            setState(() {
              currentPage = page;
            });
          },
        ),
        errorMessage.isEmpty
            ? !isReady
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container()
            : Center(
                child: Text(errorMessage),
              )
      ],
    );
  }
}
