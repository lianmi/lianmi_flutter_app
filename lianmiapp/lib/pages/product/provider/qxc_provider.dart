import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/notification/notification_center.dart';
import 'package:lianmiapp/pages/product/model/ball_num_model.dart';
import 'package:lianmiapp/pages/product/model/qxc/qxc_model.dart';
import 'package:lianmiapp/pages/product/page/qxc_page.dart';
import 'package:lianmiapp/pages/product/page/selected_num_page.dart';
import 'package:lianmiapp/pages/product/provider/lottery_provider.dart';
import 'package:lianmiapp/pages/product/utils/lottery_utils.dart';
import 'package:lianmiapp/pages/product/utils/qixingcai_calculate_utils.dart';
import 'package:lianmiapp/util/alert_utils.dart';
import 'package:lianmiapp/util/date_time_utils.dart';
import 'package:linkme_flutter_sdk/manager/AppManager.dart';

//123456位的最大数
const int kQXCCommonMaxCount = 10;

//7位最大数
const int kQXCSevenMaxCount = 13;

class QxcProvider extends ChangeNotifier {
  int _lotteryId = 0;

  String? businessId;

  List<BallNumModel> _oneList = [];

  List<BallNumModel> _twoList = [];

  List<BallNumModel> _threeList = [];

  List<BallNumModel> _fourList = [];

  List<BallNumModel> _fiveList = [];

  List<BallNumModel> _sixList = [];

  List<BallNumModel> _sevenList = [];

  ///1位
  List<BallNumModel> get oneList => _oneList;

  ///2位
  List<BallNumModel> get twoList => _twoList;

  ///3位
  List<BallNumModel> get threeList => _threeList;

  ///4位
  List<BallNumModel> get fourList => _fourList;

  ///5位
  List<BallNumModel> get fiveList => _fiveList;

  ///6位
  List<BallNumModel> get sixList => _sixList;

  ///7位
  List<BallNumModel> get sevenList => _sevenList;

  List<QxcModel> _selectLotterys = [];

