import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/notification/notification_center.dart';
import 'package:lianmiapp/pages/lottery/model/ball_num_model.dart';
import 'package:lianmiapp/pages/lottery/model/shuang_se_qiu/shuang_se_qiu_model.dart';
import 'package:lianmiapp/pages/lottery/page/selected_num_page.dart';
import 'package:lianmiapp/pages/lottery/page/shuangseqiu_page.dart';
import 'package:lianmiapp/pages/lottery/provider/lottery_provider.dart';
import 'package:lianmiapp/pages/lottery/utils/lottery_utils.dart';
import 'package:lianmiapp/pages/lottery/utils/ssq_calculate_utils.dart';
import 'package:lianmiapp/util/alert_utils.dart';
import 'package:lianmiapp/util/date_time_utils.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';

//红球有33个
const int kShuangseqiuRedCount = 33;

//蓝球有16个
const int kShuangseqiuBlueCount = 16;

//红球最少选择6个
const int kShuangseqiuRedMinSelectCount = 6;

//红球最多选20个
const int kShuangseqiuRedMaxSelectCount = 20;

//蓝色最少选择一个
const int kShuangseqiuBlueMinSelectCount = 1;

///红球-胆最多选择5个
const int kShuangseqiuRedDanMaxSelectCount = 5;

class ShuangseqiuProvider extends ChangeNotifier {
  int _lotteryId = 0;

  String? businessId;

  List<BallNumModel> _redList = [];

  List<BallNumModel> _blueList = [];

  List<BallNumModel> _redDanList = []; 

  List<BallNumModel> _redTuoList = []; 

  List<BallNumModel> _blueDTList = [];

  ///单式或者复式的红球
  List<BallNumModel> get redList => _redList;

  ///单式或者复式的篮球
  List<BallNumModel> get blueList => _blueList;

  ///胆拖的红球-胆
  List<BallNumModel> get redDanList => _redDanList;

  ///胆拖的红球-拖
  List<BallNumModel> get redTuoList => _redTuoList;

  ///胆拖的篮球
  List<BallNumModel> get blueDTList => _blueDTList;

  List<ShuangseqiuModel> _selectLotterys = [];

