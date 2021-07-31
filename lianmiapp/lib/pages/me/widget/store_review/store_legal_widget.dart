import 'package:lianmiapp/component/image_choose.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/me/provider/store_review_provider.dart';
import 'package:lianmiapp/pages/me/widget/store_review/input_item.dart';
import 'package:lianmiapp/widgets/load_image.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';

class StoreLegalWidget extends StatefulWidget {
  @override
  _StoreLegalWidgetState createState() => _StoreLegalWidgetState();
}

class _StoreLegalWidgetState extends State<StoreLegalWidget> {
  final TextEditingController _ctrlHolder = TextEditingController();
  final TextEditingController _ctrlMobile = TextEditingController();
  final TextEditingController _ctrlWechat = TextEditingController();
  Function vali_holder = (value) {
    if (value.isEmpty) {
      return '法人不能为空';
    }
  };

  final TextEditingController _ctrlCardNo = TextEditingController();
  Function vali_cardNo = (value) {
    if (value.isEmpty) {
      return '身份证不能为空';
    }
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _info(),
          _idCard(),
        ],
      ),
    );
  }

  Widget _idCard() {
    String prefix = 'https://lianmi-ipfs.oss-cn-hangzhou.aliyuncs.com/';
    return Consumer<StoreReviewProvider>(builder: (context, provider, child) {
      return Container(
          margin: EdgeInsets.fromLTRB(16, 20, 16, 0),
          child: Column(
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  child: Text("法人身份证",
                      style:
                          TextStyle(color: Color(0xff888888), fontSize: 14))),
              Gaps.vGap32,
              InkWell(
                onTap: () {
                  _idenAction(0);
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(88, 0, 88, 0),
                  child: isValidString(provider.reviewData.idCardFrontPhoto)
                      ? LoadImageWithHolder(
                          prefix + provider.reviewData.idCardFrontPhoto,
                          holderImg: ImageStandard.logo,
                          width: 200.px,
                        )
                      : Image(
                          width: double.maxFinite,
                          image:
                              ExactAssetImage('assets/images/me/idup@3x.png')),
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
                  child: isValidString(provider.reviewData.idCardBackPhoto)
                      ? LoadImageWithHolder(
                          prefix + provider.reviewData.idCardBackPhoto,
                          holderImg: ImageStandard.logo,
                          width: 200.px,
                        )
                      : Image(
                          width: double.maxFinite,
                          image:
                              ExactAssetImage('assets/images/me/idup@3x.png')),
                ),
              ),
            ],
          ));
    });
  }

  Widget _info() {
    return Consumer<StoreReviewProvider>(builder: (context, provider, child) {
      _ctrlHolder.text = provider.reviewData.legalPerson;
      _ctrlCardNo.text = provider.reviewData.legalIdentityCard;
      return Container(
        margin: EdgeInsets.fromLTRB(16, 0, 0, 0),
        child: Column(
          children: [
            InputItem(
              title: "法人姓名",
              hintText: '请输入真实姓名',
              controller: _ctrlHolder,
              valid: vali_holder,
              button: Container(),
              onChange: (String text) {
                Provider.of<StoreReviewProvider>(context, listen: false)
                    .reviewData
                    .legalPerson = text;
              },
            ),
            InputItem(
              title: "手机",
              hintText: '请输入手机',
              controller: _ctrlMobile,
              valid: vali_holder,
              button: Container(),
              onChange: (String text) {
                Provider.of<StoreReviewProvider>(context, listen: false)
                    .reviewData
                    .contactMobile = text;
              },
            ),
            InputItem(
              title: "微信",
              hintText: '请输入微信',
              controller: _ctrlWechat,
              valid: vali_holder,
              button: Container(),
              onChange: (String text) {
                Provider.of<StoreReviewProvider>(context, listen: false)
                    .reviewData
                    .wechat = text;
              },
            ),
            InputItem(
              title: "身份证号码",
              hintText: '请输入持卡人身份证',
              controller: _ctrlCardNo,
              valid: vali_cardNo,
              button: Container(),
              onChange: (String text) {
                Provider.of<StoreReviewProvider>(context, listen: false)
                    .reviewData
                    .legalIdentityCard = text;
              },
            )
          ],
        ),
      );
    });
  }

  ///0:正面  1:反面
  void _idenAction(int type) {
    ImageChoose.instance.pickImage().then((path) {
      if (isValidString(path)) {
        FileManager.instance.copyFileToAppFolder(path).then((value) {
          HubView.showLoading();
          UserMod.uploadOssFile(path, 'msgs', (String url) async {
            HubView.dismiss();
            logI('上传图片成功:$url');
            if (type == 0) {
              Provider.of<StoreReviewProvider>(context, listen: false)
                  .reviewData
                  .idCardFrontPhoto = url;
            } else {
              Provider.of<StoreReviewProvider>(context, listen: false)
                  .reviewData
                  .idCardBackPhoto = url;
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