  List<QxcModel> get selectLotterys => _selectLotterys;

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
    if (_oneList.length == 0) {
      for (var i = 0; i < kQXCCommonMaxCount; i++) {
        _oneList.add(BallNumModel(i));
      }
    }
    if (_twoList.length == 0) {
      for (var i = 0; i < kQXCCommonMaxCount; i++) {
        _twoList.add(BallNumModel(i));
      }
    }
    if (_threeList.length == 0) {
      for (var i = 0; i < kQXCCommonMaxCount; i++) {
        _threeList.add(BallNumModel(i));
      }
    }
    if (_fourList.length == 0) {
      for (var i = 0; i < kQXCCommonMaxCount; i++) {
        _fourList.add(BallNumModel(i));
      }
    }
    if (_fiveList.length == 0) {
      for (var i = 0; i < kQXCCommonMaxCount; i++) {
        _fiveList.add(BallNumModel(i));
      }
    }
    if (_sixList.length == 0) {
      for (var i = 0; i < kQXCCommonMaxCount; i++) {
        _sixList.add(BallNumModel(i));
      }
    }
    if (_sevenList.length == 0) {
      for (var i = 0; i < kQXCSevenMaxCount; i++) {
        _sevenList.add(BallNumModel(i));
      }
    }
    notifyListeners();
    updateSelectLotterys();
  }

  ///更新注数
  void updateCount() {
    int oneCount = 0;
    _oneList.forEach((element) {
      if (element.isSelected) oneCount++;
    });
    int twoCount = 0;
    _twoList.forEach((element) {
      if (element.isSelected) twoCount++;
    });
    int threeCount = 0;
    _threeList.forEach((element) {
      if (element.isSelected) threeCount++;
    });
    int fourCount = 0;
    _fourList.forEach((element) {
      if (element.isSelected) fourCount++;
    });
    int fiveCount = 0;
    _fiveList.forEach((element) {
      if (element.isSelected) fiveCount++;
    });
    int sixCount = 0;
    _sixList.forEach((element) {
      if (element.isSelected) sixCount++;
    });
    int sevenCount = 0;
    _sevenList.forEach((element) {
      if (element.isSelected) sevenCount++;
    });
    _count = QixingcaiCalculateUtils.calculateMultiple(oneCount, twoCount,
        threeCount, fourCount, fiveCount, sixCount, sevenCount);
    notifyListeners();
  }

  ///更新已选号码
  Future updateSelectLotterys() async {
    List danshiFromDb =
        await AppManager.gRepository!.queryLotterys(_lotteryId, 0, 0);
    if (danshiFromDb.length > 0) {
      _selectLotterys = QxcModel.modelListFromDbLotterys(danshiFromDb);
    }

    List fushiFromDb =
        await AppManager.gRepository!.queryLotterys(_lotteryId, 1, 0);
    if (fushiFromDb.length > 0) {
      _selectLotterys = QxcModel.modelListFromDbLotterys(fushiFromDb);
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
    List<BallNumModel> oneSelectList = [];
    _oneList.forEach((element) {
      if (element.isSelected) oneSelectList.add(element);
    });
    List<BallNumModel> twoSelectList = [];
    _twoList.forEach((element) {
      if (element.isSelected) twoSelectList.add(element);
    });
    List<BallNumModel> threeSelectList = [];
    _threeList.forEach((element) {
      if (element.isSelected) threeSelectList.add(element);
    });
    List<BallNumModel> fourSelectList = [];
    _fourList.forEach((element) {
      if (element.isSelected) fourSelectList.add(element);
    });
    List<BallNumModel> fiveSelectList = [];
    _fiveList.forEach((element) {
      if (element.isSelected) fiveSelectList.add(element);
    });
    List<BallNumModel> sixSelectList = [];
    _sixList.forEach((element) {
      if (element.isSelected) sixSelectList.add(element);
    });
    List<BallNumModel> sevenSelectList = [];
    _sevenList.forEach((element) {
      if (element.isSelected) sevenSelectList.add(element);
    });
    if (oneSelectList.length == 0) {
      HubView.showToast('请选择1位');
      return;
    }
    if (twoSelectList.length == 0) {
      HubView.showToast('请选择2位');
      return;
    }
    if (threeSelectList.length == 0) {
      HubView.showToast('请选择3位');
      return;
    }
    if (fourSelectList.length == 0) {
      HubView.showToast('请选择4位');
      return;
    }
    if (fiveSelectList.length == 0) {
      HubView.showToast('请选择5位');
      return;
    }
    if (sixSelectList.length == 0) {
      HubView.showToast('请选择6位');
      return;
    }
    if (sevenSelectList.length == 0) {
      HubView.showToast('请选择7位');
      return;
    }
    Map<String, dynamic> data = {
      'oneBalls': _getList(oneSelectList),
      'twoBalls': _getList(twoSelectList),
      'threeBalls': _getList(threeSelectList),
      'fourBalls': _getList(fourSelectList),
      'fiveBalls': _getList(fiveSelectList),
      'sixBalls': _getList(sixSelectList),
      'sevenBalls': _getList(sevenSelectList),
    };
    bool isCurrentDanshi = (oneSelectList.length == 1 &&
        twoSelectList.length == 1 &&
        threeSelectList.length == 1 &&
        fourSelectList.length == 1 &&
        fiveSelectList.length == 1 &&
        sixSelectList.length == 1 &&
        sevenSelectList.length == 1);
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
          for (QxcModel item in _selectLotterys) {
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
        for (QxcModel item in _selectLotterys) {
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
            App.context!, QxcPage(businessId!, _lotteryId, isNumKeep: true))
        .then((value) {
      _setCurrentSelected(datas);
    });
  }

  Map<String, List<int>> _getCurrentSelected() {
    Map<String, List<int>> datas = {};
    datas['oneList'] = _getSelectedList(_oneList);
    datas['twoList'] = _getSelectedList(_twoList);
    datas['threeList'] = _getSelectedList(_threeList);
    datas['fourList'] = _getSelectedList(_fourList);
    datas['fiveList'] = _getSelectedList(_fiveList);
    datas['sixList'] = _getSelectedList(_sixList);
    datas['sevenList'] = _getSelectedList(_sevenList);
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
    List<BallNumModel> oneSelectList = [];
    _oneList.forEach((element) {
      if (element.isSelected) oneSelectList.add(element);
    });
    List<BallNumModel> twoSelectList = [];
    _twoList.forEach((element) {
      if (element.isSelected) twoSelectList.add(element);
    });
    List<BallNumModel> threeSelectList = [];
    _threeList.forEach((element) {
      if (element.isSelected) threeSelectList.add(element);
    });
    List<BallNumModel> fourSelectList = [];
    _fourList.forEach((element) {
      if (element.isSelected) fourSelectList.add(element);
    });
    List<BallNumModel> fiveSelectList = [];
    _fiveList.forEach((element) {
      if (element.isSelected) fiveSelectList.add(element);
    });
    List<BallNumModel> sixSelectList = [];
    _sixList.forEach((element) {
      if (element.isSelected) sixSelectList.add(element);
    });
    List<BallNumModel> sevenSelectList = [];
    _sevenList.forEach((element) {
      if (element.isSelected) sevenSelectList.add(element);
    });
    if (oneSelectList.length == 0) {
      HubView.showToast('请选择1位');
      return;
    }
    if (twoSelectList.length == 0) {
      HubView.showToast('请选择2位');
      return;
    }
    if (threeSelectList.length == 0) {
      HubView.showToast('请选择3位');
      return;
    }
    if (fourSelectList.length == 0) {
      HubView.showToast('请选择4位');
      return;
    }
    if (fiveSelectList.length == 0) {
      HubView.showToast('请选择5位');
      return;
    }
    if (sixSelectList.length == 0) {
      HubView.showToast('请选择6位');
      return;
    }
    if (sevenSelectList.length == 0) {
      HubView.showToast('请选择7位');
      return;
    }
    Map<String, dynamic> data = {
      'oneBalls': _getList(oneSelectList),
      'twoBalls': _getList(twoSelectList),
      'threeBalls': _getList(threeSelectList),
      'fourBalls': _getList(fourSelectList),
      'fiveBalls': _getList(fiveSelectList),
      'sixBalls': _getList(sixSelectList),
      'sevenBalls': _getList(sevenSelectList),
    };
    bool isCurrentDanshi = (oneSelectList.length == 1 &&
        twoSelectList.length == 1 &&
        threeSelectList.length == 1 &&
        fourSelectList.length == 1 &&
        fiveSelectList.length == 1 &&
        sixSelectList.length == 1 &&
        sevenSelectList.length == 1);
    if (isCurrentDanshi) {
      _insertKeepData(data, 0);
    } else {
      _insertKeepData(data, 1);
    }
  }

  Future<List<QxcModel>> getAllNumKeep() async {
    List danshiFromDb =
        await AppManager.gRepository!.queryLotterys(_lotteryId, 0, 1);
    List fushiFromDb =
        await AppManager.gRepository!.queryLotterys(_lotteryId, 1, 1);
    List allListFromDb = danshiFromDb + fushiFromDb;
    List<QxcModel> results = QxcModel.modelListFromDbLotterys(allListFromDb);
    return results;
  }

  void selectNumKeep(QxcModel model) async {
    AppNavigator.goBack(App.context!);
    Map<String, dynamic> data = {};
    data = {
      'oneBalls': model.oneBalls,
      'twoBalls': model.twoBalls,
      'threeBalls': model.threeBalls,
      'fourBalls': model.fourBalls,
      'fiveBalls': model.fiveBalls,
      'sixBalls': model.sixBalls,
      'sevenBalls': model.sevenBalls,
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
          for (QxcModel item in _selectLotterys) {
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
    _oneList.forEach((element) {
      element.isSelected = datas['oneList']!.contains(element.number);
    });
    _twoList.forEach((element) {
      element.isSelected = datas['twoList']!.contains(element.number);
    });
    _threeList.forEach((element) {
      element.isSelected = datas['threeList']!.contains(element.number);
    });
    _fourList.forEach((element) {
      element.isSelected = datas['fourList']!.contains(element.number);
    });
    _fiveList.forEach((element) {
      element.isSelected = datas['fiveList']!.contains(element.number);
    });
    _sixList.forEach((element) {
      element.isSelected = datas['sixList']!.contains(element.number);
    });
    _sevenList.forEach((element) {
      element.isSelected = datas['sevenList']!.contains(element.number);
    });
    updateCount();
    notifyListeners();
  }

  ///根据id删除已选号码
  Future deleteLotterys(List<QxcModel> list) async {
    for (QxcModel item in list) {
      await AppManager.gRepository!.deleteLottery(item.id!);
    }
    updateSelectLotterys();
    NotificationCenter.instance
        .postNotification(NotificationDefine.selectedNumUpdate);
    NotificationCenter.instance
        .postNotification(NotificationDefine.numKeepUpdate);
  }

  void resetAllNum() {
    _oneList.forEach((element) {
      element.isSelected = false;
    });
    _twoList.forEach((element) {
      element.isSelected = false;
    });
    _threeList.forEach((element) {
      element.isSelected = false;
    });
    _fourList.forEach((element) {
      element.isSelected = false;
    });
    _fiveList.forEach((element) {
      element.isSelected = false;
    });
    _sixList.forEach((element) {
      element.isSelected = false;
    });
    _sevenList.forEach((element) {
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
