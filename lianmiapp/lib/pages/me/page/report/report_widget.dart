import 'package:lianmiapp/component/image_choose.dart';
import 'package:lianmiapp/component/type_choose.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/me/provider/report_provider.dart';
import 'package:lianmiapp/pages/me/widget/store_review/action_item.dart';
import 'package:lianmiapp/pages/me/widget/store_review/input_item.dart';
import 'package:lianmiapp/pages/me/widget/store_review/multi_input_item.dart';
import 'package:lianmiapp/util/keyboard_utils.dart';
import 'package:lianmiapp/widgets/load_image.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';

class ReportWidget extends StatefulWidget {
  @override
  _ReportWidgetState createState() => _ReportWidgetState();
}

class _ReportWidgetState extends State<ReportWidget> {
  // final TextEditingController _ctrlTitle = TextEditingController();
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
    return Consumer<ReportProvider>(builder: (context, provider, child) {
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
                  child: isValidString(provider.reportData.image1)
                      ? LoadImageWithHolder(
                          prefix + provider.reportData.image1,
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
                  child: isValidString(provider.reportData.image2)
                      ? LoadImageWithHolder(
                          prefix + provider.reportData.image2,
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
    return Consumer<ReportProvider>(builder: (context, provider, child) {
      String typeText = '请选择举报类型 >';
      if (provider.reportData.type > 0) {
        switch (provider.reportData.type) {
          case 1:
            typeText = '政治';
            break;
          case 2:
            typeText = '色情';
            break;
          case 3:
            typeText = '其它';
            break;

          default:
        }
      }

      _ctrlDescription.text = provider.reportData.description;
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
            MultiInputItem(
              title: "内容",
              maxline: 3,
              hintText: '请输入内容',
              controller: _ctrlDescription,
              valid: vali_description,
              button: Container(),
              onChange: (String text) {
                Provider.of<ReportProvider>(context, listen: false)
                    .reportData
                    .description = text;
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
        title: '请选择举报类型',
        list: [
          '政治',
          '色情',
          '其它',
        ],
        onTap: (int index) {
          Provider.of<ReportProvider>(context, listen: false).reportData.type =
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
          UserMod.uploadOssFile(path, 'msgs', (String url) async {
            HubView.dismiss();
            logI('上传图片成功:$url');
            if (type == 0) {
              Provider.of<ReportProvider>(context, listen: false)
                  .reportData
                  .image1 = url;
            } else {
              Provider.of<ReportProvider>(context, listen: false)
                  .reportData
                  .image2 = url;
            }
            setState(() {});
          }, (String errMsg) {
            HubView.dismiss();
            logE('上传图片错误:$errMsg');
            HubView.showToastAfterLoadingHubDismiss('上传图片错误:$errMsg');
          }, (int progress) {
            // print('上传图片进度:$progress');
          });
        });
      }
    });
  }
}
