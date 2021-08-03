import 'dart:io';

import 'package:flutter/services.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/product/model/order_model.dart';
import 'package:lianmiapp/res/view_standard.dart';
import 'package:lianmiapp/util/keyboard_utils.dart';
import 'package:lianmiapp/widgets/load_image.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

class PrizePage extends StatefulWidget {
  @override
  _PrizePageState createState() => _PrizePageState();
}

class _PrizePageState extends State<PrizePage> {
  TextEditingController _textController = TextEditingController();

  String? _imageLocalPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyCustomAppBar(
          centerTitle: '兑奖',
        ),
        backgroundColor: Color(0XFFF4F5F6),
        body: SafeArea(
            child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(top: 8.px),
                width: double.infinity,
                height: 317.px,
                color: Colors.white,
                child: Column(
                  children: [_moneyArea(), _photoArea()],
                ),
              ),
              _detailBottomButton('确定', onTap: () {
                _confirm();
              })
            ],
          ),
        )));
  }

  Widget _moneyArea() {
    return Container(
      padding: ViewStandard.padding,
      width: double.infinity,
      height: 54.px,
      child: Row(
        children: [
          CommonText(
            '兑奖金额',
            fontSize: 14.px,
            color: Colors.black,
          ),
          Gaps.hGap16,
          Expanded(
              child: TextField(
            controller: _textController,
            textAlign: TextAlign.left,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            style: TextStyle(fontSize: 14.px, color: Colors.black),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(16)
            ],
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '请输入兑奖金额',
              hintStyle: TextStyle(color: Colors.black26),
              counterText: '',
            ),
            onSubmitted: (String text) {},
          ))
        ],
      ),
    );
  }

  Widget _photoArea() {
    return Expanded(
        child: Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Container(
            padding: ViewStandard.padding,
            height: 44.px,
            alignment: Alignment.centerLeft,
            child: CommonText(
              '上传兑奖拍照',
              fontSize: 14.px,
              color: Colors.black,
            ),
          ),
          Expanded(
            child: Container(
              padding: ViewStandard.padding,
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () {
                  _showMedia();
                },
                child: isValidString(_imageLocalPath)
                    ? LoadImageWithHolder(
                        _imageLocalPath!,
                        holderImg: ImageStandard.logo,
                        width: 164.px,
                        height: 190.px,
                      )
                    : Image.asset(
                        ImageStandard.lotteryPhotoUpload,
                        width: 164.px,
                        height: 190.px,
                      ),
              ),
            ),
          )
        ],
      ),
    ));
  }

  Widget _detailBottomButton(String title,
      {double topMargin = 0, required Function onTap}) {
    return InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          margin: EdgeInsets.only(top: topMargin),
          padding: EdgeInsets.fromLTRB(16.px, 12.px, 16.px, 12.px),
          height: 64.px,
          alignment: Alignment.center,
          color: Colors.white,
          child: Container(
            width: double.infinity,
            height: 40.px,
            decoration: BoxDecoration(
                color: Color(0XFFFF4400),
                borderRadius: BorderRadius.all(Radius.circular(4.px)),
                boxShadow: [
                  BoxShadow(
                      color: Color(0XFFFF4400),
                      offset: Offset(0.0, 0.0),
                      blurRadius: 4.px,
                      spreadRadius: 0)
                ]),
            alignment: Alignment.center,
            child: CommonText(
              title,
              fontSize: 16.px,
              color: Colors.white,
            ),
          ),
        ));
  }

  void _showMedia() {
    KeyboardUtils.hideKeyboard(context);
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
      if (value != null) {
        AssetEntity asset = value;
        File? file = await asset.file;
        setState(() {
          _imageLocalPath = file!.path;
        });
      }
    });
  }

  void _photoAction() {
    AssetPicker.pickAssets(context,
            requestType: RequestType.image, maxAssets: 1)
        .then((assets) async {
      if (assets != null && assets.length > 0) {
        AssetEntity asset = assets.first;
        File? file = await asset.file;
        setState(() {
          _imageLocalPath = file!.path;
        });
      }
    });
  }

  void _confirm() {
    if (isValidString(_textController.text) == false) {
      HubView.showToast('请输入兑奖金额');
      return;
    }
    if (isValidString(_imageLocalPath) == false) {
      HubView.showToast('请上传拍照图片');
      return;
    }
    AppNavigator.goBackWithParams(context,
        {'money': _textController.text, 'imageLocalPath': _imageLocalPath});
  }
}
