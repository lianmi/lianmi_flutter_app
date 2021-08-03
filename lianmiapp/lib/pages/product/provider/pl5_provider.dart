import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/notification/notification_center.dart';
import 'package:lianmiapp/pages/product/model/ball_num_model.dart';
import 'package:lianmiapp/pages/product/model/pl5/pl5_model.dart';
import 'package:lianmiapp/pages/product/page/pl5_page.dart';
import 'package:lianmiapp/pages/product/page/selected_num_page.dart';
import 'package:lianmiapp/pages/product/provider/lottery_provider.dart';
import 'package:lianmiapp/pages/product/utils/lottery_utils.dart';
import 'package:lianmiapp/pages/product/utils/pailie5_calculate_utils.dart';
import 'package:lianmiapp/util/alert_utils.dart';
import 'package:lianmiapp/util/date_time_utils.dart';
import 'package:linkme_flutter_sdk/manager/AppManager.dart';

//个十百千万位的最大数
const int kPl5MaxCount = 10;

class Pl5Provider extends ChangeNotifier {
  int _lotteryId = 0;

  String? businessId;

  List<BallNumModel> _geList = [];

  List<BallNumModel> _shiList = [];

  List<BallNumModel> _baiList = [];

  List<BallNumModel> _qianList = [];

  List<BallNumModel> _wanList = [];

  ///个位
  List<BallNumModel> get geList => _geList;

  ///十位
  List<BallNumModel> get shiList => _shiList;

  ///百位
  List<BallNumModel> get baiList => _baiList;

  ///千位
  List<BallNumModel> get qianList => _qianList;

  ///万位
  List<BallNumModel> get wanList => _wanList;

  List<Pl5Model> _selectLotterys = [];

