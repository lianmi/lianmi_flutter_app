import 'dart:io';

import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/legalattest/gallery/browserPhoto.dart';
import 'package:lianmiapp/pages/legalattest/page/models.dart';
import 'package:lianmiapp/pages/me/widget/store_review/input_item.dart';

import 'package:lianmiapp/pages/product/provider/standart_provider.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
import 'package:nine_grid_view/nine_grid_view.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

class StandartWidget extends StatefulWidget {
  @override
  _StandartWidgetState createState() => _StandartWidgetState();
}

class _StandartWidgetState extends State<StandartWidget> {
  List<String> _localUrls = []; //图片数组对应的本地完整路径
  List<ImageBean> imageList = [];

  final TextEditingController _ctrlProductName = TextEditingController();
  Function vali_ProductName = (value) {
    if (value == 0) {
      return '商品名称不能为空';
    }
  };

  final TextEditingController _ctrlMobile = TextEditingController();
  Function vali_Mobile = (value) {
    if (value == 0) {
      return '手机不能为空';
    }
  };

  final TextEditingController _ctrlTitle = TextEditingController();
  Function vali_Title = (value) {
    if (value == 0) {
      return '标题不能为空';
    }
  };

  final TextEditingController _ctrlDescription = TextEditingController();
  Function vali_description = (value) {
    if (value.isEmpty) {
      return '内容不能为空';
    }
  };

  final TextEditingController _ctrlCount = TextEditingController();
  Function vali_Count = (value) {
    if (value.isEmpty) {
      return '数量不能为空';
    }
  };

  final TextEditingController _ctrlMultiple = TextEditingController();
  Function vali_Multiple = (value) {
    if (value.isEmpty) {
      return '倍数不能为空';
    }
  };

  @override
  void initState() {
    super.initState();

    _ctrlProductName.text =
        Provider.of<StandartProvider>(context, listen: false)
            .standartOrderData
            .productName!;
    _ctrlMobile.text = AppManager.currentMobile!;
    _ctrlTitle.text = Provider.of<StandartProvider>(context, listen: false)
        .standartOrderData
        .productName!;
    _ctrlDescription.text =
        Provider.of<StandartProvider>(context, listen: false)
            .standartOrderData
            .description!;
    _ctrlCount.text = '1';
    _ctrlMultiple.text = '1';

    logW('StandartWidget initState');
  }

  @override
  Widget build(BuildContext context) {
    imageList = getTestData();

    logI('build, _imageCount :  ${imageList.length}');
    imageList.forEach((bean) {
      logI('build, thumbPath : ${bean.thumbPath}');
    });
    return Container(
      child: Column(
        children: [
          _info(),
          _photosArea(),
        ],
      ),
    );
  }

  Widget _info() {
    return Consumer<StandartProvider>(builder: (context, provider, child) {
      return Container(
        margin: EdgeInsets.fromLTRB(16, 0, 0, 0),
        child: Column(
          children: [
            InputItem(
              title: "产品名称",
              hintText: '请填写产品名称',
              controller: _ctrlProductName,
              valid: vali_ProductName,
              button: Container(),
              onChange: (String text) {
                Provider.of<StandartProvider>(context, listen: false)
                    .standartOrderData
                    .productName = text;
              },
            ),

            InputItem(
              title: "订单标题",
              hintText: '请填写订单标题',
              controller: _ctrlTitle,
              valid: vali_Title,
              button: Container(),
              onChange: (String text) {
                Provider.of<StandartProvider>(context, listen: false)
                    .standartOrderData
                    .title = text;
              },
            ),
            InputItem(
              title: "内容",
              hintText: '请输入内容',
              controller: _ctrlDescription,
              valid: vali_description,
              button: Container(),
              onChange: (String text) {
                Provider.of<StandartProvider>(context, listen: false)
                    .standartOrderData
                    .description = text;
              },
            ),

            InputItem(
              title: "联系电话",
              hintText: '请输入联系电话',
              controller: _ctrlMobile,
              valid: vali_Mobile,
              button: Container(),
              onChange: (String text) {
                Provider.of<StandartProvider>(context, listen: false)
                    .standartOrderData
                    .mobile = text;
              },
            ),
            InputItem(
              title: "数量",
              hintText: '请输入数量',
              controller: _ctrlCount,
              valid: vali_Count,
              button: Container(),
              onChange: (String text) {
                Provider.of<StandartProvider>(context, listen: false)
                    .standartOrderData
                    .count = int.parse(text);
              },
            ),
            InputItem(
              title: "倍数",
              hintText: '请输入倍数',
              controller: _ctrlMultiple,
              valid: vali_Multiple,
              button: Container(),
              onChange: (String text) {
                Provider.of<StandartProvider>(context, listen: false)
                    .standartOrderData
                    .multiple = int.parse(text);
              },
            ),
            CommonText('下单后请到订单详情上传选号拍照或图片')
            //TODO 增加附件
            // InkWell(
            //   onTap: () {
            //     _showMedia();
            //   },
            //   child: Container(
            //     height: 60,
            //     margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Text("增加附件", style: TextStyle(fontSize: 16)),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Text(
            //                 '总数${Provider.of<StandartProvider>(context, listen: false).standartOrderData.attachs.length}个')
            //           ],
            //         )
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      );
    });
  }

  //交互图片区
  Widget _photosArea() {
    return Container(
      margin: EdgeInsets.only(top: 20.px),
      // padding: EdgeInsets.fromLTRB(23.px, 0, 23.px, 16.px),
      padding: EdgeInsets.fromLTRB(1.px, 0, 1.px, 1.px),
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          _ninePhotosArea(context),
        ],
      ),
    );
  }

