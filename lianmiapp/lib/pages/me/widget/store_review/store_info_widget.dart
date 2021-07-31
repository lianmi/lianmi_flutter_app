import 'package:city_pickers/city_pickers.dart';
import 'package:lianmiapp/citypicker/picker.dart';
import 'package:lianmiapp/component/image_choose.dart';
import 'package:lianmiapp/component/type_choose.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/me/provider/store_review_provider.dart';
import 'package:lianmiapp/res/view_standard.dart';
import 'package:lianmiapp/util/keyboard_utils.dart';
import 'package:lianmiapp/widgets/load_image.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
import 'action_item.dart';
import 'input_item.dart';

class StoreInfoWidget extends StatefulWidget {
  @override
  _StoreInfoWidgetState createState() => _StoreInfoWidgetState();
}

class _StoreInfoWidgetState extends State<StoreInfoWidget> {
  PickerItem showTypeAttr = PickerItem(name: '省+市+县+乡', value: ShowType.pcav);
  Result resultAttr = new Result();
  Result result = new Result();
  double barrierOpacityAttr = 0.5;
  bool barrierDismissibleAttr = false;
  double customerItemExtent = 40;
  bool customerButtons = false;
  bool isSort = false;
  bool customerItemBuilder = false;
  PickerItem? themeAttr;

  String provinceCityText = '请选择城市 >';

  final TextEditingController _ctrlName = TextEditingController();
  final TextEditingController _ctrlIntroductory = TextEditingController();
  Function vali_Name = (value) {
    if (value.isEmpty) {
      return '商户名称不能为空';
    }
  };

  final TextEditingController _ctrlAddress = TextEditingController();
  Function vali_Address = (value) {
    if (value.isEmpty) {
      return '商户地址不能为空';
    }
  };

  @override
  Widget build(BuildContext context) {
    return Consumer<StoreReviewProvider>(builder: (context, provider, child) {
      _ctrlName.text = provider.reviewData.branchesname;
      _ctrlIntroductory.text = provider.reviewData.introductory;
      String typeText = '请选择商户类型 >';

      if (provider.reviewData.storeType != null &&
          provider.reviewData.storeType > 0) {
        switch (provider.reviewData.storeType) {
          case 1:
            typeText = '中国福利网点 >';
            break;
          case 2:
            typeText = '中国体育网点 >';
            break;
          case 3:
            typeText = '公证企业 >';
            break;
          case 4:
            typeText = '律师事务所 >';
            break;
          case 5:
            typeText = '保险公司 >';
            break;
          case 6:
            typeText = '政府部门 >';
            break;
          case 7:
            typeText = '设计公司 >';
            break;
          case 8:
            typeText = '知识产权 >';
            break;
          case 9:
            typeText = '艺术品古董鉴定 >';
            break;
          default:
        }
      }
      _ctrlAddress.text = provider.reviewData.address;
      return Container(
        padding: ViewStandard.padding,
        child: Column(
          children: [
            InputItem(
              title: "商户名称",
              hintText: '请输入商户名称',
              controller: _ctrlName,
              valid: vali_Name,
              button: Container(),
              onChange: (String text) {
                provider.reviewData.branchesname = text;
              },
            ),
            InputItem(
              title: "简介",
              hintText: '请输入简介',
              controller: _ctrlIntroductory,
              valid: vali_Name,
              button: Container(),
              onChange: (String text) {
                provider.reviewData.introductory = text;
              },
            ),
            ActtionItem(
              title: '商户类型',
              content: typeText,
              onTap: () {
                _showTypeSelect();
              },
            ),
            ActtionItem(
              title: '城市选择',
              content: provinceCityText,
              onTap: () {
                _showCitySelect();
              },
            ),
            InputItem(
              title: "商户地址",
              hintText: '请输入商户地址',
              controller: _ctrlAddress,
              valid: vali_Address,
              button: Container(),
              onChange: (String text) {
                provider.reviewData.address = text;
              },
            ),
            _photoArea('上传商户营业执照', provider.reviewData.businessLicenseUrl, 0),
            _photoArea('上传商户形象照片', provider.reviewData.imageUrl, 1),
          ],
        ),
      );
    });
  }

  Widget _photoArea(String title, String imgUrl, int type) {
    String prefix = 'https://lianmi-ipfs.oss-cn-hangzhou.aliyuncs.com/';
    return Container(
      width: double.infinity,
      height: 260.px,
      child: Column(
        children: [
          Container(
            height: 30.px,
            alignment: Alignment.centerLeft,
            child: CommonText(
              title,
              fontSize: 14.px,
              color: Colors.black,
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () {
                  _photoAction(type);
                },
                child: isValidString(imgUrl)
                    ? LoadImageWithHolder(
                        prefix + imgUrl,
                        holderImg: ImageStandard.logo,
                        width: 164.px,
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
    );
  }

  void _showTypeSelect() {
    KeyboardUtils.hideKeyboard(context);
    TypeChoose.show(
        title: '请选择商户类型',
        list: [
          '中国福利网点',
          '中国体育网点',
          '公证企业',
          '律师事务所',
          '保险公司',
          '政府部门',
          '设计公司',
          '知识产权',
          '艺术品古董鉴定',
        ],
        onTap: (int index) {
          Provider.of<StoreReviewProvider>(context, listen: false)
              .reviewData
              .storeType = index + 1;
          setState(() {});
        });
  }

  void _showCitySelect() async {
    resultAttr.provinceId = AppManager.provinceId; //初始省
    resultAttr.cityId = AppManager.cityId; //初始城市

    Result? tempResult = await CityPickers.showCityPicker(
        context: context,
        theme: themeAttr?.value,
        locationCode: resultAttr != null
            ? resultAttr.areaId ??
                resultAttr.cityId ??
                resultAttr.provinceId ??
                '110000'
            : '110000',
        showType: showTypeAttr.value,
        isSort: isSort,
        barrierOpacity: barrierOpacityAttr,
        barrierDismissible: barrierDismissibleAttr,
        citiesData: null,
        provincesData: null,
        itemExtent: customerItemExtent,
        cancelWidget: null,
        confirmWidget: null,
        itemBuilder: null);
    if (tempResult == null) {
      return;
    }

    logI("${tempResult.toString()}");
    Provider.of<StoreReviewProvider>(context, listen: false)
        .reviewData
        .province = tempResult.provinceName!;

    Provider.of<StoreReviewProvider>(context, listen: false).reviewData.city =
        tempResult.cityName!;

    Provider.of<StoreReviewProvider>(context, listen: false).reviewData.area =
        tempResult.areaName!;

    this.provinceCityText =
        tempResult.provinceName! + tempResult.cityName! + tempResult.areaName!;

    setState(() {});
  }

  ///0:营业执照  1:商户照片
  void _photoAction(int type) {
    KeyboardUtils.hideKeyboard(context);
    ImageChoose.instance.pickImage().then((path) {
      if (isValidString(path)) {
        FileManager.instance.copyFileToAppFolder(path).then((value) {
          HubView.showLoading();
          UserMod.uploadOssFile(path, 'msgs', (String url) async {
            HubView.dismiss();
            logD('上传图片成功:$url');
            if (type == 0) {
              Provider.of<StoreReviewProvider>(context, listen: false)
                  .reviewData
                  .businessLicenseUrl = url;
            } else {
              Provider.of<StoreReviewProvider>(context, listen: false)
                  .reviewData
                  .imageUrl = url;
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
