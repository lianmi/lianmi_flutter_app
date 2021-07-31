import 'package:city_pickers/city_pickers.dart';
import "package:flutter/material.dart";
import 'package:lianmiapp/citypicker/picker.dart';
import 'package:lianmiapp/component/image_choose.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/me/me_utils.dart';
import 'package:lianmiapp/pages/me/provider/store_review_provider.dart';
import 'package:lianmiapp/provider/me/storeInfo_view_model.dart';
import 'package:lianmiapp/util/app.dart';
import 'package:lianmiapp/util/keyboard_utils.dart';
import 'package:lianmiapp/widgets/hub_view.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
import '../../../../util/app_navigator.dart';
import 'edit_address_page.dart';
import 'edit_branches_page.dart';
import 'edit_businesscode_page.dart';
import 'edit_introductory_page.dart';
import 'edit_keys_page.dart';
import 'edit_mobile_page.dart';
import 'edit_openhours_page.dart';
import 'edit_wechat_page.dart';

class StoreInfoPage extends StatefulWidget {
  @override
  _StoreInfoPageState createState() => _StoreInfoPageState();
}

class _StoreInfoPageState extends State<StoreInfoPage> {
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          backgroundColor: Colors.white,
        ),
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  Navigator.of(context).popUntil(ModalRoute.withName('/'));
                },
                tooltip: 'Back',
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xff333333),
                ),
              ),
              backgroundColor: Colors.white,
              title: Text('商户资料', style: TextStyle(color: Color(0xff333333))),
              centerTitle: true,
              actions: [],
              elevation: 0,
            ),
            body: _body(context)));
  }

  Widget _body(BuildContext context) {
    return Consumer<StoreInfoViewModel>(builder: (context, storeInfo, child) {
      return Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              InkWell(
                onTap: () {
                  _showMedia();
                },
                child: Container(
                  height: 60,
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("形象图片", style: TextStyle(fontSize: 16)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          me_utils().roundRectImage(
                              40, 40, storeInfo.store!.imageUrl!, 10.0),
                          Icon(Icons.keyboard_arrow_right)
                        ],
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                  onTap: () {
                    _editBranchesName();
                  },
                  child: Container(
                    height: 60,
                    margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("商户名称", style: TextStyle(fontSize: 16)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(storeInfo.store!.branchesName!,
                                style: TextStyle(fontSize: 16)),
                            Icon(Icons.keyboard_arrow_right)
                          ],
                        )
                      ],
                    ),
                  )),
              InkWell(
                onTap: () {
                  _editIntroductory();
                },
                child: Container(
                  height: 60,
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("简介", style: TextStyle(fontSize: 16)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(storeInfo.store!.introductory!,
                              style: TextStyle(fontSize: 16)),
                          Icon(Icons.keyboard_arrow_right)
                        ],
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _showCitySelect();
                },
                child: Container(
                  height: 60,
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("所在城市", style: TextStyle(fontSize: 16)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              storeInfo.store!.province! +
                                  storeInfo.store!.city! +
                                  storeInfo.store!.area!,
                              style: TextStyle(fontSize: 16)),
                          Icon(Icons.keyboard_arrow_right)
                        ],
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _editAddress();
                },
                child: Container(
                  height: 60,
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("商户地址", style: TextStyle(fontSize: 16)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(storeInfo.store!.address!,
                              style: TextStyle(fontSize: 16)),
                          Icon(Icons.keyboard_arrow_right)
                        ],
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _editKeys();
                },
                child: Container(
                  height: 60,
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("关键字", style: TextStyle(fontSize: 16)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(storeInfo.store!.keys!,
                              style: TextStyle(fontSize: 16)),
                          Icon(Icons.keyboard_arrow_right)
                        ],
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _editContactMobile();
                },
                child: Container(
                  height: 60,
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("联系电话", style: TextStyle(fontSize: 16)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(storeInfo.store!.contactMobile!,
                              style: TextStyle(fontSize: 16)),
                          Icon(Icons.keyboard_arrow_right)
                        ],
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _editWeChat();
                },
                child: Container(
                  height: 60,
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("微信", style: TextStyle(fontSize: 16)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(storeInfo.store!.wechat!,
                              style: TextStyle(fontSize: 16)),
                          Icon(Icons.keyboard_arrow_right)
                        ],
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _editBusinessCode();
                },
                child: Container(
                  height: 60,
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("网点编号", style: TextStyle(fontSize: 16)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(storeInfo.store!.businessCode!,
                              style: TextStyle(fontSize: 16)),
                          Icon(Icons.keyboard_arrow_right)
                        ],
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _editOpenHours();
                },
                child: Container(
                  height: 60,
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("营业时间", style: TextStyle(fontSize: 16)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(storeInfo.store!.openingHours!,
                              style: TextStyle(fontSize: 16)),
                          Icon(Icons.keyboard_arrow_right)
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ));
    });
  }

  Widget _listItem(String title, {Function? onTap}) {
    return InkWell(
      onTap: () {
        onTap!();
      },
      child: Container(
        height: 60,
        margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(fontSize: 16)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Icon(Icons.keyboard_arrow_right)],
            )
          ],
        ),
      ),
    );
  }

  void _showMedia() {
    KeyboardUtils.hideKeyboard(App.context!);
    ImageChoose.instance.pickImage().then((value) {
      if (value != null) {
        FileManager.instance.copyFileToAppFolder(value).then((value) {
          _uploadImageUrlAndChange(value);
        });
      }
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

    logD("${tempResult.toString()}");
    Provider.of<StoreReviewProvider>(context, listen: false)
        .reviewData
        .province = tempResult.provinceName!;

    Provider.of<StoreReviewProvider>(context, listen: false).reviewData.city =
        tempResult.cityName!;

    Provider.of<StoreReviewProvider>(context, listen: false).reviewData.area =
        tempResult.areaName!;

    _changeCity(
        tempResult.provinceName!, tempResult.cityName!, tempResult.areaName!);
  }

  void _changeCity(String province, String city, String area) {
    KeyboardUtils.hideKeyboard(context);
    // if (isValidString(_ctrlBranchesName!.text) == false) {
    //   HubView.showToast('请输入商户名称');
    //   return;
    // }
    HubView.showLoading();
    UserMod.updateStoreInfo(province: province, city: city, area: area)
        .then((value) {
      Provider.of<StoreInfoViewModel>(context, listen: false).updateStoreInfo();
      Future.delayed(Duration(seconds: 1), () {
        HubView.dismiss();
        HubView.showToastAfterLoadingHubDismiss('修改商户城市资料成功');
        // AppNavigator.goBack(context);
      });
    }).catchError((err) {
      HubView.dismiss();
      HubView.showToastAfterLoadingHubDismiss('修改商户城市资料失败:$err');
    });
  }

  void _uploadImageUrlAndChange(String path) {
    HubView.showLoading();
    UserMod.uploadOssFile(path, 'avatars', (imageKey) {
      UserMod.updateStoreInfo(imageUrl: imageKey).then((value) {
        Provider.of<StoreInfoViewModel>(context, listen: false)
            .updateStoreInfo();
        Future.delayed(Duration(seconds: 1), () {
          HubView.dismiss();
          HubView.showToastAfterLoadingHubDismiss('修改形象图片成功');
        });
      }).catchError((err) {
        HubView.dismiss();
        HubView.showToastAfterLoadingHubDismiss('修改形象图片出错:$err');
      });
    }, (errmsg) {
      HubView.dismiss();
      HubView.showToastAfterLoadingHubDismiss('上传形象图片出错$errmsg');
    }, (percent) {
      // sdk.logD('上传形象图片进度:$percent');
    });
  }

  void _editBranchesName() {
    AppNavigator.push(context, EditBranchesPage());
  }

  void _editIntroductory() {
    AppNavigator.push(context, IntroductoryPage());
  }

  void _editAddress() {
    AppNavigator.push(context, AddressPage());
  }

  void _editKeys() {
    AppNavigator.push(context, KeysPage());
  }

  void _editContactMobile() {
    AppNavigator.push(context, ContactMobilePage());
  }

  void _editWeChat() {
    AppNavigator.push(context, WeChatPage());
  }

  void _editBusinessCode() {
    AppNavigator.push(context, BusinessCodePage());
  }

  void _editOpenHours() {
    AppNavigator.push(context, OpenHoursPage());
  }
}

class OpenhHoursPage {}