  List<ShuangseqiuModel> get selectLotterys => _selectLotterys;

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
    if(_redList.length == 0) {
      for (var i = 0; i < kShuangseqiuRedCount; i++) {
        _redList.add(
          BallNumModel(i+1)
        );
      }
    }
    if(_blueList.length == 0) {
      for (var i = 0; i < kShuangseqiuBlueCount; i++) {
        _blueList.add(
          BallNumModel(i+1)
        );
      }
    }
    if(_redDanList.length == 0) {
      for (var i = 0; i < kShuangseqiuRedCount; i++) {
        _redDanList.add(
          BallNumModel(i+1)
        );
      }
    }
    if(_redTuoList.length == 0) {
      for (var i = 0; i < kShuangseqiuRedCount; i++) {
        _redTuoList.add(
          BallNumModel(i+1)
        );
      }
    }
    if(_blueDTList.length == 0) {
      for (var i = 0; i < kShuangseqiuBlueCount; i++) {
        _blueDTList.add(
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
      int redCount = 0;
      _redList.forEach((element) {
        if(element.isSelected) redCount++;
      });
      int blueCount = 0;
      _blueList.forEach((element) {
        if(element.isSelected) blueCount++;
      });
      _count = SSQCalculateUtils.calculateMultiple(redCount, blueCount);
    } else {
      int redDanCount = 0;
      _redDanList.forEach((element) {
        if(element.isSelected) redDanCount++;
      });
      int redTuoCount = 0;
      _redTuoList.forEach((element) {
        if(element.isSelected) redTuoCount++;
      });
      int blueDTCount = 0;
      _blueDTList.forEach((element) {
        if(element.isSelected) blueDTCount++;
      });
      _count = SSQCalculateUtils.calculateDantuo(redDanCount, redTuoCount, blueDTCount);
    }
    notifyListeners();
  }

  ///更新已选号码
  Future updateSelectLotterys() async {
    List danshiFromDb = await AppManager.gRepository!.queryLotterys(_lotteryId,0,0);
    if(danshiFromDb.length > 0) {
      _selectLotterys = ShuangseqiuModel.modelListFromDbLotterys(danshiFromDb);
    }

    List fushiFromDb = await AppManager.gRepository!.queryLotterys(_lotteryId,1,0);
    if(fushiFromDb.length > 0) {
      _selectLotterys = ShuangseqiuModel.modelListFromDbLotterys(fushiFromDb);
    } 

    List dantuoFromDb = await AppManager.gRepository!.queryLotterys(_lotteryId,2,0);
    if(dantuoFromDb.length > 0) {
      _selectLotterys = ShuangseqiuModel.modelListFromDbLotterys(dantuoFromDb);
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
      List<BallNumModel> redSelectList = [];
      _redList.forEach((element) {
        if(element.isSelected) redSelectList.add(element);
      });
      List<BallNumModel> blueSelectList = [];
      _blueList.forEach((element) {
        if(element.isSelected) blueSelectList.add(element);
      });
      if(redSelectList.length < kShuangseqiuRedMinSelectCount) {
        HubView.showToast('红球最少选择${kShuangseqiuRedMinSelectCount}个');
        return;
      }
      if(blueSelectList.length == 0) {
        HubView.showToast('请选择蓝球');
        return;
      }
      Map<String, dynamic> data = {
        'redBalls': _getList(redSelectList),
        'blueBalls': _getList(blueSelectList)
      };
      if(_selectLotterys.length > 0) {
        bool isCurrentDanshi = (redSelectList.length == 6 && blueSelectList.length == 1);
        if(isCurrentDanshi) {
          if(hasExistDanshi) {
            if(_selectLotterys.length >= 5) {
              _showChooseAlert('单式最多只能选择5注',);
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
            for (ShuangseqiuModel item in _selectLotterys) {
              await AppManager.gRepository!.deleteLottery(item.id!);
            }
          } else if (hasExistDantuo) {
            _showChooseAlert('当前已选号码是胆拖,是否改为复式？', data: data, type: 1);
            return;
          }
          _insertData(data, 1);
        }
      } else {
        bool isCurrentDanshi = (redSelectList.length == 6 && blueSelectList.length == 1);
        _insertData(data, isCurrentDanshi?0:1);
      }
    } else {
      //胆拖处理
      List<BallNumModel> redDanSelectList = [];
      _redDanList.forEach((element) {
        if(element.isSelected) redDanSelectList.add(element);
      });
      List<BallNumModel> redTuoSelectList = [];
      _redTuoList.forEach((element) {
        if(element.isSelected) redTuoSelectList.add(element);
      });
      List<BallNumModel> blueDTSelectList = [];
      _blueDTList.forEach((element) {
        if(element.isSelected) blueDTSelectList.add(element);
      });
      if(redDanSelectList.length < 1) {
        HubView.showToast('请选择红球-胆');
        return;
      }
      int redTuoNeedSelectCount = kShuangseqiuRedMinSelectCount - redDanSelectList.length;
      if(redTuoSelectList.length < redTuoNeedSelectCount) {
        HubView.showToast('红球-拖需要选择${redTuoNeedSelectCount}个');
        return;
      }
      if(blueDTSelectList.length == 0) {
        HubView.showToast('请选择蓝球');
        return;
      }
      Map<String, dynamic> data = {
        'danBalls': _getList(redDanSelectList),
        'redBalls': _getList(redTuoSelectList),
        'blueBalls': _getList(blueDTSelectList)
      };
      if (hasExistDanshi) {
        _showChooseAlert('当前已选号码是单式,是否改为胆拖？', data: data, type: 2);
        return;
      }
      if (hasExistFushi) {
        _showChooseAlert('当前已选号码是复式,是否改为胆拖？', data: data, type: 2);
        return;
      }
      for (ShuangseqiuModel item in _selectLotterys) {
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
          for (ShuangseqiuModel item in _selectLotterys) {
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
      ShuangseqiuPage(businessId!, _lotteryId, isNumKeep:true)
    ).then((value) {
      _setCurrentSelected(datas);
    });
  }

  Map<String, List<int>> _getCurrentSelected() {
    Map<String, List<int>> datas = {};  
    datas['redList'] = _getSelectedList(_redList);
    datas['blueList'] = _getSelectedList(_blueList);
    datas['redDanList'] = _getSelectedList(_redDanList);
    datas['redTuoList'] = _getSelectedList(_redTuoList);
    datas['blueDTList'] = _getSelectedList(_blueDTList);
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
      List<BallNumModel> redSelectList = [];
      _redList.forEach((element) {
        if(element.isSelected) redSelectList.add(element);
      });
      List<BallNumModel> blueSelectList = [];
      _blueList.forEach((element) {
        if(element.isSelected) blueSelectList.add(element);
      });
      if(redSelectList.length < kShuangseqiuRedMinSelectCount) {
        HubView.showToast('红球最少选择${kShuangseqiuRedMinSelectCount}个');
        return;
      }
      if(blueSelectList.length == 0) {
        HubView.showToast('请选择蓝球');
        return;
      }
      Map<String, dynamic> data = {
        'redBalls': _getList(redSelectList),
        'blueBalls': _getList(blueSelectList)
      };
      bool isCurrentDanshi = (redSelectList.length == 6 && blueSelectList.length == 1);
      if(isCurrentDanshi) {
        _insertKeepData(data, 0);
      } else {
        _insertKeepData(data, 1);
      }
    } else {
      //胆拖处理
      List<BallNumModel> redDanSelectList = [];
      _redDanList.forEach((element) {
        if(element.isSelected) redDanSelectList.add(element);
      });
      List<BallNumModel> redTuoSelectList = [];
      _redTuoList.forEach((element) {
        if(element.isSelected) redTuoSelectList.add(element);
      });
      List<BallNumModel> blueDTSelectList = [];
      _blueDTList.forEach((element) {
        if(element.isSelected) blueDTSelectList.add(element);
      });
      if(redDanSelectList.length < 1) {
        HubView.showToast('请选择红球-胆');
        return;
      }
      int redTuoNeedSelectCount = kShuangseqiuRedMinSelectCount - redDanSelectList.length;
      if(redTuoSelectList.length < redTuoNeedSelectCount) {
        HubView.showToast('红球-拖需要选择${redTuoNeedSelectCount}个');
        return;
      }
      if(blueDTSelectList.length == 0) {
        HubView.showToast('请选择蓝球');
        return;
      }
      Map<String, dynamic> data = {
        'danBalls': _getList(redDanSelectList),
        'redBalls': _getList(redTuoSelectList),
        'blueBalls': _getList(blueDTSelectList)
      };
      _insertKeepData(data, 2);
    }
  }

  Future<List<ShuangseqiuModel>> getAllNumKeep() async {
    List danshiFromDb = await AppManager.gRepository!.queryLotterys(_lotteryId,0,1);
    List fushiFromDb = await AppManager.gRepository!.queryLotterys(_lotteryId,1,1);
    List dantuoFromDb = await AppManager.gRepository!.queryLotterys(_lotteryId,2,1);
    List allListFromDb = danshiFromDb + fushiFromDb + dantuoFromDb;
    List<ShuangseqiuModel> results = ShuangseqiuModel.modelListFromDbLotterys(allListFromDb);
    return results;
  }

  void selectNumKeep(ShuangseqiuModel model) async {
    AppNavigator.goBack(App.context!);
    Map<String, dynamic> data = {};
    if (model.type == 2) {
      data = {
        'danBalls': model.danBalls,
        'redBalls': model.redBalls,
        'blueBalls': model.blueBalls
      };
    } else {
      data = {
        'redBalls': model.redBalls,
        'blueBalls': model.blueBalls
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
          for (ShuangseqiuModel item in _selectLotterys) {
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
    _redList.forEach((element) {
      element.isSelected = datas['redList']!.contains(element.number);
    });
    _blueList.forEach((element) {
      element.isSelected = datas['blueList']!.contains(element.number);
    });
    _redDanList.forEach((element) {
      element.isSelected = datas['redDanList']!.contains(element.number);
    });
    _redTuoList.forEach((element) {
      element.isSelected = datas['redTuoList']!.contains(element.number);
    });
    _blueDTList.forEach((element) {
      element.isSelected = datas['blueDTList']!.contains(element.number);
    });
    updateCount();
    notifyListeners();
  }

  ///根据id删除已选号码
  Future deleteLotterys(List<ShuangseqiuModel> list) async {
    for (ShuangseqiuModel item in list) {
      await AppManager.gRepository!.deleteLottery(item.id!);
    }
    updateSelectLotterys();
    NotificationCenter.instance.postNotification(NotificationDefine.selectedNumUpdate);
    NotificationCenter.instance.postNotification(NotificationDefine.numKeepUpdate);
  }

  void resetAllNum() {
    _redList.forEach((element) {
      element.isSelected = false;
    });
    _blueList.forEach((element) {
      element.isSelected = false;
    });
    _redDanList.forEach((element) {
      element.isSelected = false;
    });
    _redTuoList.forEach((element) {
      element.isSelected = false;
    });
    _blueDTList.forEach((element) {
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