import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/notification/notification_center.dart';
import 'package:lianmiapp/pages/lottery/model/ball_num_model.dart';
import 'package:lianmiapp/pages/lottery/model/dlt/dlt_model.dart';
import 'package:lianmiapp/pages/lottery/page/dlt_page.dart';
import 'package:lianmiapp/pages/lottery/page/selected_num_page.dart';
import 'package:lianmiapp/pages/lottery/provider/lottery_provider.dart';
import 'package:lianmiapp/pages/lottery/utils/daletou_calculate_utils.dart';
import 'package:lianmiapp/pages/lottery/utils/lottery_utils.dart';
import 'package:lianmiapp/util/alert_utils.dart';
import 'package:lianmiapp/util/date_time_utils.dart';
import 'package:linkme_flutter_sdk/manager/AppManager.dart';

//前区33个
const int kDltFrontCount = 35;

//后区有16个
const int kDltBackCount = 12;

//前区最少选择5个
const int kDltFrontMinSelectCount = 5;

//后区最少选择2个
const int kDltBackMinSelectCount = 2;

///前区-胆最多选择4个
const int kDltFrontDanMaxSelectCount = 4;

class DltProvider extends ChangeNotifier {
  int _lotteryId = 0;

  String? businessId;

  List<BallNumModel> _frontList = [];

  List<BallNumModel> _backList = [];

  List<BallNumModel> _frontDanList = []; 

  List<BallNumModel> _frontTuoList = []; 

  List<BallNumModel> _backDTList = [];

  ///单式或者复式的前区
  List<BallNumModel> get frontList => _frontList;

  ///单式或者复式的后区
  List<BallNumModel> get backList => _backList;

  ///胆拖的前区-胆
  List<BallNumModel> get frontDanList => _frontDanList;

  ///胆拖的前区-拖
  List<BallNumModel> get frontTuoList => _frontTuoList;

  ///胆拖的后区
  List<BallNumModel> get backDTList => _backDTList;

  List<DltModel> _selectLotterys = [];

  List<DltModel> get selectLotterys => _selectLotterys;

  String _currentBallSelectText = '选好了';

  String get currentBallSelectText => _currentBallSelectText;

  

  

  ///普通注数
  int _count = 0;

  int get count => _count;

  ///0:普通 1:胆拖
  int type = 0;

  List<int> _getList(List<BallNumModel> list) {
    List<int> result = [];
    list.forEach((element) {
      result.add(element.number);
    });
    return result;
  }

  void setup(int id) {
    _lotteryId = id;
    if(_frontList.length == 0) {
      for (var i = 0; i < kDltFrontCount; i++) {
        _frontList.add(
          BallNumModel(i+1)
        );
      }
    }
    if(_backList.length == 0) {
      for (var i = 0; i < kDltBackCount; i++) {
        _backList.add(
          BallNumModel(i+1)
        );
      }
    }
    if(_frontDanList.length == 0) {
      for (var i = 0; i < kDltFrontCount; i++) {
        _frontDanList.add(
          BallNumModel(i+1)
        );
      }
    }
    if(_frontTuoList.length == 0) {
      for (var i = 0; i < kDltFrontCount; i++) {
        _frontTuoList.add(
          BallNumModel(i+1)
        );
      }
    }
    if(_backDTList.length == 0) {
      for (var i = 0; i < kDltBackCount; i++) {
        _backDTList.add(
          BallNumModel(i+1)
        );
      }
    }
    notifyListeners();
    updateSelectLotterys();
  }

  ///更新注数
  void updateCount() {
    if(type == 0) {
      int frontCount = 0;
      _frontList.forEach((element) {
        if(element.isSelected) frontCount++;
      });
      int backCount = 0;
      _backList.forEach((element) {
        if(element.isSelected) backCount++;
      });
      _count = DLTCalculateUtils.calculateMultiple(frontCount, backCount);
    } else {
      int frontDanCount = 0;
      _frontDanList.forEach((element) {
        if(element.isSelected) frontDanCount++;
      });
      int frontTuoCount = 0;
      _frontTuoList.forEach((element) {
        if(element.isSelected) frontTuoCount++;
      });
      int backDTCount = 0;
      _backDTList.forEach((element) {
        if(element.isSelected) backDTCount++;
      });
      _count = DLTCalculateUtils.calculateDantuo(frontDanCount, frontTuoCount, backDTCount);
    }
    notifyListeners();
  }

