import 'package:flutter/material.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/product/model/standart_model.dart';
import 'package:linkme_flutter_sdk/manager/AppManager.dart';
import 'package:linkme_flutter_sdk/manager/LogManager.dart';

class StandartProvider extends ChangeNotifier {
  int _lotteryId = 0; //彩种商品id,  约定 ，0是标准，无选号器
  String? businessId;

  StandartOrderModel _standartOrderData = StandartOrderModel(
    id: 0,
    productName: '',
    mobile: AppManager.currentMobile,
    title: '',
    description: '',
    count: 1,
    multiple: 1,
    attachs: [],
    photos: [],
  );

  StandartOrderModel get standartOrderData => _standartOrderData;

  void setup(int id) {
    _lotteryId = id;
    logI('StandartOrderModel, _lotteryId:$_lotteryId');
    notifyListeners();
  }

  void reset() {
    _standartOrderData = StandartOrderModel(
      id: 0,
      productName: AppManager.currentMobile,
      mobile: '',
      title: '',
      description: '',
      count: 1,
      multiple: 1,
      attachs: [],
      photos: [],
    );
  }
}
