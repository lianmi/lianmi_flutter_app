import 'package:lianmiapp/component/type_choose.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/legalattest/provider/hetong_provider.dart';
import 'package:lianmiapp/pages/me/widget/store_review/action_item.dart';
import 'package:lianmiapp/pages/me/widget/store_review/input_item.dart';
import 'package:lianmiapp/util/keyboard_utils.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
import 'NineGridViewPage.dart';

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
      return '姓名不能为空';
    }
  };
  final TextEditingController _ctrlJiafangPhone = TextEditingController();
  Function vali_jiafangPhone = (value) {
    if (value.isEmpty) {
      return '联系电话不能为空';
    }
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _info(),
        ],
      ),
    );
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
        case 4:
          typeText = '其它';
          break;

        default:
      }

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
              title: "姓名",
              hintText: '请输入姓名',
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
              title: "联系电话",
              hintText: '请输入联系电话',
              controller: _ctrlJiafangPhone,
              valid: vali_jiafangPhone,
              button: Container(),
              onChange: (String text) {
                Provider.of<HetongProvider>(context, listen: false)
                    .hetongData
                    .jiafangPhone = text;
              },
            ),
            //TODO 增加附件
            InkWell(
              onTap: () {
                AppNavigator.push(
                        context,
                        NineGridViewPage(
                            Provider.of<HetongProvider>(context, listen: false)
                                .hetongData
                                .attachs))
                    .then((value) {
                  if (value != null) {
                    logI("Back Params value: ${value['attachList']}");
                    Provider.of<HetongProvider>(context, listen: false)
                        .hetongData
                        .attachs = value['attachList'];

                    setState(() {});
                  }
                });
              },
              child: Container(
                height: 60,
                margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("增加附件", style: TextStyle(fontSize: 16)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            '总数${Provider.of<HetongProvider>(context, listen: false).hetongData.attachs.length}个')
                      ],
                    )
                  ],
                ),
              ),
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
          '其它',
        ],
        onTap: (int index) {
          Provider.of<HetongProvider>(context, listen: false).hetongData.type =
              index + 1;
          setState(() {});
        });
  }

/*
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


  */
}
