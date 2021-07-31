import 'package:lianmiapp/component/image_choose.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/me/provider/propose_feedback_provider.dart';
import 'package:lianmiapp/pages/me/widget/store_review/input_item.dart';
import 'package:lianmiapp/widgets/load_image.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';

class ProposeFeedbackWidget extends StatefulWidget {
  @override
  _ProposeFeedbackWidgetState createState() => _ProposeFeedbackWidgetState();
}

class _ProposeFeedbackWidgetState extends State<ProposeFeedbackWidget> {
  final TextEditingController _ctrlTitle = TextEditingController();
  Function vali_title = (value) {
    if (value.isEmpty) {
      return '标题不能为空';
    }
  };

  final TextEditingController _ctrlDetail = TextEditingController();
  Function vali_detail = (value) {
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
    return Consumer<ProposeFeedbackProvider>(
        builder: (context, provider, child) {
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
                  child: isValidString(provider.proposeData.image1)
                      ? LoadImageWithHolder(
                          prefix + provider.proposeData.image1,
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
                  child: isValidString(provider.proposeData.image2)
                      ? LoadImageWithHolder(
                          prefix + provider.proposeData.image2,
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
    return Consumer<ProposeFeedbackProvider>(
        builder: (context, provider, child) {
      _ctrlTitle.text = provider.proposeData.title;
      _ctrlDetail.text = provider.proposeData.detail;
      return Container(
        margin: EdgeInsets.fromLTRB(16, 0, 0, 0),
        child: Column(
          children: [
            InputItem(
              title: "标题",
              hintText: '请输入标题',
              controller: _ctrlTitle,
              valid: vali_title,
              button: Container(),
              onChange: (String text) {
                Provider.of<ProposeFeedbackProvider>(context, listen: false)
                    .proposeData
                    .title = text;
              },
            ),
            InputItem(
              title: "内容",
              hintText: '请输入内容',
              controller: _ctrlDetail,
              valid: vali_detail,
              button: Container(),
              onChange: (String text) {
                Provider.of<ProposeFeedbackProvider>(context, listen: false)
                    .proposeData
                    .detail = text;
              },
            ),
          ],
        ),
      );
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
              Provider.of<ProposeFeedbackProvider>(context, listen: false)
                  .proposeData
                  .image1 = url;
            } else {
              Provider.of<ProposeFeedbackProvider>(context, listen: false)
                  .proposeData
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