  Widget _ninePhotosArea(BuildContext context) {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: 1,
        padding: EdgeInsets.all(0),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return _buildItem(context, index);
        });
  }

  Widget getBrowserWidget(
      BuildContext context, String url, void Function() callback,
      {String? originPath}) {
    // logI('getBrowserWidget: $url');

    return InkWell(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Image.file(File(url), fit: BoxFit.cover),
      ),
      onTap: () {
        // logD('file hit!, url: $url');

        AppNavigator.push(context, BrowserPhoto(url)).then((value) {});
      },
    );
  }

  Widget _buildItem(BuildContext context, int _index) {
    int itemCount = _localUrls.length;

    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(width: 0.33, color: Color(0xffe5e5e5)))),
      padding: EdgeInsets.all(0),
      child: NineGridView(
        margin: EdgeInsets.all(12),
        padding: EdgeInsets.all(5),
        space: 5,
        type: NineGridType.weChat,
        color: Color(0XFFE5E5E5),
        itemCount: itemCount,
        itemBuilder: (BuildContext context, int index) {
          ImageBean bean = imageList[index]; //图片数组

          return getBrowserWidget(context, _localUrls[index], () {
            logW('BrowserNineGridViewPage _buildItem callback');

            setState(() {});
          }, originPath: bean.originPath!); //如果pdf则用assets
        },
      ),
    );
  }

  void _showMedia() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
              child: Column(
            mainAxisSize: MainAxisSize.min, // 设置最小的弹出
            children: <Widget>[
              ListTile(
                title: Text("拍照"),
                onTap: () async {
                  Navigator.of(context).pop();
                  _cameraAction();
                },
              ),
              ListTile(
                title: Text("相册"),
                onTap: () async {
                  Navigator.of(context).pop();
                  _photoAction();
                },
              ),
            ],
          ));
        });
  }

  void _cameraAction() {
    CameraPicker.pickFromCamera(context, enableRecording: false)
        .then((value) async {
      AssetEntity asset = value!;
      File? file = await asset.file;
      // _UploadImage(file!.path, asset.type);
      addTestData(file!.path);
      //TODO
      logD('增加到附件数组, file.path: ${file.path}');
      Provider.of<StandartProvider>(context, listen: false)
          .standartOrderData
          .attachs
          .add(file.path);
      setState(() {});
    });
  }

  void _photoAction() {
    AssetPicker.pickAssets(context,
            requestType: RequestType.image, maxAssets: 1)
        .then((assets) async {
      if (assets != null && assets.length > 0) {
        AssetEntity asset = assets.first;
        File? file = await asset.file;
        // _UploadImage(file!.path, asset.type);
        addTestData(file!.path);
        //TODO
        logD('增加到附件数组, file.path: ${file.path}');
        Provider.of<StandartProvider>(context, listen: false)
            .standartOrderData
            .attachs
            .add(file.path);
        setState(() {});
      }
    });
  }

  addTestData(String targetFileName) {
    if (_localUrls.contains(targetFileName) == false) {
      _localUrls.add(targetFileName);
    }
  }

  List<ImageBean> getTestData() {
    List<ImageBean> list = [];
    for (int i = 0; i < _localUrls.length; i++) {
      String url = _localUrls[i];
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
