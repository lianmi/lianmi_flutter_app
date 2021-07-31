import 'package:city_pickers/city_pickers.dart';
import 'package:lianmisdk/src/picker.dart';

import '../widget/appbar_widget.dart';
import 'package:flutter/material.dart';

import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
import 'package:linkme_flutter_sdk/sdk/UserMod.dart';

class StorePage extends StatefulWidget {
  StorePage({Key? key}) : super(key: key);

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("store", 80, false).build(context),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            _oneColumnWidget(),
            // _twoColumnWidget(),
          ],
        ),
      ),
    );
  }

  Widget _oneColumnWidget() {
    return Expanded(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          children: [
            _customButton('按省市搜店铺列表', onTap: () async {
              var data = {
                'storeType': 3,
                'keys': '',
                // 'longitude': myLocation.longitude,
                // 'latitude': myLocation.latitude,
                // 'province': myLocation.province,
                // 'city': myLocation.city,
                // 'area': myLocation.area,
                'radius': 0.00,
                'page': 0,
                'limit': 20
              };

              resultAttr.provinceId = AppManager.provinceId; //初始省
              resultAttr.cityId = AppManager.cityId; //初始城市

              print("locationCode $resultAttr");

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

              AppManager.setProvinceId(tempResult.provinceId!);
              AppManager.setCityId(tempResult.cityId!);

              data['province'] = tempResult.provinceName!;
              data['city'] = tempResult.cityName!;
              data['area'] = tempResult.areaName!;

              UserMod.getStoreList(data).then((_stores) {
                _stores.forEach((store) {
                  logD('_stores: ${store.toJson()}');
                });
              }).catchError((err) {
                logE('从服务端获取店铺列表出错: $err');
              });
            }),
            _customButton('从服务端获取店铺资料', onTap: () async {
              String _businessUsername = 'id3';
              UserMod.getStoreInfoFromServer(_businessUsername).then((_store) {
                logD('_store: ${_store.toJson()}');
              }).catchError((err) {
                logE('从服务端获取店铺资料出错: $err');
              });
            }),
            _customButton('店铺资料审核进度', onTap: () async {
              var stateStr = await UserMod.getAuditState();
              logD('审核进度: $stateStr');
            }),
            _customButton('提交商户资料审核', onTap: () async {
              var result = await UserMod.completeBusinessUserAudit(
                storeType: 1, // 1-福彩 2-体彩
                branchesname: '财神福彩店', //网点全称
                imageUrl: 'stores/shuangseqiu.jpeg', //网点形象照片，会展示在app店铺列表
                contactMobile: '13433991015', //手机
                wechat: 'lishijia', //微信号
                legalPerson: '李示佳', //法人姓名
                legalIdentityCard: '440725197207290017', //法人身份证号码
                idCardFrontPhoto: 'stores/shuangseqiu.jpeg', //法人身份证正面拍照
                idCardBackPhoto: 'stores/shuangseqiu.jpeg', //法人身份证背面拍照
                licenseUrl: 'stores/shuangseqiu.jpeg', //营业执照拍照
                introductory: '天天中大奖', //简介
                province: '广东省', //省
                city: '广州市', //市
                area: '黄埔区', //区
                address: '萝岗大道100号', //地址
              );

              if (result != null) {
                logD('商户资料提交成功');
              } else {
                logE('商户资料提交失败');
              }
            }),
            _customButton('修改商户资料', onTap: () async {
              //需要调用http接口
              var result = await UserMod.updateStoreInfo(
                // branchesName: '实体店(机号-44010172)',
                // imageUrl: 'stores/shuangseqiu.jpeg',
                // introductory: '天天中大奖,多买多中',
                // province: '广东省',
                // city: '广州市',
                // area: '天河区',
                // address: '棠德南路205号A27铺',
                // keys: '双色球',
                // contactMobile: '13401086718',
                // wechat: 'weixinhao',
                // businessCode: '23234242234',
                // longitude: '123.00',
                // latitude: '23',
                // openingHours: '9:00-23:00',
                branchesName: '中国体育网点',
                // imageUrl: 'stores/shuangseqiu.jpeg',
                introductory: '多买多中',
                province: '广东省',
                city: '广州市',
                area: '黄埔区',
                // address: '棠德南路205号A27铺',
                // keys: '双色球',
                // contactMobile: '13401086718',
                // wechat: 'weixinhao',
                businessCode: '44010177',
                longitude: '123.00',
                latitude: '23',
                openingHours: '9:00-22:00',
              );
              logD(result);
            }),
            _customButton('商户某个月订单统计', onTap: () async {
              String yearMonth = '2021.7'; //统计月份
              var result = await OrderMod.getStoreOrders(yearMonth);
              logD(result);
            }),
            _customButton('商户某个月所有用户的手续费统计', onTap: () async {
              String yearMonth = '2021.7'; //统计月份
              var result = await OrderMod.getStoreSpendings(yearMonth);
              logD(result);
            }),
          ],
        ),
      ),
    );
  }

  Widget _customButton(String title, {required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        width: double.infinity,
        height: 30,
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