  ///更新已选号码
  Future updateSelectLotterys() async {
    List danshiFromDb = await AppManager.gRepository!.queryLotterys(_lotteryId,0,0);
    if(danshiFromDb.length > 0) {
      _selectLotterys = DltModel.modelListFromDbLotterys(danshiFromDb);
    }

    List fushiFromDb = await AppManager.gRepository!.queryLotterys(_lotteryId,1,0);
    if(fushiFromDb.length > 0) {
      _selectLotterys = DltModel.modelListFromDbLotterys(fushiFromDb);
    } 

    List dantuoFromDb = await AppManager.gRepository!.queryLotterys(_lotteryId,2,0);
    if(dantuoFromDb.length > 0) {
      _selectLotterys = DltModel.modelListFromDbLotterys(dantuoFromDb);
    } 
    
    if(danshiFromDb.length == 0 && fushiFromDb.length == 0 && dantuoFromDb.length == 0) _selectLotterys = []; 

    notifyListeners();
  }

  void selectBallAction() async {
    bool hasExistDanshi;
    bool hasExistFushi;
    bool hasExistDantuo;
    if(_selectLotterys.length == 0) {
      hasExistDanshi = false;
      hasExistFushi = false;
      hasExistDantuo = false;
    } else {
      hasExistDanshi = _selectLotterys.first.type == 0;
      hasExistFushi = _selectLotterys.first.type == 1;
      hasExistDantuo = _selectLotterys.first.type == 2;
    }
    if(type == 0) {
      //普通模式处理
      List<BallNumModel> frontSelectList = [];
      _frontList.forEach((element) {
        if(element.isSelected) frontSelectList.add(element);
      });
      List<BallNumModel> backSelectList = [];
      _backList.forEach((element) {
        if(element.isSelected) backSelectList.add(element);
      });
      if(frontSelectList.length < kDltFrontMinSelectCount) {
        HubView.showToast('前区最少选择${kDltFrontMinSelectCount}个');
        return;
      }
      if(backSelectList.length < kDltBackMinSelectCount) {
        HubView.showToast('后区最少选择${kDltBackMinSelectCount}个');
        return;
      }
      Map<String, dynamic> data = {
        'frontBalls': _getList(frontSelectList),
        'backBalls': _getList(backSelectList)
      };
      if(_selectLotterys.length > 0) {
        bool isCurrentDanshi = (frontSelectList.length == 5 && backSelectList.length == kDltBackMinSelectCount);
        if(isCurrentDanshi) {
          if(hasExistDanshi) {
            if(_selectLotterys.length >= 5) {
              _showChooseAlert('单式最多只能选择5注');
              return;
            } else {
              _insertData(data, 0);
              return;
            }
          } else if (hasExistFushi) {
            _showChooseAlert('当前已选号码是复式,是否改为单式？', data: data, type: 0);
            return;
          } else if (hasExistDantuo) {
            _showChooseAlert('当前已选号码是胆拖,是否改为单式？', data: data, type: 0);
            return;
          }
        } else {
          if (hasExistDanshi) {
            _showChooseAlert('当前已选号码是单式,是否改为复式？', data: data, type: 1);
            return;
          } else if (hasExistFushi) {
            for (DltModel item in _selectLotterys) {
              await AppManager.gRepository!.deleteLottery(item.id!);
            }
          } else if (hasExistDantuo) {
            _showChooseAlert('当前已选号码是胆拖,是否改为复式？', data: data, type: 1);
            return;
          }
          _insertData(data, 1);
        }
      } else {
        bool isCurrentDanshi = (frontSelectList.length == 5 && backSelectList.length == kDltBackMinSelectCount);
        _insertData(data, isCurrentDanshi?0:1);
      }
    } else {
      //胆拖处理
      List<BallNumModel> frontDanSelectList = [];
      _frontDanList.forEach((element) {
        if(element.isSelected) frontDanSelectList.add(element);
      });
      List<BallNumModel> frontTuoSelectList = [];
      _frontTuoList.forEach((element) {
        if(element.isSelected) frontTuoSelectList.add(element);
      });
      List<BallNumModel> backDTSelectList = [];
      _backDTList.forEach((element) {
        if(element.isSelected) backDTSelectList.add(element);
      });
      if(frontDanSelectList.length < 1) {
        HubView.showToast('请选择前区-胆');
        return;
      }
      int backTuoNeedSelectCount = kDltFrontMinSelectCount - frontDanSelectList.length;
      if(frontTuoSelectList.length < backTuoNeedSelectCount) {
        HubView.showToast('前区-拖需要选择${backTuoNeedSelectCount}个');
        return;
      }
      if(backDTSelectList.length < kDltBackMinSelectCount) {
        HubView.showToast('请在后区选择${kDltBackMinSelectCount}个以上');
        return;
      }
      Map<String, dynamic> data = {
        'frontBalls': _getList(frontDanSelectList),
        'backBalls': _getList(frontTuoSelectList),
        'danBalls': _getList(backDTSelectList)
      };
      if (hasExistDanshi) {
        _showChooseAlert('当前已选号码是单式,是否改为胆拖？', data: data, type: 2);
        return;
      }
      if (hasExistFushi) {
        _showChooseAlert('当前已选号码是复式,是否改为胆拖？', data: data, type: 2);
        return;
      }
      for (DltModel item in _selectLotterys) {
        await AppManager.gRepository!.deleteLottery(item.id!);
      }
      _insertData(data, 2);
    }
  }

