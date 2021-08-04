import 'dart:io';

import 'package:lianmiapp/header/common_header.dart';
import 'package:flutter/material.dart';
import 'package:lianmiapp/pages/legalattest/page/models.dart';
import 'package:lianmiapp/pages/legalattest/page/utils.dart';
import 'package:lianmiapp/widgets/my_app_bar.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
import 'package:nine_grid_view/nine_grid_view.dart';

class BrowserNineGridViewPage extends StatefulWidget {
  final List<String> attachList;

  BrowserNineGridViewPage(this.attachList);

  @override
  _BrowserNineGridViewPageState createState() =>
      _BrowserNineGridViewPageState();
}

class _BrowserNineGridViewPageState extends State<BrowserNineGridViewPage> {
  String _title = '查看附件';

  NineGridType _gridType = NineGridType.weChat;

  int _imageCount = 0;

  List<String> _attachList = [];
  List<ImageBean> imageList = [];

  @override
  void initState() {
    super.initState();
    _attachList = widget.attachList;
    _imageCount = _attachList.length;

    _readOldAttachList();
  }

  _readOldAttachList() {
    _attachList.forEach((url) {
      Utils.addTestData(url);
    });
    imageList = Utils.getTestData();
    logI('_readOldAttachList :  ${imageList.length}');
    imageList.forEach((bean) {
      logI('_readOldAttachList, thumbPath : ${bean.thumbPath}');
    });
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
          return Utils.getBrowserWidget(context, bean.thumbPath!, () {
            logW('BrowserNineGridViewPage _buildItem callback');
            // imageList = Utils.getTestData();
            // _imageCount = imageList.length;
            // setState(() {});
          }, originPath: bean.originPath!); //如果pdf则用assets
        },
      ),
    );
  }

  Widget myNineGridView(BuildContext context) {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: 1,
        padding: EdgeInsets.all(0),
        itemBuilder: (BuildContext context, int index) {
          return _buildItem(context, index);
        });
  }

  @override
  Widget build(BuildContext context) {
    imageList = Utils.getTestData();
    _imageCount = imageList.length;

    logI('build, _imageCount :  $_imageCount');
    imageList.forEach((bean) {
      logI('build, thumbPath : ${bean.thumbPath}');
    });
    return Scaffold(
      appBar: MyCustomAppBar(
        centerTitle: '$_title',
        actions: [],
      ),
      backgroundColor: Color(0XFFF4F5F6),
      // body: SafeArea(child: Container(child: _photoArea())));

      body: myNineGridView(context),
    );
  }
}