  List<Pl5Model> get selectLotterys => _selectLotterys;

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
    if (_geList.length == 0) {
      for (var i = 0; i < kPl5MaxCount; i++) {
        _geList.add(BallNumModel(i));
      }
    }
    if (_shiList.length == 0) {
      for (var i = 0; i < kPl5MaxCount; i++) {
        _shiList.add(BallNumModel(i));
      }
    }
    if (_baiList.length == 0) {
      for (var i = 0; i < kPl5MaxCount; i++) {
        _baiList.add(BallNumModel(i));
      }
    }
    if (_qianList.length == 0) {
      for (var i = 0; i < kPl5MaxCount; i++) {
        _qianList.add(BallNumModel(i));
      }
    }
    if (_wanList.length == 0) {
      for (var i = 0; i < kPl5MaxCount; i++) {
        _wanList.add(BallNumModel(i));
      }
    }
    notifyListeners();
    updateSelectLotterys();
  }

  ///更新注数
  void updateCount() {
    int geCount = 0;
    _geList.forEach((element) {
      if (element.isSelected) geCount++;
    });
    int shiCount = 0;
    _shiList.forEach((element) {
      if (element.isSelected) shiCount++;
    });
    int baiCount = 0;
    _baiList.forEach((element) {
      if (element.isSelected) baiCount++;
    });
    int qianCount = 0;
    _qianList.forEach((element) {
      if (element.isSelected) qianCount++;
    });
    int wanCount = 0;
    _wanList.forEach((element) {
      if (element.isSelected) wanCount++;
    });
    _count = PaiLie5CalculateUtils.calculateMultiple(
        geCount, shiCount, baiCount, qianCount, wanCount);
    notifyListeners();
  }

  ///更新已选号码
  Future updateSelectLotterys() async {
    List danshiFromDb =
        await AppManager.gRepository!.queryLotterys(_lotteryId, 0, 0);
    if (danshiFromDb.length > 0) {
      _selectLotterys = Pl5Model.modelListFromDbLotterys(danshiFromDb);
    }

    List fushiFromDb =
        await AppManager.gRepository!.queryLotterys(_lotteryId, 1, 0);
    if (fushiFromDb.length > 0) {
      _selectLotterys = Pl5Model.modelListFromDbLotterys(fushiFromDb);
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
    List<BallNumModel> geSelectList = [];
    _geList.forEach((element) {
      if (element.isSelected) geSelectList.add(element);
    });
    List<BallNumModel> shiSelectList = [];
    _shiList.forEach((element) {
      if (element.isSelected) shiSelectList.add(element);
    });
    List<BallNumModel> baiSelectList = [];
    _baiList.forEach((element) {
      if (element.isSelected) baiSelectList.add(element);
    });
    List<BallNumModel> qianSelectList = [];
    _qianList.forEach((element) {
      if (element.isSelected) qianSelectList.add(element);
    });
    List<BallNumModel> wanSelectList = [];
    _wanList.forEach((element) {
      if (element.isSelected) wanSelectList.add(element);
    });
    if (geSelectList.length == 0) {
      HubView.showToast('请选择个位');
      return;
    }
    if (shiSelectList.length == 0) {
      HubView.showToast('请选择十位');
      return;
    }
    if (baiSelectList.length == 0) {
      HubView.showToast('请选择百位');
      return;
    }
    if (qianSelectList.length == 0) {
      HubView.showToast('请选择千位');
      return;
    }
    if (wanSelectList.length == 0) {
      HubView.showToast('请选择万位');
      return;
    }
    Map<String, dynamic> data = {
      'geBalls': _getList(geSelectList),
      'shiBalls': _getList(shiSelectList),
      'baiBalls': _getList(baiSelectList),
      'qianBalls': _getList(qianSelectList),
      'wanBalls': _getList(wanSelectList),
    };
    bool isCurrentDanshi = (geSelectList.length == 1 &&
        shiSelectList.length == 1 &&
        baiSelectList.length == 1 &&
        qianSelectList.length == 1 &&
        wanSelectList.length == 1);
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
          for (Pl5Model item in _selectLotterys) {
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
        for (Pl5Model item in _selectLotterys) {
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
            App.context!, Pl5Page(businessId!, _lotteryId, isNumKeep: true))
        .then((value) {
      _setCurrentSelected(datas);
    });
  }

  Map<String, List<int>> _getCurrentSelected() {
    Map<String, List<int>> datas = {};
    datas['geList'] = _getSelectedList(_geList);
    datas['shiList'] = _getSelectedList(_shiList);
    datas['baiList'] = _getSelectedList(_baiList);
    datas['qianList'] = _getSelectedList(_qianList);
    datas['wanList'] = _getSelectedList(_wanList);
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
    //普通模式处理
    List<BallNumModel> geSelectList = [];
    _geList.forEach((element) {
      if (element.isSelected) geSelectList.add(element);
    });
    List<BallNumModel> shiSelectList = [];
    _shiList.forEach((element) {
      if (element.isSelected) shiSelectList.add(element);
    });
    List<BallNumModel> baiSelectList = [];
    _baiList.forEach((element) {
      if (element.isSelected) baiSelectList.add(element);
    });
    List<BallNumModel> qianSelectList = [];
    _qianList.forEach((element) {
      if (element.isSelected) qianSelectList.add(element);
    });
    List<BallNumModel> wanSelectList = [];
    _wanList.forEach((element) {
      if (element.isSelected) wanSelectList.add(element);
    });
    if (geSelectList.length == 0) {
      HubView.showToast('请选择个位');
      return;
    }
    if (shiSelectList.length == 0) {
      HubView.showToast('请选择十位');
      return;
    }
    if (baiSelectList.length == 0) {
      HubView.showToast('请选择百位');
      return;
    }
    if (qianSelectList.length == 0) {
      HubView.showToast('请选择千位');
      return;
    }
    if (wanSelectList.length == 0) {
      HubView.showToast('请选择万位');
      return;
    }
    Map<String, dynamic> data = {
      'geBalls': _getList(geSelectList),
      'shiBalls': _getList(shiSelectList),
      'baiBalls': _getList(baiSelectList),
      'qianBalls': _getList(qianSelectList),
      'wanBalls': _getList(wanSelectList)
    };
    bool isCurrentDanshi = (geSelectList.length == 1 &&
        shiSelectList.length == 1 &&
        baiSelectList.length == 1);
    if (isCurrentDanshi) {
      _insertKeepData(data, 0);
    } else {
      _insertKeepData(data, 1);
    }
  }

  Future<List<Pl5Model>> getAllNumKeep() async {
    List danshiFromDb =
        await AppManager.gRepository!.queryLotterys(_lotteryId, 0, 1);
    List fushiFromDb =
        await AppManager.gRepository!.queryLotterys(_lotteryId, 1, 1);
    List allListFromDb = danshiFromDb + fushiFromDb;
    List<Pl5Model> results = Pl5Model.modelListFromDbLotterys(allListFromDb);
    return results;
  }

  void selectNumKeep(Pl5Model model) async {
    AppNavigator.goBack(App.context!);
    Map<String, dynamic> data = {};
    data = {
      'geBalls': model.geBalls,
      'shiBalls': model.shiBalls,
      'baiBalls': model.baiBalls,
      'qianBalls': model.qianBalls,
      'wanBalls': model.wanBalls
    };
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
          for (Pl5Model item in _selectLotterys) {
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
    _geList.forEach((element) {
      element.isSelected = datas['geList']!.contains(element.number);
    });
    _shiList.forEach((element) {
      element.isSelected = datas['shiList']!.contains(element.number);
    });
    _baiList.forEach((element) {
      element.isSelected = datas['baiList']!.contains(element.number);
    });
    _qianList.forEach((element) {
      element.isSelected = datas['qianList']!.contains(element.number);
    });
    _wanList.forEach((element) {
      element.isSelected = datas['wanList']!.contains(element.number);
    });
    updateCount();
    notifyListeners();
  }

  ///根据id删除已选号码
  Future deleteLotterys(List<Pl5Model> list) async {
    for (Pl5Model item in list) {
      await AppManager.gRepository!.deleteLottery(item.id!);
    }
    updateSelectLotterys();
    NotificationCenter.instance
        .postNotification(NotificationDefine.selectedNumUpdate);
    NotificationCenter.instance
        .postNotification(NotificationDefine.numKeepUpdate);
  }

  void resetAllNum() {
    _geList.forEach((element) {
      element.isSelected = false;
    });
    _shiList.forEach((element) {
      element.isSelected = false;
    });
    _baiList.forEach((element) {
      element.isSelected = false;
    });
    _qianList.forEach((element) {
      element.isSelected = false;
    });
    _wanList.forEach((element) {
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