  Future _insertData(Map<String, dynamic> data, int type) async {
    dynamic result = await AppManager.gRepository!.insertLottery(_lotteryId, type, json.encode(data),DateTimeUtils.currentTimeMillis(),0);
    if(result > 0) HubView.showToast('已添加选号');
    await updateSelectLotterys();
    resetAllNum();
    updateCount();
    showSelected();
  }

  void _showChooseAlert(String msg, {Map<String, dynamic>? data, int? type}) {
    if (data != null) {
      AlertUtils.showChooseAlert(
        App.context!,
        title: '提示',
        content: msg,
        confirmTitle: '确定',
        onTapConfirm: () async {
          for (DltModel item in _selectLotterys) {
            await AppManager.gRepository!.deleteLottery(item.id!);
          }
          await _insertData(data, type!);
        }
      );
    } else {
      AlertUtils.showChooseAlert(
        App.context!,
        title: '提示',
        content: msg,
        confirmTitle: '修改已选号码',
        onTapConfirm: () {
          showSelected();
        }
      );
    }
  }

  void showSelected() {
    AppNavigator.push(App.context!, SelectNumPage(_lotteryId, businessId!));
  }

  ///获取已选择号码数量
  int getSelectedCount(List<BallNumModel> list) {
    int count = 0;
    list.forEach((element) {
      if(element.isSelected == true) count++;
    });
    return count;
  }

  void showNumKeep() {
    Map<String, List<int>> datas = _getCurrentSelected();
    resetAllNum();
    AppNavigator.push(
      App.context!, 
      DltPage(businessId!, _lotteryId, isNumKeep:true)
    ).then((value) {
      _setCurrentSelected(datas);
    });
  }

  Map<String, List<int>> _getCurrentSelected() {
    Map<String, List<int>> datas = {};  
    datas['frontList'] = _getSelectedList(_frontList);
    datas['backList'] = _getSelectedList(_backList);
    datas['frontDanList'] = _getSelectedList(_frontDanList);
    datas['frontTuoList'] = _getSelectedList(_frontTuoList);
    datas['backDTList'] = _getSelectedList(_backDTList);
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
    dynamic result = await AppManager.gRepository!.insertLottery(_lotteryId, type, json.encode(data),DateTimeUtils.currentTimeMillis(),1);
    if(result > 0) HubView.showToast('已添加守号');
    updateCount();
    NotificationCenter.instance.postNotification(NotificationDefine.numKeepUpdate);
    AppNavigator.goBack(App.context!);
  }


  void selectKeepBallAction() {
    if(type == 0) {
      //普通模式处理
      List<BallNumModel> frontSelectList = [];
      _frontList.forEach((element) {
        if(element.isSelected) frontSelectList.add(element);
      });
      List<BallNumModel> backSelectList = [];
      _backList.forEach((element) {
        if(element.isSelected) backSelectList.add(element);
      });
      if(frontSelectList.length < kDltFrontMinSelectCount) {
        HubView.showToast('前区最少选择${kDltFrontMinSelectCount}个');
        return;
      }
      if(backSelectList.length < kDltBackMinSelectCount) {
        HubView.showToast('后区最少选择${kDltBackMinSelectCount}个');
        return;
      }
      Map<String, dynamic> data = {
        'frontBalls': _getList(frontSelectList),
        'backBalls': _getList(backSelectList)
      };
      bool isCurrentDanshi = (frontSelectList.length == 5 && backSelectList.length == kDltBackMinSelectCount);
      if(isCurrentDanshi) {
        _insertKeepData(data, 0);
      } else {
        _insertKeepData(data, 1);
      }
    } else {
      //胆拖处理
      List<BallNumModel> frontDanSelectList = [];
      _frontDanList.forEach((element) {
        if(element.isSelected) frontDanSelectList.add(element);
      });
      List<BallNumModel> frontTuoSelectList = [];
      _frontTuoList.forEach((element) {
        if(element.isSelected) frontTuoSelectList.add(element);
      });
      List<BallNumModel> backDTSelectList = [];
      _backDTList.forEach((element) {
        if(element.isSelected) backDTSelectList.add(element);
      });
      if(frontDanSelectList.length < 1) {
        HubView.showToast('请选择前区-胆');
        return;
      }
      int backTuoNeedSelectCount = kDltFrontMinSelectCount - frontDanSelectList.length;
      if(frontTuoSelectList.length < backTuoNeedSelectCount) {
        HubView.showToast('前区-拖需要选择${backTuoNeedSelectCount}个');
        return;
      }
      if(backDTSelectList.length < kDltBackMinSelectCount) {
        HubView.showToast('请在后区选择${kDltBackMinSelectCount}个以上');
        return;
      }
      Map<String, dynamic> data = {
        'danBalls': _getList(frontDanSelectList),
        'frontBalls': _getList(frontTuoSelectList),
        'backBalls': _getList(backDTSelectList)
      };
      _insertKeepData(data, 2);
    }
  }

