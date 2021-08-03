import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/notification/notification_center.dart';
import 'package:lianmiapp/pages/product/model/ball_num_model.dart';
import 'package:lianmiapp/pages/product/model/qlc/qlc_model.dart';
import 'package:lianmiapp/pages/product/page/qlc_page.dart';
import 'package:lianmiapp/pages/product/page/selected_num_page.dart';
import 'package:lianmiapp/pages/product/provider/lottery_provider.dart';
import 'package:lianmiapp/pages/product/utils/lottery_utils.dart';
import 'package:lianmiapp/pages/product/utils/qilecai_calculate_utils.dart';
// import 'package:lianmiapp/pages/product/utils/daletou_calculate_utils.dart';
// import 'package:lianmiapp/pages/product/utils/ssq_calculate_utils.dart';
import 'package:lianmiapp/util/alert_utils.dart';
import 'package:lianmiapp/util/date_time_utils.dart';
import 'package:linkme_flutter_sdk/manager/AppManager.dart';

//总共30个
const int kQlcMaxCount = 30;

//最少选择7个
const int kQlcMinSelectCount = 7;

class QlcProvider extends ChangeNotifier {
  int _lotteryId = 0;

  String? businessId;

  List<BallNumModel> _ballList = [];

  List<BallNumModel> get ballList => _ballList;

  List<QlcModel> _selectLotterys = [];

  List<QlcModel> get selectLotterys => _selectLotterys;

  String _currentBallSelectText = '选好了';

  String get currentBallSelectText => _currentBallSelectText;

  ///普通注数
  int _count = 0;

  int get count => _count;

  List<int> _getList(List<BallNumModel> list) {
    List<int> result = [];
    list.forEach((element) {
      result.add(element.number);
    });
    return result;
  }

  void setup(int id) {
    _lotteryId = id;
    if (_ballList.length == 0) {
      for (var i = 0; i < kQlcMaxCount; i++) {
        _ballList.add(BallNumModel(i + 1));
      }
    }
    notifyListeners();
    updateSelectLotterys();
  }

  ///更新注数
  void updateCount() {
    int ballCount = 0;
    _ballList.forEach((element) {
      if (element.isSelected) ballCount++;
    });
    _count = QilecaiCalculateUtils.calculateMultiple(ballCount);
    notifyListeners();
  }

  ///更新已选号码
  Future updateSelectLotterys() async {
    List danshiFromDb =
        await AppManager.gRepository!.queryLotterys(_lotteryId, 0, 0);
    if (danshiFromDb.length > 0) {
      _selectLotterys = QlcModel.modelListFromDbLotterys(danshiFromDb);
    }

    List fushiFromDb =
        await AppManager.gRepository!.queryLotterys(_lotteryId, 1, 0);
    if (fushiFromDb.length > 0) {
      _selectLotterys = QlcModel.modelListFromDbLotterys(fushiFromDb);
    }

    if (danshiFromDb.length == 0 && fushiFromDb.length == 0)
      _selectLotterys = [];

    notifyListeners();
  }

  void selectBallAction() async {
    bool hasExistDanshi;
    bool hasExistFushi;
    if (_selectLotterys.length == 0) {
      hasExistDanshi = false;
      hasExistFushi = false;
    } else {
      hasExistDanshi = _selectLotterys.first.type == 0;
      hasExistFushi = _selectLotterys.first.type == 1;
    }
    //普通模式处理
    List<BallNumModel> ballSelectList = [];
    _ballList.forEach((element) {
      if (element.isSelected) ballSelectList.add(element);
    });
    if (ballSelectList.length < kQlcMinSelectCount) {
      HubView.showToast('最少选择${kQlcMinSelectCount}个');
      return;
    }
    Map<String, dynamic> data = {
      'balls': _getList(ballSelectList),
    };
    bool isCurrentDanshi = (ballSelectList.length == kQlcMinSelectCount);
    if (_selectLotterys.length > 0) {
      if (isCurrentDanshi) {
        if (hasExistDanshi) {
          if (_selectLotterys.length >= 5) {
            _showChooseAlert('单式最多只能选择5注');
            return;
          } else {
            _insertData(data, 0);
            return;
          }
        } else if (hasExistFushi) {
          _showChooseAlert('当前已选号码是复式,是否改为单式？', data: data, type: 0);
          return;
        }
      } else {
        if (hasExistDanshi) {
          _showChooseAlert('当前已选号码是单式,是否改为复式？', data: data, type: 1);
          return;
        } else if (hasExistFushi) {
          for (QlcModel item in _selectLotterys) {
            await AppManager.gRepository!.deleteLottery(item.id!);
          }
        }
        _insertData(data, 1);
      }
    } else {
      _insertData(data, isCurrentDanshi ? 0 : 1);
    }
  }

  Future _insertData(Map<String, dynamic> data, int type) async {
    dynamic result = await AppManager.gRepository!.insertLottery(_lotteryId,
        type, json.encode(data), DateTimeUtils.currentTimeMillis(), 0);
    if (result > 0) HubView.showToast('已添加选号');
    await updateSelectLotterys();
    resetAllNum();
    updateCount();
    showSelected();
  }

