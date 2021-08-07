import 'dart:io';
import 'package:lianmiapp/header/common_header.dart';
import 'package:flutter/material.dart';
import 'package:lianmiapp/pages/legalattest/gallery/browserPhoto.dart';
import 'package:lianmiapp/pages/legalattest/page/models.dart';
import 'package:lianmiapp/pages/legalattest/pdfview/browserPdfViewPage.dart';
import 'package:lianmiapp/pages/product/model/order_model.dart';
import 'package:lianmiapp/widgets/my_app_bar.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
import 'package:nine_grid_view/nine_grid_view.dart';

class BrowserNineGridViewPage extends StatefulWidget {
  final OrderModel order;

  BrowserNineGridViewPage(this.order);

  @override
  _BrowserNineGridViewPageState createState() =>
      _BrowserNineGridViewPageState();
}

class _BrowserNineGridViewPageState extends State<BrowserNineGridViewPage> {
  String _title = '查看附件';
  late OrderModel order;

  NineGridType _gridType = NineGridType.weChat;

  int _imageCount = 0;

  List<String> _attachList = [];
  List<ImageBean> imageList = [];
  //  static List<String> _attachList = [];

  @override
  void initState() {
    super.initState();
    this.order = widget.order;
    _attachList = widget.order.cunzhengModelData!.attachs;
    _imageCount = _attachList.length;

    _readOldAttachList();
  }

  addTestData(String targetFileName) {
    if (_attachList.contains(targetFileName) == false) {
      _attachList.add(targetFileName);
    }
  }

  List<ImageBean> getTestData() {
    List<ImageBean> list = [];
    for (int i = 0; i < _attachList.length; i++) {
      String url = _attachList[i];
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

  _readOldAttachList() {
    _attachList.forEach((url) {
      addTestData(url);
    });
    imageList = getTestData();
    logI('_readOldAttachList :  ${imageList.length}');
    imageList.forEach((bean) {
      logI('_readOldAttachList, thumbPath : ${bean.thumbPath}');
    });
  }

  String getImgPath(String name, {String format: 'png'}) {
    return 'assets/images/$name.$format';
  }

  Widget getBrowserWidget(BuildContext context, String aliyunossUrl, String url,
      void Function() callback,
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
          if (FileManager.instance.isExist(originPath!) == false) {
            logW('文件不存在！ originPath: $originPath');
            appManager.getOrderImages(aliyunossUrl).then((value) {
              AppNavigator.push(
                      context, BrowserPdfViewPage(aliyunossUrl, originPath))
                  .then((value) {});
            });
          } else {
            AppNavigator.push(
                    context, BrowserPdfViewPage(aliyunossUrl, originPath))
                .then((value) {});
          }
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

  Widget _buildItem(BuildContext context, int _index) {
    int itemCount = _imageCount;

    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(width: 0.33, color: Color(0xffe5e5e5)))),
      padding: EdgeInsets.all(0),
      child: NineGridView(
        margin: EdgeInsets.all(12),
        padding: EdgeInsets.all(5),
        space: 5,
        type: _gridType,
        color: Color(0XFFE5E5E5),
        itemCount: itemCount,
        itemBuilder: (BuildContext context, int index) {
          ImageBean bean = imageList[index]; //图片数组
          String aliyunossUrl = order.cunzhengModelData!.attachsAliyun == null
              ? ''
              : order.cunzhengModelData!.attachsAliyun![index];
          return getBrowserWidget(context, aliyunossUrl, bean.thumbPath!, () {
            logW('BrowserNineGridViewPage _buildItem callback');
          }, originPath: bean.originPath!); //如果pdf则用assets
        },
      ),
    );
  }

  Widget myNineGridView(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: 1,
        padding: EdgeInsets.all(0),
        itemBuilder: (BuildContext context, int index) {
          return _buildItem(context, index);
        });
  }

  @override
  Widget build(BuildContext context) {
    imageList = getTestData();
    _imageCount = imageList.length;

    logI('build, _imageCount :  $_imageCount');
    imageList.forEach((bean) {
      logI('build, thumbPath : ${bean.thumbPath}');
    });
    return Scaffold(
      appBar: MyCustomAppBar(
        centerTitle: '$_title',
        actions: [
          TextButton(
            onPressed: () {
              order.cunzhengModelData!.attachs.clear();
              order.cunzhengModelData!.attachsAliyun!.forEach((furl) async {
                logI('准备同步附件: $furl');
                String? url = await appManager.getOrderImages(furl);
                if (url != '') {
                  logI('同步附件成功, url: $url');

                  order.cunzhengModelData!.attachs.add(url!);

                  setState(() {});
                } else {
                  logI('同步附件错误: $url');
                }
              });
            },
            child: Text('同步'),
          )
        ],
      ),
      backgroundColor: Color(0XFFF4F5F6),
      // body: SafeArea(child: Container(child: _photoArea())));

      body: myNineGridView(context),
    );
  }
}