  Future<List<DltModel>> getAllNumKeep() async {
    List danshiFromDb = await AppManager.gRepository!.queryLotterys(_lotteryId,0,1);
    List fushiFromDb = await AppManager.gRepository!.queryLotterys(_lotteryId,1,1);
    List dantuoFromDb = await AppManager.gRepository!.queryLotterys(_lotteryId,2,1);
    List allListFromDb = danshiFromDb + fushiFromDb + dantuoFromDb;
    List<DltModel> results = DltModel.modelListFromDbLotterys(allListFromDb);
    return results;
  }

  void selectNumKeep(DltModel model) async {
    AppNavigator.goBack(App.context!);
    Map<String, dynamic> data = {};
    if (model.type == 2) {
      data = {
        'danBalls': model.danBalls,
        'frontBalls': model.frontBalls,
        'backBalls': model.backBalls
      };
    } else {
      data = {
        'frontBalls': model.frontBalls,
        'backBalls': model.backBalls
      };
    }
    if (_selectLotterys.length > 0) {
      int selectType = _selectLotterys.first.type!;
      if (model.type != selectType) {
        _showChooseAlert('当前已选号码是${LotteryUtils.typeText(selectType)},是否改为${LotteryUtils.typeText(model.type!)}？', data: data, type: model.type);
        return;
      } else {
        if (model.type == 0) {
          if(_selectLotterys.length >= 5) {
            _showChooseAlert('单式最多只能选择5注',);
            return;
          }
        } else {
          for (DltModel item in _selectLotterys) {
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
    _frontList.forEach((element) {
      element.isSelected = datas['frontList']!.contains(element.number);
    });
    _backList.forEach((element) {
      element.isSelected = datas['backList']!.contains(element.number);
    });
    _frontDanList.forEach((element) {
      element.isSelected = datas['frontDanList']!.contains(element.number);
    });
    _frontTuoList.forEach((element) {
      element.isSelected = datas['frontTuoList']!.contains(element.number);
    });
    _backDTList.forEach((element) {
      element.isSelected = datas['backDTList']!.contains(element.number);
    });
    updateCount();
    notifyListeners();
  }

  ///根据id删除已选号码
  Future deleteLotterys(List<DltModel> list) async {
    for (DltModel item in list) {
      await AppManager.gRepository!.deleteLottery(item.id!);
    }
    updateSelectLotterys();
    NotificationCenter.instance.postNotification(NotificationDefine.selectedNumUpdate);
    NotificationCenter.instance.postNotification(NotificationDefine.numKeepUpdate);
  }

  void resetAllNum() {
    _frontList.forEach((element) {
      element.isSelected = false;
    });
    _backList.forEach((element) {
      element.isSelected = false;
    });
    _frontDanList.forEach((element) {
      element.isSelected = false;
    });
    _frontTuoList.forEach((element) {
      element.isSelected = false;
    });
    _backDTList.forEach((element) {
      element.isSelected = false;
    });
  }

  void reset() {
    resetAllNum();
    _count = 0;
    type = 0;
    businessId = null;
    Provider.of<LotteryProvider>(App.context!, listen: false).reset();
    notifyListeners();
  }

  void clear() {
    resetAllNum();
    _count = 0;
    type = 0;
    businessId = null;
    Provider.of<LotteryProvider>(App.context!, listen: false).clear();
  }
}