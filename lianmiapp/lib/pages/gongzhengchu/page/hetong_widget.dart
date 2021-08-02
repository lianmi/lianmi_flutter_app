import 'package:lianmiapp/component/image_choose.dart';
import 'package:lianmiapp/component/type_choose.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/gongzhengchu/provider/hetong_provider.dart';
import 'package:lianmiapp/pages/me/widget/store_review/action_item.dart';
import 'package:lianmiapp/pages/me/widget/store_review/input_item.dart';
import 'package:lianmiapp/util/keyboard_utils.dart';
import 'package:lianmiapp/widgets/load_image.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';

class HetongWidget extends StatefulWidget {
  @override
  _HetongWidgetState createState() => _HetongWidgetState();
}

class _HetongWidgetState extends State<HetongWidget> {
  final TextEditingController _ctrlTitle = TextEditingController();
  Function vali_title = (value) {
    if (value == 0) {
      return '类型不能为空';
    }
  };

  final TextEditingController _ctrlDescription = TextEditingController();
  Function vali_description = (value) {
    if (value.isEmpty) {
      return '内容不能为空';
    }
  };
  final TextEditingController _ctrlJiafangName = TextEditingController();
  Function vali_jiafangName = (value) {
    if (value.isEmpty) {
      return '甲方名称不能为空';
    }
  };
  final TextEditingController _ctrlJiafangPhone = TextEditingController();
  Function vali_jiafangPhone = (value) {
    if (value.isEmpty) {
      return '甲方联系电话不能为空';
    }
  };
  final TextEditingController _ctrlJiafangLegalName = TextEditingController();
  Function vali_jiafangLegalName = (value) {
    if (value.isEmpty) {
      return '甲方法人不能为空';
    }
  };
  final TextEditingController _ctrlJiafangAddress = TextEditingController();
  Function vali_jiafangAddress = (value) {
    if (value.isEmpty) {
      return '甲方地址不能为空';
    }
  };
  final TextEditingController _ctrlYifangName = TextEditingController();
  Function vali_yifangName = (value) {
    if (value.isEmpty) {
      return '乙方名称不能为空';
    }
  };
  final TextEditingController _ctrlYifangPhone = TextEditingController();
  Function vali_yifangPhone = (value) {
    if (value.isEmpty) {
      return '乙方联系电话不能为空';
    }
  };
  final TextEditingController _ctrlYifangHuji = TextEditingController();
  Function vali_yifangHuji = (value) {
    if (value.isEmpty) {
      return '乙方户籍不能为空';
    }
  };
  final TextEditingController _ctrlYifangAddress = TextEditingController();
  Function vali_yifangAddress = (value) {
    if (value.isEmpty) {
      return '乙方地址不能为空';
    }
  };
  final TextEditingController _ctrlYifangIdCard = TextEditingController();
  Function vali_yifangIdCard = (value) {
    if (value.isEmpty) {
      return '乙方身份证号码不能为空';
    }
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _info(),
          _idImages(),
        ],
      ),
    );
  }

  Widget _idImages() {
    String prefix = 'https://lianmi-ipfs.oss-cn-hangzhou.aliyuncs.com/';
    return Consumer<HetongProvider>(builder: (context, provider, child) {
      return Container(
          margin: EdgeInsets.fromLTRB(16, 20, 16, 0),
          child: Column(
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  child: Text("截图",
                      style:
                          TextStyle(color: Color(0xff888888), fontSize: 14))),
              Gaps.vGap32,
              InkWell(
                onTap: () {
                  _idenAction(0);
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(88, 0, 88, 0),
                  child: isValidString(provider.hetongData.image1)
                      ? LoadImageWithHolder(
                          prefix + provider.hetongData.image1!,
                          holderImg: ImageStandard.logo,
                          width: 200.px,
                        )
                      : Image(
                          width: double.maxFinite,
                          image: ExactAssetImage(
                              'assets/images/me/bankadd@3x.png')),
                ),
              ),
              Divider(
                color: Color(0xffDDDDDD),
                height: 30,
                thickness: 1,
                indent: 10,
                endIndent: 10,
              ),
              InkWell(
                onTap: () {
                  _idenAction(1);
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(88, 0, 88, 16),
                  child: isValidString(provider.hetongData.image2)
                      ? LoadImageWithHolder(
                          prefix + provider.hetongData.image2!,
                          holderImg: ImageStandard.logo,
                          width: 200.px,
                        )
                      : Image(
                          width: double.maxFinite,
                          image: ExactAssetImage(
                              'assets/images/me/bankadd@3x.png')),
                ),
              ),
              Divider(
                color: Color(0xffDDDDDD),
                height: 30,
                thickness: 1,
                indent: 10,
                endIndent: 10,
              ),
              InkWell(
                onTap: () {
                  _idenAction(2);
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(88, 0, 88, 16),
                  child: isValidString(provider.hetongData.image3)
                      ? LoadImageWithHolder(
                          prefix + provider.hetongData.image3!,
                          holderImg: ImageStandard.logo,
                          width: 200.px,
                        )
                      : Image(
                          width: double.maxFinite,
                          image: ExactAssetImage(
                              'assets/images/me/bankadd@3x.png')),
                ),
              ),
              Divider(
                color: Color(0xffDDDDDD),
                height: 30,
                thickness: 1,
                indent: 10,
                endIndent: 10,
              ),
              InkWell(
                onTap: () {
                  _idenAction(3);
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(88, 0, 88, 16),
                  child: isValidString(provider.hetongData.image4)
                      ? LoadImageWithHolder(
                          prefix + provider.hetongData.image4!,
                          holderImg: ImageStandard.logo,
                          width: 200.px,
                        )
                      : Image(
                          width: double.maxFinite,
                          image: ExactAssetImage(
                              'assets/images/me/bankadd@3x.png')),
                ),
              ),
              Divider(
                color: Color(0xffDDDDDD),
                height: 30,
                thickness: 1,
                indent: 10,
                endIndent: 10,
              ),
              InkWell(
                onTap: () {
                  _idenAction(4);
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(88, 0, 88, 16),
                  child: isValidString(provider.hetongData.image5)
                      ? LoadImageWithHolder(
                          prefix + provider.hetongData.image5!,
                          holderImg: ImageStandard.logo,
                          width: 200.px,
                        )
                      : Image(
                          width: double.maxFinite,
                          image: ExactAssetImage(
                              'assets/images/me/bankadd@3x.png')),
                ),
              ),
              Divider(
                color: Color(0xffDDDDDD),
                height: 30,
                thickness: 1,
                indent: 10,
                endIndent: 10,
              ),
              InkWell(
                onTap: () {
                  _idenAction(5);
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(88, 0, 88, 16),
                  child: isValidString(provider.hetongData.image6)
                      ? LoadImageWithHolder(
                          prefix + provider.hetongData.image6!,
                          holderImg: ImageStandard.logo,
                          width: 200.px,
                        )
                      : Image(
                          width: double.maxFinite,
                          image: ExactAssetImage(
                              'assets/images/me/bankadd@3x.png')),
                ),
              ),
              Divider(
                color: Color(0xffDDDDDD),
                height: 30,
                thickness: 1,
                indent: 10,
                endIndent: 10,
              ),
              InkWell(
                onTap: () {
                  _idenAction(6);
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(88, 0, 88, 16),
                  child: isValidString(provider.hetongData.image7)
                      ? LoadImageWithHolder(
                          prefix + provider.hetongData.image7!,
                          holderImg: ImageStandard.logo,
                          width: 200.px,
                        )
                      : Image(
                          width: double.maxFinite,
                          image: ExactAssetImage(
                              'assets/images/me/bankadd@3x.png')),
                ),
              ),
              Divider(
                color: Color(0xffDDDDDD),
                height: 30,
                thickness: 1,
                indent: 10,
                endIndent: 10,
              ),
              InkWell(
                onTap: () {
                  _idenAction(7);
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(88, 0, 88, 16),
                  child: isValidString(provider.hetongData.image8)
                      ? LoadImageWithHolder(
                          prefix + provider.hetongData.image8!,
                          holderImg: ImageStandard.logo,
                          width: 200.px,
                        )
                      : Image(
                          width: double.maxFinite,
                          image: ExactAssetImage(
                              'assets/images/me/bankadd@3x.png')),
                ),
              ),
              Divider(
                color: Color(0xffDDDDDD),
                height: 30,
                thickness: 1,
                indent: 10,
                endIndent: 10,
              ),
              InkWell(
                onTap: () {
                  _idenAction(8);
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(88, 0, 88, 16),
                  child: isValidString(provider.hetongData.image9)
                      ? LoadImageWithHolder(
                          prefix + provider.hetongData.image9!,
                          holderImg: ImageStandard.logo,
                          width: 200.px,
                        )
                      : Image(
                          width: double.maxFinite,
                          image: ExactAssetImage(
                              'assets/images/me/bankadd@3x.png')),
                ),
              ),
            ],
          ));
    });
  }

  Widget _info() {
    return Consumer<HetongProvider>(builder: (context, provider, child) {
      String typeText = '请选择合同类型 >';
      switch (provider.hetongData.type) {
        case 1:
          typeText = '劳动合同';
          break;
        case 2:
          typeText = '采购合同';
          break;
        case 3:
          typeText = '开发合同';
          break;

        default:
      }

      // _ctrlDescription.text = provider.hetongData.description ?? '';
      return Container(
        margin: EdgeInsets.fromLTRB(16, 0, 0, 0),
        child: Column(
          children: [
            ActtionItem(
              title: '类型',
              content: typeText,
              onTap: () {
                _showTypeSelect();
              },
            ),
            InputItem(
              title: "内容",
              hintText: '请输入内容',
              controller: _ctrlDescription,
              valid: vali_description,
              button: Container(),
              onChange: (String text) {
                Provider.of<HetongProvider>(context, listen: false)
                    .hetongData
                    .description = text;
              },
            ),
            InputItem(
              title: "甲方名称",
              hintText: '请输入甲方名称',
              controller: _ctrlJiafangName,
              valid: vali_jiafangName,
              button: Container(),
              onChange: (String text) {
                Provider.of<HetongProvider>(context, listen: false)
                    .hetongData
                    .jiafangName = text;
              },
            ),
            InputItem(
              title: "甲方联系电话",
              hintText: '请输入甲方联系电话',
              controller: _ctrlJiafangPhone,
              valid: vali_jiafangPhone,
              button: Container(),
              onChange: (String text) {
                Provider.of<HetongProvider>(context, listen: false)
                    .hetongData
                    .jiafangPhone = text;
              },
            ),
            InputItem(
              title: "甲方法人姓名",
              hintText: '请输入甲方法人姓名',
              controller: _ctrlJiafangLegalName,
              valid: vali_jiafangLegalName,
              button: Container(),
              onChange: (String text) {
                Provider.of<HetongProvider>(context, listen: false)
                    .hetongData
                    .jiafangLegalName = text;
              },
            ),
            InputItem(
              title: "甲方地址",
              hintText: '请输入甲方地址',
              controller: _ctrlJiafangAddress,
              valid: vali_jiafangAddress,
              button: Container(),
              onChange: (String text) {
                Provider.of<HetongProvider>(context, listen: false)
                    .hetongData
                    .jiafangAddress = text;
              },
            ),
            InputItem(
              title: "乙方名称",
              hintText: '请输入乙方名称',
              controller: _ctrlYifangName,
              valid: vali_yifangName,
              button: Container(),
              onChange: (String text) {
                Provider.of<HetongProvider>(context, listen: false)
                    .hetongData
                    .yifangName = text;
              },
            ),
            InputItem(
              title: "乙方联系电话",
              hintText: '请输入乙方联系电话',
              controller: _ctrlYifangPhone,
              valid: vali_yifangPhone,
              button: Container(),
              onChange: (String text) {
                Provider.of<HetongProvider>(context, listen: false)
                    .hetongData
                    .yifangPhone = text;
              },
            ),
            InputItem(
              title: "乙方户籍",
              hintText: '请输入乙方户籍',
              controller: _ctrlYifangHuji,
              valid: vali_yifangHuji,
              button: Container(),
              onChange: (String text) {
                Provider.of<HetongProvider>(context, listen: false)
                    .hetongData
                    .yifangHuji = text;
              },
            ),
            InputItem(
              title: "乙方地址",
              hintText: '请输入乙方地址',
              controller: _ctrlYifangAddress,
              valid: vali_yifangAddress,
              button: Container(),
              onChange: (String text) {
                Provider.of<HetongProvider>(context, listen: false)
                    .hetongData
                    .yifangAddress = text;
              },
            ),
            InputItem(
              title: "乙方身份证号码",
              hintText: '请输入乙方身份证号码',
              controller: _ctrlYifangIdCard,
              valid: vali_yifangIdCard,
              button: Container(),
              onChange: (String text) {
                Provider.of<HetongProvider>(context, listen: false)
                    .hetongData
                    .yifangIdCard = text;
              },
            ),
          ],
        ),
      );
    });
  }

  void _showTypeSelect() {
    KeyboardUtils.hideKeyboard(context);
    TypeChoose.show(
        title: '请选择合同类型',
        list: [
          '劳动合同',
          '采购合同',
          '开发合同',
        ],
        onTap: (int index) {
          Provider.of<HetongProvider>(context, listen: false).hetongData.type =
              index + 1;
          setState(() {});
        });
  }

  ///0:图片1  1:图片2
  void _idenAction(int type) {
    ImageChoose.instance.pickImage().then((path) {
      if (isValidString(path)) {
        FileManager.instance.copyFileToAppFolder(path).then((value) {
          HubView.showLoading();
          //需要加密
          UserMod.uploadOssOrderFile(path, (String url) async {
            HubView.dismiss();
            logI('上传加密图片成功:$url');
            if (type == 0) {
              Provider.of<HetongProvider>(context, listen: false)
                  .hetongData
                  .image1 = url;
            } else {
              Provider.of<HetongProvider>(context, listen: false)
                  .hetongData
                  .image2 = url;
            }
            setState(() {});
          }, (String errMsg) {
            HubView.dismiss();
            logE('上传加密图片错误:$errMsg');
            HubView.showToastAfterLoadingHubDismiss('上传加密图片错误:$errMsg');
          }, (int progress) {
            // print('上传加密图片进度:$progress');
          });
        });
      }
    });
  }
}
