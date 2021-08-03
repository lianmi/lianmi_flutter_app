import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:lianmisdk/ui/pdfview/pdfViewPage.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
import 'package:linkme_flutter_sdk/util/FileTool.dart';

import 'package:nine_grid_view/nine_grid_view.dart';
import 'package:lianmisdk/ui/nineGridViewPage/models.dart';
import 'package:lianmisdk/ui/nineGridViewPage/utils.dart';

class NineGridViewPage extends StatefulWidget {
  @override
  _NineGridViewPageState createState() => _NineGridViewPageState();
}

class _NineGridViewPageState extends State<NineGridViewPage> {
  String _title = '九宫格文件缩略预览';

  NineGridType _gridType = NineGridType.weChat;

  int _imageCount = 1;

  List<ImageBean> imageList = [];

  @override
  void initState() {
    super.initState();
    imageList = Utils.getTestData();
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

          return Utils.getWidget(bean.middlePath!);
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
    return Scaffold(
      appBar: AppBar(
        title: Text('$_title'),
        centerTitle: true,
        actions: <Widget>[],
      ),
      body: myNineGridView(context),
    );
  }
}