  void _showChooseAlert(String msg, {Map<String, dynamic>? data, int? type}) {
    if (data != null) {
      AlertUtils.showChooseAlert(App.context!,
          title: '提示',
          content: msg,
          confirmTitle: '确定', onTapConfirm: () async {
        for (QlcModel item in _selectLotterys) {
          await AppManager.gRepository!.deleteLottery(item.id!);
        }
        await _insertData(data, type!);
      });
    } else {
      AlertUtils.showChooseAlert(App.context!,
          title: '提示', content: msg, confirmTitle: '修改已选号码', onTapConfirm: () {
        showSelected();
      });
    }
  }

  void showSelected() {
    AppNavigator.push(App.context!, SelectNumPage(_lotteryId, businessId!));
  }

  ///获取已选择号码数量
  int getSelectedCount(List<BallNumModel> list) {
    int count = 0;
    list.forEach((element) {
      if (element.isSelected == true) count++;
    });
    return count;
  }

  void showNumKeep() {
    Map<String, List<int>> datas = _getCurrentSelected();
    resetAllNum();
    AppNavigator.push(
            App.context!, QlcPage(businessId!, _lotteryId, isNumKeep: true))
        .then((value) {
      _setCurrentSelected(datas);
    });
  }

  Map<String, List<int>> _getCurrentSelected() {
    Map<String, List<int>> datas = {};
    datas['ballList'] = _getSelectedList(_ballList);
    return datas;
  }

  List<int> _getSelectedList(List<BallNumModel> list) {
    List<int> result = [];
    list.forEach((element) {
      if (element.isSelected) result.add(element.number);
    });
    return result;
  }

  Future _insertKeepData(Map<String, dynamic> data, int type) async {
    dynamic result = await AppManager.gRepository!.insertLottery(_lotteryId,
        type, json.encode(data), DateTimeUtils.currentTimeMillis(), 1);
    if (result > 0) HubView.showToast('已添加守号');
    updateCount();
    NotificationCenter.instance
        .postNotification(NotificationDefine.numKeepUpdate);
    AppNavigator.goBack(App.context!);
  }

  void selectKeepBallAction() {
    List<BallNumModel> ballSelectList = [];
    _ballList.forEach((element) {
      if (element.isSelected) ballSelectList.add(element);
    });
    if (ballSelectList.length < kQlcMinSelectCount) {
      HubView.showToast('最少选择${kQlcMinSelectCount}个');
      return;
    }
    Map<String, dynamic> data = {'balls': _getList(ballSelectList)};
    bool isCurrentDanshi = (ballSelectList.length == kQlcMinSelectCount);
    if (isCurrentDanshi) {
      _insertKeepData(data, 0);
    } else {
      _insertKeepData(data, 1);
    }
  }

  Future<List<QlcModel>> getAllNumKeep() async {
    List danshiFromDb =
        await AppManager.gRepository!.queryLotterys(_lotteryId, 0, 1);
    List fushiFromDb =
        await AppManager.gRepository!.queryLotterys(_lotteryId, 1, 1);
    List allListFromDb = danshiFromDb + fushiFromDb;
    List<QlcModel> results = QlcModel.modelListFromDbLotterys(allListFromDb);
    return results;
  }

  void selectNumKeep(QlcModel model) async {
    AppNavigator.goBack(App.context!);
    Map<String, dynamic> data = {};
    data = {'balls': model.balls};
    if (_selectLotterys.length > 0) {
      int selectType = _selectLotterys.first.type!;
      if (model.type != selectType) {
        _showChooseAlert(
            '当前已选号码是${LotteryUtils.typeText(selectType)},是否改为${LotteryUtils.typeText(model.type!)}？',
            data: data,
            type: model.type);
        return;
      } else {
        if (model.type == 0) {
          if (_selectLotterys.length >= 5) {
            _showChooseAlert(
              '单式最多只能选择5注',
            );
            return;
          }
        } else {
          for (QlcModel item in _selectLotterys) {
            await AppManager.gRepository!.deleteLottery(item.id!);
          }
        }
        await _insertData(data, model.type!);
      }
    } else {
      await _insertData(data, model.type!);
    }
  }

  void _setCurrentSelected(Map<String, List<int>> datas) {
    _ballList.forEach((element) {
      element.isSelected = datas['ballList']!.contains(element.number);
    });
    updateCount();
    notifyListeners();
  }

  ///根据id删除已选号码
  Future deleteLotterys(List<QlcModel> list) async {
    for (QlcModel item in list) {
      await AppManager.gRepository!.deleteLottery(item.id!);
    }
    updateSelectLotterys();
    NotificationCenter.instance
        .postNotification(NotificationDefine.selectedNumUpdate);
    NotificationCenter.instance
        .postNotification(NotificationDefine.numKeepUpdate);
  }

  void resetAllNum() {
    _ballList.forEach((element) {
      element.isSelected = false;
    });
  }

  void reset() {
    resetAllNum();
    _count = 0;
    businessId = null;
    Provider.of<LotteryProvider>(App.context!, listen: false).reset();
    notifyListeners();
  }

  void clear() {
    resetAllNum();
    _count = 0;
    businessId = null;
    Provider.of<LotteryProvider>(App.context!, listen: false).clear();
  }
}
